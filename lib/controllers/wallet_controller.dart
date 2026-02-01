import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/walllet_providers.dart';

class WalletController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<void> addWalletBalance(double amount) async {
    state = AsyncValue.loading();

    final result = await ref
        .read(walletServiceProvider)
        .addWalletBalance(amount);

    result.fold(
      (failure) {
        state = AsyncValue.error(failure.message, StackTrace.current);
      },
      (success) {
        ref
            .read(authStateChangesProvider.notifier)
            .updateUserWalletBalance(amount);
        state = AsyncValue.data(success);
      },
    );
  }
}
