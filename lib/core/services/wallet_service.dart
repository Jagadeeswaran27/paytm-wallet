import 'package:fpdart/fpdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/models/errors/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletService {
  WalletService._();

  static final WalletService instance = WalletService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Either<Failure, void>> addWalletBalance(int amount) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        return left(Failure('User not found'));
      }

      final userId = user.uid;

      await _firestore.collection('users').doc(userId).update({
        'walletBalance': FieldValue.increment(amount),
      });

      return right(null);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
