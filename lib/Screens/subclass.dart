import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'camscan.dart';

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
                    preferredSize: Size.fromHeight(60),
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
                                        Navigator.of(context).pop();
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
                SizedBox(height: 20),
                Container(
                  height: 20,
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
                SizedBox(height: 10),
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
                SizedBox(height: 33.0,),
                Container(
                  //height: h - 173,
                  //height: h - 190,
                  height: h - 197,
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
                                  return snapshot.data.docs.length == 0? Padding(
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
                                          itemCount: snapshot.data.docs.length,
                                          itemBuilder: (BuildContext context, index) {

                                            DocumentSnapshot studentlist = snapshot.data.docs[index];
                                            ids.add(studentlist.data()['id']);

                                            return GestureDetector(
                                              onLongPress: (){
                                                launch("tel:" + studentlist.data()['phone'].toString());
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
