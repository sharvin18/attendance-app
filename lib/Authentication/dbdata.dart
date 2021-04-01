import 'package:attendance_app/Helpers/widgets.dart';
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


Future markAttendance(List attend, String branch, String yr, String sub, var date) async {
  return await FirebaseFirestore.instance.
    collection(branch).
    doc(yr).
    collection(sub).
    doc().set({
      'present_students': attend,
      'date': date,
  });
}

Future<List> getStudents(String year, String branch) async {
  List studentDetail = [];
  List studentName = [];
  List studentRoll = [];
  List studentId = [];
  await FirebaseFirestore.instance
      .collection(branch)
      .doc(year)
      .collection('students')
      .orderBy('roll', descending: false)
      .get().then((querySnapshot){
          querySnapshot.docs.forEach((result) {
            studentName.add(result.data()['name']);
            studentRoll.add(result.data()['roll']);
            studentId.add(result.data()['id']);
          });
        });
  studentDetail.add(studentName);
  studentDetail.add(studentRoll);
  studentDetail.add(studentId);
  return studentDetail;
}

Future<List> getDates(String year, String branch, String sub, var startDate, var endDate) async {
  var date;
  List lecs =[];
  List dates = [];
  List lecDetails = [];

  await FirebaseFirestore.instance
      .collection(branch)
      .doc(year)
      .collection(sub)
      .orderBy('date', descending: false)
      .get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {

      date = result.data()['date'];

      if(date.compareTo(startDate)>=0 && date.compareTo(endDate)<=0){
        lecs.add(result.data()['present_students']);
        dates.add(getFormattedDate(date));
      }
    });
  });
  lecDetails.add(dates);
  lecDetails.add(lecs);
  return lecDetails;
}
