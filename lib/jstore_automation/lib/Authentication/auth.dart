import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dbdata.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
=======
>>>>>>> version-upgrade

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

<<<<<<< HEAD
  String imageUrl;
  String userName;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
=======
  late String imageUrl;
  late String userName;

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication =
    await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
>>>>>>> version-upgrade
    );

    final UserCredential authResult =
    await _auth.signInWithCredential(credential);
<<<<<<< HEAD
    final User user = authResult.user;
=======
    final User? user = authResult.user;
>>>>>>> version-upgrade
    loading = true;

    if (user != null) {
      // Checking if email and name is null

      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

<<<<<<< HEAD
      imageUrl = user.photoURL;
      userName = user.displayName;
=======
      imageUrl = user.photoURL!;
      userName = user.displayName!;
>>>>>>> version-upgrade

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

<<<<<<< HEAD
      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
=======
      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser?.uid);
>>>>>>> version-upgrade

      await FirebaseFirestore.instance.collection("teachers").
      doc(user.uid)
          .get()
          .then((value) =>{
        value.exists == true?
<<<<<<< HEAD
        print("exists") : addTeacher(user.uid, user.displayName, user.email, user.photoURL)});
      //await addTeacher(user.uid, user.displayName, user.email, user.photoURL);
      print('signInWithGoogle succeeded: $user');

      return '${user.uid}';
    }

    return null;
=======
        print("exists") : addTeacher(user.uid, user.displayName!, user.email!, user.photoURL!)});
      //await addTeacher(user.uid, user.displayName, user.email, user.photoURL);
      print('signInWithGoogle succeeded: $user');

      return user.uid;
    }

    return "No user exists";
>>>>>>> version-upgrade
  }

  Future<void> signOutGoogle() async {
    loading = true;
    await googleSignIn.signOut();
  }
}