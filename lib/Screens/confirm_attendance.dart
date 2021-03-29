import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:attendance_app/Screens/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class ConfirmAttendance extends StatefulWidget {
  final List attendance;
  final String branch;
  final String subject;
  ConfirmAttendance(this.attendance, this.branch, this.subject);
  @override
  _ConfirmAttendanceState createState() => _ConfirmAttendanceState();
}

class _ConfirmAttendanceState extends State<ConfirmAttendance> {
  var date = new DateFormat.yMd().format(new DateTime.now());
  String newDate = "";
  List details = [];
  List dateFormat = [];
  List correctDate = [];
  bool _loading = false;

  final snackBar = SnackBar(
    backgroundColor: Colors.black.withOpacity(0.8),
    content: Text(
      "No Student present!",
      style: TextStyle(
        fontFamily: "Medium",
      ),
    ),
    duration: Duration(seconds: 2),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    details = widget.branch.split("-");
    dateFormat = date.split("/");
    correctDate.add(dateFormat[1]);
    correctDate.add(dateFormat[0]);
    correctDate.add(dateFormat[2]);
    newDate = correctDate.join("-");
    _loading = false;
    print(newDate);
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _loading ? Loading("Saving Attendance ...") :
    Scaffold(
      body: Stack(
        children: [
          customContainer(height, width),
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: SafeArea(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, top:5.0),
                              child: Text(
                                  'Confirm Attendance',
                                  style: TextStyle(
                                      fontFamily: "Medium",
                                      fontSize: 24.0,
                                      color: Colors.white
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:5.0),
                              child: IconButton(
                                  icon: Icon(Icons.done_sharp, color: Colors.white, size: 28),
                                  onPressed: () async {
                                    if(widget.attendance.length > 0){
                                      setState(()=> _loading = true);
                                      await markAttendance(widget.attendance, details[1].toLowerCase(), details[0], newDate);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context)=>Home()),
                                              (route) => false);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }

                                  }
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 28.0,),
                Container(
                  height: height - 105,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0, right:20.0),
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(details[1].toLowerCase())
                                  .doc(details[0])
                                  .collection('students')
                                  .orderBy('roll', descending: false)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error in Connection ${snapshot.error}');
                                }
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 100.0),
                                      child: Center(
                                        child: SpinKitChasingDots(
                                          color: Colors.blue[600],
                                          size: 30.0,
                                        ),
                                      ),
                                    );
                                  case ConnectionState.none:
                                    return Text('No Data Available');

                                  case ConnectionState.done:
                                    return Text('Connection State Done');

                                  default:
                                    return widget.attendance.length == 0? Padding(
                                      padding: const EdgeInsets.only(top: 80),
                                      child: Center(
                                        child: Text(
                                          'No student is present',
                                          style: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ) : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                      child: Container(
                                        child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: snapshot.data.docs.length,
                                            itemBuilder: (BuildContext context, index) {

                                              DocumentSnapshot studentlist = snapshot.data.docs[index];

                                              return widget.attendance.contains(studentlist.data()['id']) ? Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${studentlist.data()['roll']}. ",
                                                            style: TextStyle(
                                                              fontFamily: "Regular",
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                          Text(
                                                            studentlist.data()['name'],
                                                            style: TextStyle(
                                                            fontFamily: "Regular",
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 20.0,
                                                            ),
                                                          )
                                                        ],
                                                      ),Text(
                                                        studentlist.data()['id'],
                                                        style: TextStyle(
                                                          fontFamily: "Regular",
                                                          fontSize: 20.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.0,),
                                                  Divider(height: 30),
                                                ],
                                              ): Container();
                                            }),
                                      ),
                                    );
                                } //switch case
                              } // builder
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
