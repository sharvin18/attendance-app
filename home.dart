import 'package:attendance_app/Authentication/auth.dart';
import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Screens/drawer.dart';
import 'package:attendance_app/Screens/loading.dart';
import 'package:attendance_app/Screens/signIn.dart';
import 'package:attendance_app/Screens/subclass.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthServices _auth = new AuthServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 2,
              title: Text(
                "MarkU",
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    // Container(
                    //   child: Text(
                    //       "Welcome " + name,
                    //       style: TextStyle(
                    //         fontFamily: "Bold",
                    //         fontSize: 22.0,
                    //       )
                    //   ),
                    // ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "My Classrooms",
                            style: TextStyle(
                              fontFamily: "Medium",
                              fontSize: 18.0,
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                    subjects.length == 0
                      ? Center(
                          child: Text(
                            'No Subjects Assigned',
                            style: TextStyle(
                              fontFamily: "Bold",
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: subjects.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: GestureDetector(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SubClass(year[index], subjects[index]))
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: index%5==0? [Colors.blue[500], Colors.blue[200]]
                                          : index%4==1?[Colors.green[500], Colors.green[200]]
                                          : index%4==2?[Colors.orange[500], Colors.orange[200]]
                                          : index%4==3?[Colors.red[500], Colors.red[200]]
                                          : [Colors.purple[500], Colors.purple[200]],
                                      stops:[0.0, 0.8],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                    boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20),
                                                child: Text(
                                                    subjects[index],
                                                    style: TextStyle(
                                                      fontFamily: "Medium",
                                                      fontSize: 24.0,
                                                      color: Colors.black54
                                                    )
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                  year[index],
                                                  style: TextStyle(
                                                    fontFamily: "Medium",
                                                    fontSize: 18.0,
                                                    color: Colors.black87
                                                  )
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 5.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                            FractionalTranslation(
                                              translation: Offset(0, -2.4),
                                              child: Container(
                                                width: 170,
                                                height: 40,
                                                child: Center(
                                                    child: Text(
                                                      'Date:',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold),
                                                    )),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: index%5==0? [Colors.blue[500], Colors.blue[200]]
                                                        : index%4==1?[Colors.green[500], Colors.green[200]]
                                                        : index%4==2?[Colors.orange[500], Colors.orange[200]]
                                                        : index%4==3?[Colors.red[500], Colors.red[200]]
                                                        : [Colors.purple[500], Colors.purple[200]],
                                                    stops:[0.0, 0.8],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    border: Border.all(width: 5, color: Colors.white)
                                                  //boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                                  //   color: Colors.redAccent,
                                                  //   borderRadius: BorderRadius.circular(50),
                                                  //   border: Border.all(width: 5, color: Colors.white)
                                                ),
                                              ),
                                            ),
                                                // FractionalTranslation(
                                                //   translation: Offset(0.1, 0.5),
                                                //   child: Container(
                                                //     width: 170,
                                                //     height: 40,
                                                //     child: Center(
                                                //         child: Text(
                                                //           'Total:',
                                                //           style: TextStyle(
                                                //               fontSize: 24,
                                                //               color: Colors.white,
                                                //               fontWeight: FontWeight.bold),
                                                //         )),
                                                //     decoration: BoxDecoration(
                                                //         gradient: LinearGradient(
                                                //           colors: index%5==0? [Colors.blue[500], Colors.blue[200]]
                                                //               : index%4==1?[Colors.green[500], Colors.green[200]]
                                                //               : index%4==2?[Colors.orange[500], Colors.orange[200]]
                                                //               : index%4==3?[Colors.red[500], Colors.red[200]]
                                                //               : [Colors.purple[500], Colors.purple[200]],
                                                //           stops:[0.0, 0.8],
                                                //           begin: Alignment.topLeft,
                                                //           end: Alignment.bottomRight,
                                                //         ),
                                                //         borderRadius: BorderRadius.all(Radius.circular(50)),
                                                //         border: Border.all(width: 5, color: Colors.white)
                                                //       //boxShadow: [BoxShadow(color: Color(0X95E9EBF0), blurRadius: 2, spreadRadius: 2)],
                                                //       //   color: Colors.redAccent,
                                                //       //   borderRadius: BorderRadius.circular(50),
                                                //       //   border: Border.all(width: 5, color: Colors.white)
                                                //     ),
                                                //   ),
                                                // ),
                                            ],
                                          ),

                                      ],
                                    ),
                                  ),
                                )
                              ),
                            );
                          }
                    )
                  ],
                ),
              ),
            ),
      drawer: DrawerWidget(),
    );
  }
}
