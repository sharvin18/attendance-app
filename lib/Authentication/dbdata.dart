import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:marku/Helpers/widgets.dart';

import '../Helpers/utils.dart';

// App constants
String name="", email="", profileimg="", themeColor="";
bool existence=false;
bool loading=false;
int total=0;

// Firestore constants
String studentCollection="student";
String attendanceCollection = "attendance-records";

Future<void> addTeacher(String uid, String name, String email, String profileimg) async {
  return await FirebaseFirestore.instance.collection("teachers").doc(uid).set({
    'name': name,
    'email': email,
    'profileimg': profileimg,
    'theme': "white",
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
          themeColor = value.get('theme');
          existence=value.exists;
        }else{
          print("SOMETHING IS WRONG");
        }

      });
  print("GET TEACHER CORE FUNCTION DONE");
}

// Client update
// Total students to be displayed in student details section
Future<int> getTotalStudents()async {
  total = await FirebaseFirestore.instance
      .collection('products')
      .snapshots()
      .length;

  return total;
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

// Client update
// Used on Student details page
Future<List> getStudents(String year, String branch) async {

  List studentDetail = [];
  List studentName = [];
  List studentPhone = [];
  List parentPhone = [];
  List studentId = [];

  await FirebaseFirestore.instance
      .collection(studentCollection)
      .get().then((querySnapshot){
    for (var result in querySnapshot.docs) {
      studentName.add(result.data()['name']);
      studentId.add(result.data()['id']);
      studentPhone.add(result.data()['studPhone']);
      parentPhone.add(result.data()['parentPhone']);
    }
  });

  studentDetail.add(studentName);
  studentDetail.add(studentId);
  studentDetail.add(studentPhone);
  studentDetail.add(parentPhone);

  return studentDetail;
}

// client updates pending .. halfway through!
// Future<dynamic> getAttendance(var startDate, var endDate) async {
//   List<List<String>> attendance = [];
//   int i=1;
//   String rec = "record";
//
//   attendance = await FirebaseFirestore.instance
//       .collection(attendanceCollection)
//       .get().then((querySnapshot) {
//     for (var result in querySnapshot.docs) {
//
//       if(date.compareTo(startDate)>=0 && date.compareTo(endDate)<=0){
//         lecs.add(result.data()['present_students']);
//         dates.add(getFormattedDate(date));
//       }
//
//       rec = rec + i.toString();
//       attendance.add(result.data()[rec]);
//     }
//
//   return attendance;
// }

// Client update:
// Used in confirm attendance page to check the 30min time rule.
Future<List<List>> getInvalidIds(List<List> attendance, String date) async {
  List<List> invalids = [];    // invalids = 2dList -> 0->ids, 1->names
  List invalid = [];
  List ids=[];
  late DateTime datetime;
  print("Entered in db query: ");
  print("Intial attendance list: " + attendance.toString());
  // Check if id is present in student collection
  await FirebaseFirestore.instance
      .collection(studentCollection)
      .get().then((querySnapshot){
    for (var result in querySnapshot.docs) {
      ids.add(result.data()["id"]);
    }
  });

  for(int i=0; i<attendance.length; i++){
    if(!ids.contains(attendance[i][0])) invalid.add(attendance[i][0]);
  }
  // Removing the invalid data from list
  List<List> att = [];
  for(int i=0; i<attendance.length; i++){
    if(!invalid.contains(attendance[i][0])) {
      List temp = attendance[i];
      att.add(temp);
    }
  }
  attendance = att;
  print("Removed invalid students: " + attendance.toString());

  await FirebaseFirestore.instance
      .collection(attendanceCollection)
      .doc(date).get()
      .then((docSnapshot) => {
      if (docSnapshot.exists) {
        for(int i=0; i<attendance.length; i++){
          if(docSnapshot.data()!.containsKey(attendance[i][0])){
            datetime = docSnapshot.data()![attendance[i][0]]["in"],
            if (!isValidAttendance(datetime, attendance[i][1])){
              invalid.add(attendance[i][0])
            }
          }
        }
          // Add 30min rule logic here
          // If id is present and diff in time is < 30mins, then add id to invalids.
          // Else continue;
      }

  });

  await FirebaseFirestore.instance
      .collection(studentCollection)
      .get().then((querySnapshot){
    for (var result in querySnapshot.docs) {
      if (invalid.contains!(result.data()["id"])){
        List temp = [];
        temp.add(result.data()["id"]);
        temp.add(result.data()["name"]);
        invalids.add(temp);
      }
    }
  });
  print("Invalids: " + invalids.toString());
  return invalids;
}