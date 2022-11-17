import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/camScan.dart';
import 'package:marku/Screens/excelsheet.dart';
import 'package:marku/Screens/students.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List temp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;

  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
          children: [
            customContainer(h, w),
            Container(
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: SafeArea(
                        child: Container(
                          height: 60,
                          width: w,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.menu_rounded, color: Colors.white, size: 28.0,),
                                          onPressed: (){
                                            _scaffoldKey.currentState?.openDrawer();
                                          }
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left:10.0, top:5.0),
                                        child: Text(
                                            'MarkU',
                                            style: TextStyle(
                                              fontFamily: "Medium",
                                              fontSize: 24.0,
                                              color: Colors.white,
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 28.0,),
                  const SizedBox(
                    height:30,
                    child: Text(
                        'Manage The Attendance',
                        style: TextStyle(
                          fontFamily: "Bold",
                          fontSize: 20.0,
                          color:Colors.white,
                        )
                    ),
                  ),
                  const SizedBox(height: 35.0,),
                  Container(
                    //height: h - 153,
                    //height: height - 165,
                    height: h - 177,
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(40.0)),
                      color: bgColor,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left:20.0, right:20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => CamScan([]))
                                    );
                                  },
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [cardDark, cardLight],
                                        stops:const [0.0, 0.6],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                                          topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.camera_alt,
                                                  size: 50.0,
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 5.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  "Take attendance",
                                                  style: const TextStyle(
                                                    fontFamily: "Medium",
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // DateTime d = DateTime(2022, 11, 16, 12, 11, 20, 20, 200);
                                  // // DateTime d = DateTime.now();
                                  // print(d);
                                  // await markAttendance([["19113101", d], ["191183101", "16 November 2022 at 12:09:03 UTC+5:30"]], "20221116");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => StudentDetails("SE-COMPS", "AOA"))
                                  );
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [cardDark, cardLight],
                                      stops:const [0.0, 0.6],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                                        topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.account_circle_rounded,
                                              size: 50.0,
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Get Student Details",
                                              style: const TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14.0,
                                                color: Colors.black,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: GestureDetector(
                                onTap: () async {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => ExcelSheet())
                                  // );
                                },
                                child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [cardDark, cardLight],
                                      stops:const [0.0, 0.6],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                                        topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.date_range_outlined, color: iconColor, size: 50,),
                                          ],
                                        ),
                                        const SizedBox(height: 5.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Generate Attendance",
                                              style: const TextStyle(
                                                fontFamily: "Medium",
                                                fontSize: 14.0,
                                                color: Colors.black,
                                              ),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                ]
              )
            )
          ]
      ),
      drawer: DrawerWidget(),
    );
  }
}