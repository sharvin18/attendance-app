import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String name,email,profileimg,total="0";
List subjects,year;
bool existence;
bool loading;

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


Future<String> getTotalStudents(String branch, String year)async{
  await FirebaseFirestore.instance.
    collection(branch).
    doc(year).
    get().
    then((val)=>total = val.get('total_students'));
  print(total);
}

// Future getStudentDetails(String id, String branch, String yr) async {
//   List details = [];
//   await FirebaseFirestore.instance.
//     collection(branch).
//     doc(yr).collection("students").doc(id).get().then(
//       (value){
//         details.add(value.get('name'));
//         details.add(value.get('roll'));
//         details.add(value.get('id'));
//       }
//   );
// }

Future markAttendance(List attend, String branch, String yr, var date) async {
  return await FirebaseFirestore.instance.
    collection(branch).
    doc(yr).
    collection("Attendance").
    doc(date).set({
      'present_students': attend,
      'date': date,
  });
}
