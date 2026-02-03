import 'package:fpdart/fpdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/models/errors/failure.dart';

class PaymentService {
  PaymentService._();

  static final PaymentService instance = PaymentService._();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, void>> sendMoney({required double amount}) async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        return left(Failure('User not found'));
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        return left(Failure('User not found'));
      }

      final userData = doc.data()!;
      final balance = userData['walletBalance'] as double;
      if (balance < amount) {
        return left(Failure('Insufficient balance'));
      }

      await _firestore.collection('users').doc(user.uid).update({
        'walletBalance': balance - amount,
      });

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
