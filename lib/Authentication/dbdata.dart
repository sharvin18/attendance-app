import 'package:marku/Helpers/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';

String name="",email="",profileimg="",total="0",themeColor="";
List subjects=[],year=[];
bool existence=false;
bool loading=false;

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
}


Future<String> getTotalStudents(String branch, String year)async {
  return await FirebaseFirestore.instance.
  collection(branch).
  doc(year).
  get().
  then((val) => total = val.get('total_students'));
  // print(total);
}

Future changeTheme(String newTheme) async {
  return await FirebaseFirestore.instance
      .collection("teachers")
      .doc(FirebaseAuth.instance.currentUser?.uid)
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
    for (var result in querySnapshot.docs) {
      studentName.add(result.data()['name']);
      studentRoll.add(result.data()['roll']);
      studentId.add(result.data()['id']);
    }
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
    for (var result in querySnapshot.docs) {

      date = result.data()['date'];

      if(date.compareTo(startDate)>=0 && date.compareTo(endDate)<=0){
        lecs.add(result.data()['present_students']);
        dates.add(getFormattedDate(date));
      }
    }
  });
  lecDetails.add(dates);
  lecDetails.add(lecs);
  return lecDetails;
}

Future<List> getSubjects(String br, String yr) async {
  List subs = [];
  await FirebaseFirestore.instance
                      .collection(br)
                        .where("year", isEqualTo: yr)
                        .get().then((querySnapshot) {
    for (var result in querySnapshot.docs) {
      var data = result.data()['subjects'];
      subs.add(data);
    }
  });
  return subs;
}

Future updateSubject(List sub, List yr) async {
  await FirebaseFirestore.instance
      .collection("teachers")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .update({
    'subjects': sub,
    'year': yr,
  });

  return await FirebaseFirestore.instance
      .collection('teachers')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get()
      .then((value) {
    subjects = value.get('subjects');
    year = value.get('year');
  });

}
