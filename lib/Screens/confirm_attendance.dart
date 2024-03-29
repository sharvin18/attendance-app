import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/loading.dart';
import 'package:marku/Screens/Home.dart';
import 'package:marku/Screens/camscan.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class ConfirmAttendance extends StatefulWidget {
  final List attendance;
  final String branch;
  final String subject;
  final List total_id;
  ConfirmAttendance(this.attendance, this.branch, this.subject,this.total_id);
  @override
  _ConfirmAttendanceState createState() => _ConfirmAttendanceState();
}

class _ConfirmAttendanceState extends State<ConfirmAttendance> {
  var date = DateFormat.yMd().format(DateTime.now());
  String storeDate="",displayDate="", strength="";
  List details = [];
  List dateFormat = [];
  List correctDate = [];
  bool _loading = false;

  final snack = SnackBar(
    backgroundColor: Colors.black.withOpacity(0.8),
    content: const Text(
      "No Student present!",
      style: TextStyle(
        fontFamily: "Medium",
      ),
    ),
    duration: const Duration(seconds: 2),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStrength();
    details = widget.branch.split("-");
    storeDate = formatDateAndMonth(date);
    displayDate = getFormattedDate(storeDate);
  }

  getStrength(){
    int totalPresent = widget.attendance.length;
    int totalStrength = widget.total_id.length;
    strength = totalPresent.toString() + "/" + totalStrength.toString();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return _loading ? Loading("Saving Attendance ...") :
    WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            customContainer(h, w),
            Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: SafeArea(
                      child: Container(
                        height: 60,
                        width: w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 28.0,),
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Camscan(widget.total_id,widget.branch,widget.subject,widget.attendance)));
                                    }
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5.0, top:5.0),
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
                                    icon: const Icon(Icons.done_sharp, color: Colors.white, size: 28),
                                    onPressed: () async {
                                      if(widget.attendance.isNotEmpty){
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
                  const SizedBox(height: 20.0,),
                  Container(
                    height: 20.0,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            strength,
                            style: const TextStyle(
                              fontFamily: "Medium",
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Text(
                            displayDate,
                            style: const TextStyle(
                              fontFamily: "Medium",
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  const SizedBox(height: 15.0,),
                  Container(
                    //height: h - 115,
                    //height: h - 105,
                    height: h - 139,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(40.0)),
                      color:bgColor,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0, right:15.0),
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
                                      return const Text('No Data Available');

                                    case ConnectionState.done:
                                      return const Text('Connection State Done');

                                    default:
                                      return widget.attendance.isEmpty? Padding(
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
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Container(
                                          child: ListView.builder(
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: snapshot.data!.docs.length,
                                              itemBuilder: (BuildContext context, index) {

                                                DocumentSnapshot<dynamic> studentlist = snapshot.data!.docs[index];
                                                var id = studentlist.data()['id'];
                                                var roll = studentlist.data()['roll'];
                                                var name = studentlist.data()['name'];


                                                return widget.attendance.contains(id.toString()) ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${roll.toString()}. ",
                                                              style: TextStyle(
                                                                fontFamily: "Regular",
                                                                fontWeight: FontWeight.w500,
                                                                fontSize: 20.0,
                                                                color: textColor,
                                                              ),
                                                            ),
                                                            Text(
                                                              name,
                                                              style: TextStyle(
                                                              fontFamily: "Regular",
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 20.0,
                                                              color: textColor,
                                                              ),
                                                            )
                                                          ],
                                                        ),Text(
                                                          id,
                                                          //studentlist.data()['id'],
                                                          style: TextStyle(
                                                            fontFamily: "Regular",
                                                            fontSize: 20.0,
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5.0,),
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
      ),
    );
  }
}