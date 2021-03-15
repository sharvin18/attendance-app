import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubClass extends StatefulWidget {
  final String course;
  final String subject;

  SubClass(this.course, this.subject);

  @override
  _SubClassState createState() => _SubClassState();
}

class _SubClassState extends State<SubClass> {
  final database = FirebaseFirestore.instance;
  List detail = [];

  Widget TopBar() {
    return SafeArea(
      child: Container(
        height: 55.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              iconSize: 30,
              onPressed: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 10, 0.0),
              child: Center(
                  child: Text('Class Details',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25))),
            ),
            IconButton(
              icon: Icon(Icons.camera_alt_outlined),
              iconSize: 30,
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 30, 0.0),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detail = widget.course.split("-");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 25,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Class Details',
          style: TextStyle(
              fontFamily: "Medium", fontSize: 22
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt_outlined),
            iconSize: 25,
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 20, 0.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Text(
                      "Batch:  ${widget.course}",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Medium"
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Text(
                        "Subject:  ${widget.subject}",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Medium"
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Divider(color: Color(0XFFDADADA), height: 1),
              SizedBox(height: 15),
              Text(
                "Students",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Medium"
                )
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(detail[1].toLowerCase())
                          .doc(detail[0])
                          .collection('students')
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
                              padding: const EdgeInsets.only(top: 100),
                              child: Center(
                                child: Text(
                                  'No Details Available',
                                  style: TextStyle(
                                    fontFamily: "Medium",
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ) : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            Divider(height: 30),
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      DocumentSnapshot studentlist = snapshot.data.docs[index];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            studentlist.data()['name'],
                                            style: TextStyle(
                                              fontFamily: "Regular",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.0,
                                            ),
                                          ),Text(
                                            studentlist.data()['id'],
                                            style: TextStyle(
                                              fontFamily: "Regular",
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ],
                                      );
                                      // return Card(
                                      //   margin: EdgeInsets.all(10),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.all(10.0),
                                      //     child: Column(
                                      //       children: [
                                      //         Text(studentlist.data()['id']+' - '+studentlist.data()['name']),
                                      //         Text(studentlist.data()['phone']+' - '+studentlist.data()['year'].toString()),
                                      //
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                    }),
                              ),
                            );
                        } //switch case
                      } // builder
                      ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
