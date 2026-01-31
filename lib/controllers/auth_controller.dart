import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/models/user_model.dart';
import 'package:app/providers/firebase_providers.dart';
import 'package:app/models/phone_auth_result.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/states/auth_state.dart';

class AuthController extends AsyncNotifier<PhoneAuthState> {
  @override
  PhoneAuthState build() {
    return const PhoneAuthState();
  }

  Future<void> verifyPhoneNumber(String phoneNumber, {int? resendToken}) async {
    state = const AsyncValue.loading();
    try {
      final stream = ref
          .read(authServiceProvider)
          .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            resendToken: resendToken,
          );

      await for (final result in stream) {
        if (result is CodeSent) {
          state = AsyncValue.data(
            PhoneAuthState(
              verificationId: result.verificationId,
              resendToken: result.resendToken,
              phoneNumber: phoneNumber,
            ),
          );
        } else if (result is PhoneAuthError) {
          state = AsyncValue.error(result.message, StackTrace.current);
        }
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<String?> signInWithOtp({required String smsCode}) async {
    final verificationId = state.value?.verificationId;
    if (verificationId == null) return 'Verification ID not found';

    final result = await ref
        .read(authServiceProvider)
        .signInWithOtp(smsCode: smsCode, verificationId: verificationId);

    return result.fold(
      (failure) {
        return failure.message;
      },
      (user) async {
        state = AsyncValue.data(PhoneAuthState(user: user));

        final userProfilePicPath = user.profilePicPath;

        if (userProfilePicPath != null) {
          final imageUrl = await ref
              .read(firebaseStorageServiceProvider)
              .getImageUrlFromPath(userProfilePicPath);

          user = user.copyWith(profilePicPath: imageUrl);
        }

        ref.read(authStateChangesProvider.notifier).updateUserData(user);

        return null;
      },
    );
  }

  Future<void> resendOtp() async {
    final currentToken = state.value?.resendToken;
    final phoneNumber = state.value?.phoneNumber;
    if (currentToken == null || phoneNumber == null) {
      return;
    }
    await verifyPhoneNumber(phoneNumber, resendToken: currentToken);
  }

  Future<UserModel?> getCurrentUser() async {
    final result = await ref.read(authServiceProvider).getCurrentUser();
    return result.fold(
      (failure) {
        return null;
      },
      (user) {
        return user;
      },
    );
  }

  Future<void> signOut() async {
    final result = await ref.read(authServiceProvider).signOut();
    return result.fold(
      (failure) {
        return;
      },
      (user) {
        state = const AsyncValue.data(PhoneAuthState());
        return;
      },
    );
  }
}
