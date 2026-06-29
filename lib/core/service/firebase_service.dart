import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<UserModel?> getCurrentUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    print("UID: $uid");

    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    print("Document exists: ${doc.exists}");
    print("Document data: ${doc.data()}");

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return UserModel.formMap(doc.data()!);
  }
}