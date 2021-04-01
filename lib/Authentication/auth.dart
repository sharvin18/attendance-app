import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dbdata.dart';
import 'package:flutter/material.dart';

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String imageUrl;
  String userName;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    loading = true;

    if (user != null) {
      // Checking if email and name is null

      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      imageUrl = user.photoURL;
      userName = user.displayName;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      await FirebaseFirestore.instance.collection("teachers").
      doc(user.uid)
          .get()
          .then((value) =>{
        value.exists == true?
        print("exists") : addTeacher(user.uid, user.displayName, user.email, user.photoURL)});
      //await addTeacher(user.uid, user.displayName, user.email, user.photoURL);
      print('signInWithGoogle succeeded: $user');

      return '${user.uid}';
    }

    return null;
  }

  Future<void> signOutGoogle() async {
    loading = true;
    await googleSignIn.signOut();
  }
}