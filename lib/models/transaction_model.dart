import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:app/models/enums/payment_type.dart';

class TransactionModel {
  String id;
  double amount;
  PaymentType paymentType;
  String? sourceCardId;
  String destinationUpiId;
  Timestamp timestamp;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.paymentType,
    required this.destinationUpiId,
    required this.timestamp,
    this.sourceCardId,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      amount: map['amount'],
      paymentType: PaymentType.values.firstWhere(
        (e) => e.name == map['paymentType'],
      ),
      destinationUpiId: map['destinationUpiId'],
      timestamp: map['timestamp'],
      sourceCardId: map['sourceCardId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'paymentType': paymentType.name,
      'destinationUpiId': destinationUpiId,
      'timestamp': timestamp,
      'sourceCardId': sourceCardId,
    };
  }

  TransactionModel copyWith({
    String? id,
    double? amount,
    PaymentType? paymentType,
    String? destinationUpiId,
    Timestamp? timestamp,
    String? sourceCardId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentType: paymentType ?? this.paymentType,
      destinationUpiId: destinationUpiId ?? this.destinationUpiId,
      timestamp: timestamp ?? this.timestamp,
      sourceCardId: sourceCardId ?? this.sourceCardId,
    );
  }
}
