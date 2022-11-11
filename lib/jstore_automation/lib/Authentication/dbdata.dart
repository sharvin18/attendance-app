<<<<<<< HEAD
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

String name,email,profileimg,total="0",themeColor;
List subjects,year;
bool existence;
bool loading;
=======
import 'package:marku/Helpers/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

String name="",email="",profileimg="",total="0",themeColor="";
List subjects=[],year=[];
bool existence=false;
bool loading=false;
>>>>>>> version-upgrade

Future<void> addTeacher(String uid, String name, String email, String profileimg) async {
  return await FirebaseFirestore.instance.collection("teachers").doc(uid).set({
    'name': name,
    'email': email,
    'profileimg': profileimg,
    'theme': "white",
    'subjects': [],
    'year': [],
  });
}

Future getTeacher() async {
<<<<<<< HEAD
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
      themeColor = value.get('theme');
      existence=value.exists;
    });
  } catch (e) {}

=======
  print("getTeacher method invoked");
  await FirebaseFirestore.instance
      .collection('teachers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) {

        if(value.exists == true){
          name = value.get('name');
          email = value.get('email');
          profileimg = value.get('profileimg');
          subjects = value.get('subjects');
          year = value.get('year');
          themeColor = value.get('theme');
          existence=value.exists;
        }else{
          print("SOMETHING IS WRONG");
        }

      });
  print("GET TEACHER CORE FUNCTION DONE");
>>>>>>> version-upgrade
}


Future<String> getTotalStudents(String branch, String year)async {
<<<<<<< HEAD
  await FirebaseFirestore.instance.
=======
  return await FirebaseFirestore.instance.
>>>>>>> version-upgrade
  collection(branch).
  doc(year).
  get().
  then((val) => total = val.get('total_students'));
<<<<<<< HEAD
  print(total);
=======
  // print(total);
>>>>>>> version-upgrade
}

Future changeTheme(String newTheme) async {
  return await FirebaseFirestore.instance
      .collection("teachers")
<<<<<<< HEAD
      .doc(FirebaseAuth.instance.currentUser.uid)
=======
      .doc(FirebaseAuth.instance.currentUser?.uid)
>>>>>>> version-upgrade
      .update({
    'theme': newTheme,
  });
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
<<<<<<< HEAD
    querySnapshot.docs.forEach((result) {
      studentName.add(result.data()['name']);
      studentRoll.add(result.data()['roll']);
      studentId.add(result.data()['id']);
    });
=======
    for (var result in querySnapshot.docs) {
      studentName.add(result.data()['name']);
      studentRoll.add(result.data()['roll']);
      studentId.add(result.data()['id']);
    }
>>>>>>> version-upgrade
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
<<<<<<< HEAD
    querySnapshot.docs.forEach((result) {
=======
    for (var result in querySnapshot.docs) {
>>>>>>> version-upgrade

      date = result.data()['date'];

      if(date.compareTo(startDate)>=0 && date.compareTo(endDate)<=0){
        lecs.add(result.data()['present_students']);
        dates.add(getFormattedDate(date));
      }
<<<<<<< HEAD
    });
=======
    }
>>>>>>> version-upgrade
  });
  lecDetails.add(dates);
  lecDetails.add(lecs);
  return lecDetails;
}

Future<List> getSubjects(String br, String yr) async {
  List subs = [];
<<<<<<< HEAD
  final List<DocumentSnapshot> documents = (await FirebaseFirestore.instance
                      .collection(br)
                        .where("year", isEqualTo: yr)
                        .get()).docs;
  documents.forEach((element) {
    subs = element.data()['subjects'];
  });

=======
  await FirebaseFirestore.instance
                      .collection(br)
                        .where("year", isEqualTo: yr)
                        .get().then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      var data = result.data()['subjects'];
      subs.add(data);
    }
  });
>>>>>>> version-upgrade
  return subs;
}

Future updateSubject(List sub, List yr) async {
  await FirebaseFirestore.instance
      .collection("teachers")
<<<<<<< HEAD
      .doc(FirebaseAuth.instance.currentUser.uid)
=======
      .doc(FirebaseAuth.instance.currentUser?.uid)
>>>>>>> version-upgrade
      .update({
    'subjects': sub,
    'year': yr,
  });

  return await FirebaseFirestore.instance
      .collection('teachers')
<<<<<<< HEAD
      .doc(FirebaseAuth.instance.currentUser.uid)
=======
      .doc(FirebaseAuth.instance.currentUser?.uid)
>>>>>>> version-upgrade
      .get()
      .then((value) {
    subjects = value.get('subjects');
    year = value.get('year');
  });

}
