import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/providers/payment_providers.dart';
import 'package:app/providers/auth_provider.dart';

class PaymentController extends AsyncNotifier<String?> {
  @override
  String? build() {
    return null;
  }

  Future<void> storeUpiId({required String upiId}) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(upiId);
  }

  Future<void> sendMoney({
    required double amount,
    required String source,
  }) async {
    state = const AsyncValue.loading();

    if (source == 'wallet') {
      final result = await ref
          .read(paymentServiceProvider)
          .sendMoney(amount: amount);

      result.fold(
        (failure) =>
            state = AsyncValue.error(failure.message, StackTrace.current),
        (_) {
          ref
              .read(authStateChangesProvider.notifier)
              .reduceUserWalletBalance(amount);
          state = AsyncValue.data(null);
        },
      );
    } else {
      await Future.delayed(const Duration(seconds: 1));
      state = const AsyncValue.data(null);
    }
  }
}
