import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estallecomerch/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

final PROFILECOLLECTION='profile';

class AuthenticationService{

  final  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  static final Firestore _firestore=Firestore.instance;


  Future<FirebaseUser> get user async=>await _firebaseAuth.currentUser();


  void changePassword(String password) async{
    //Create an instance of the current user.
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //Pass in the password to updatePassword.
    user.updatePassword(password);
  }


   Future<String> login(String email,String password)async{
   final authResult= await  _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
   return authResult.user.uid;

  }

   Future<String> signUp(String email,String password) async{
    final authResut=await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return authResut.user.uid;
  }

  Future<Void> logout() async{
      await _firebaseAuth.signOut();
  }

  static Future addUserProfile(Profile profile) async{
    final doc=_firestore.collection(PROFILECOLLECTION).document(profile.email);
    return await doc.setData(profile.toMap());
  }

  Future updateProfile(Profile profile)async{
     final doc=_firestore.collection(PROFILECOLLECTION).document(profile.email);
     return await doc.updateData(profile.toMap());
  }

   Future<Profile> getUserProfileByEmail(String email)async{
     final docSnapshot=await _firestore.collection(PROFILECOLLECTION).document(email).get();
     return Profile.fromMap(docSnapshot.data);
  }


  Future<void> saveUserPhoneNumberInPreference(String email)async{
    try{
      final prefs=await SharedPreferences.getInstance();
      await prefs.setString('userEmail', email);
    }catch(error){
      throw error;
    }
  }

  static Future<String> getUserPhoneNumberByPreference() async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString('userEmail')??'null';
  }


}