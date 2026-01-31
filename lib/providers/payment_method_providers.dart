import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app/controllers/payment_method_controller.dart';
import 'package:app/models/payment_card.dart';
import 'package:app/core/services/payment_method_service.dart';

final paymentMethodServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService.instance;
});

final paymentMethodControllerProvider =
    AsyncNotifierProvider.autoDispose<PaymentController, List<PaymentCard>>(
      () => PaymentController(),
    );
