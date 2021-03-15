import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String name,email,profileimg;
List subjects,year;
bool existence;

Future<void> addTeacher(String uid, String name, String email, String profileimg) async {
  return await FirebaseFirestore.instance.collection("teachers").doc(uid).set({
    'name': name,
    'email': email,
    'profileimg': profileimg,
    'subjects': ["AOA", "SBL", "DBMS", "EM-IV"],
    'year': ["SE-COMPS", "SE-COMPS", "SE-COMPS", "SE-IT"],
  });
}

Future getTeacher() async {
  try {
    await FirebaseFirestore.instance
        .collection('teachers')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) {
      name = value.get('name');
      email = value.get('email');
      profileimg = value.get('profileimg');
      subjects = value.get('subjects');
      year = value.get('year');
      existence=value.exists;
    });
  } catch (e) {}

}
