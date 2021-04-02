import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
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
  String storeDate="",displayDate="";
  List details = [];
  List dateFormat = [];
  List correctDate = [];
  bool _loading = false;

  final snack = SnackBar(
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
    storeDate = formatDateAndMonth(date);
    displayDate = getFormattedDate(storeDate);
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return _loading ? Loading("Saving Attendance ...") :
    Scaffold(
      body: Stack(
        children: [
          customContainer(h, w),
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(60),
                  child: SafeArea(
                    child: Container(
                      height: 60,
                      width: w,
                      //color: themeColor == "dark" ? bgCardColor : Colors.transparent,
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
                                      await markAttendance(widget.attendance, details[1].toLowerCase(), details[0], widget.subject, storeDate);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context)=>Home()),
                                              (route) => false);
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar("No Student present!", true));
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
                SizedBox(height: 20.0,),
                Container(
                  height: 20.0,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Text(
                          displayDate,
                          style: TextStyle(
                            fontFamily: "Medium",
                            fontSize: 20.0,
                            color: textColor,
                          ),
                        ),
                      )
                    ],
                  )
                ),
                SizedBox(height: 15.0,),
                Container(
                  //height: h - 115,
                  //height: h - 105,
                  height: h - 139,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
                    color:bgColor,
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
                                            color: textColor,
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
                                                              color: textColor,
                                                            ),
                                                          ),
                                                          Text(
                                                            studentlist.data()['name'],
                                                            style: TextStyle(
                                                            fontFamily: "Regular",
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: 20.0,
                                                            color: textColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),Text(
                                                        studentlist.data()['id'],
                                                        style: TextStyle(
                                                          fontFamily: "Regular",
                                                          fontSize: 20.0,
                                                          color: textColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5.0,),
                                                  Divider(height: 30, color: dividerColor,),
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
