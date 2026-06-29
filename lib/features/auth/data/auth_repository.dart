import 'package:bykea_skardu/features/auth/data/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  AuthRepository({required this.auth,required this.firestore});
  Future<void> register(final String name,final String phone,final String password) async{
    print("Name: $name");
    print("Phone: $phone");
    print("Password: $password");

    try{
      final credential=  await auth.createUserWithEmailAndPassword(email: "$phone@bykea.com", password: password);
      print("User Created: ${credential.user?.uid}");
      final user=UserModel(uid: credential.user!.uid, name: name, phone: phone);
      print(user.toJson());
      print("User Created:${user.phone}" );
      await firestore.collection('users').doc(credential.user!.uid).set(user.toJson());
    } on  FirebaseAuthException catch (e){
       print("Code:${e.code}");
       print("Message:${e.message}");
    } catch(e){
      print(e);
    }
  
  }
  Future<void> login( final String phone,final String password) async{
    await auth.signInWithEmailAndPassword(email: "$phone@bykea.com", password: password);
  }
  Future<void> saveRole(final String uid,final String role) async{
    print("repository role:${role}");
    await firestore.collection('users').doc(uid).update({
      'role':role
    });
  }
  Future<void> logout() async{
   await auth.signOut();
  }
}