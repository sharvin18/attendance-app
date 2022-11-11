<<<<<<< HEAD
import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/widgets.dart';
=======
import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/Home.dart';
import 'package:marku/Screens/camscan.dart';
>>>>>>> version-upgrade
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
<<<<<<< HEAD
import 'camscan.dart';
import 'home.dart';
=======
>>>>>>> version-upgrade

class SubClass extends StatefulWidget {
  final String course;
  final String subject;

  SubClass(this.course, this.subject);
  @override
  _SubClassState createState() => _SubClassState();
}

class _SubClassState extends State<SubClass> {
  List detail = [];
  List ids = [];

  callStudent(BuildContext context, String phone, String name) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "No",
        style: TextStyle(
          fontFamily: "Medium",
          fontSize: 18.0,
          color: Colors.red,
        ),
      ),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton =TextButton(
<<<<<<< HEAD
      child: Text(
=======
      child: const Text(
>>>>>>> version-upgrade
        "Yes",
        style: TextStyle(
          fontFamily: "Medium",
          fontSize: 18.0,
          color: Colors.green,
        ),
      ),
      onPressed:  () async {
        Navigator.of(context).pop();
<<<<<<< HEAD
        launch("tel:" + phone);
=======
        String url = "tel:" + phone;
        Uri _url = Uri.parse(url);
        launchUrl(_url);
        // launch("tel:" + phone);
>>>>>>> version-upgrade
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Call"),
      content: Text("Do you want to call ${name}: \n${phone}",
          style: TextStyle(
            fontFamily: "Medium"
          )
      ),
      actions:[
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detail = widget.course.split("-");
    ids = [];
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          customContainer(h, w),
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                PreferredSize(
<<<<<<< HEAD
                    preferredSize: Size.fromHeight(60),
=======
                    preferredSize: const Size.fromHeight(60),
>>>>>>> version-upgrade
                    child: SafeArea(
                      child: Container(
                        height: 60,
                        width: w,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 28.0,),
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                      }
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:10.0, top:5.0),
                                    child: Text(
                                        'Class Details',
                                        style: TextStyle(
                                            fontFamily: "Medium",
                                            fontSize: 22.0,
                                            color: Colors.white
                                        )
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.only(top:5.0),
                                child: IconButton(
                                    icon: Icon(Icons.camera_alt_outlined, color: Colors.white, size: 28),
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Camscan(ids, widget.course, widget.subject, []),
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ),
<<<<<<< HEAD
                SizedBox(height: 20),
=======
                const SizedBox(height: 20),
>>>>>>> version-upgrade
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text(
                            "Batch:  ${widget.course}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Medium",
                              color: Colors.white,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
<<<<<<< HEAD
                SizedBox(height: 10),
=======
                const SizedBox(height: 10),
>>>>>>> version-upgrade
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text(
                            "Subject:  ${widget.subject}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Medium",
                              color: Colors.white,
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:30),
                        child: Text(
                            "Total: " + total,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Medium",
                              color: Colors.white,
                            )
                        ),
                      ),
                    ],
                  ),
                ),
<<<<<<< HEAD
                SizedBox(height: 33.0,),
=======
                const SizedBox(height: 33.0,),
>>>>>>> version-upgrade
                Container(
                  //height: h - 173,
                  //height: h - 190,
                  height: h - 207,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
                    color: bgColor,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left:14.0, right:18.0),
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection(detail[1].toLowerCase())
                                .doc(detail[0])
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
<<<<<<< HEAD
                                  return snapshot.data.docs.length == 0? Padding(
=======
                                  return snapshot.data!.docs.isEmpty? Padding(
>>>>>>> version-upgrade
                                    padding: const EdgeInsets.only(top: 80),
                                    child: Center(
                                      child: Text(
                                        'No Details Available',
                                        style: TextStyle(
                                          fontFamily: "Medium",
                                          fontSize: 20.0,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                  ) : Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Container(
                                      child: ListView.separated(
                                          physics: NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          separatorBuilder: (BuildContext context, int index) =>
                                              Divider(height: 30, color: dividerColor,),
                                          scrollDirection: Axis.vertical,
<<<<<<< HEAD
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (BuildContext context, index) {

                                            DocumentSnapshot studentlist = snapshot.data.docs[index];
=======
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, index) {

                                            DocumentSnapshot<dynamic> studentlist = snapshot.data!.docs[index];
>>>>>>> version-upgrade
                                            ids.add(studentlist.data()['id']);

                                            return GestureDetector(
                                              onLongPress: (){
                                                callStudent(context, studentlist.data()['phone'].toString(), studentlist.data()['name'].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${studentlist.data()['roll']}. ",
                                                        style: TextStyle(
                                                          fontFamily: "Regular",
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18.0,
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
                                            );
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
          ),
        ],
      )
    );
  }
}
