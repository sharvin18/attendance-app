import 'package:marku/Authentication/auth.dart';
import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Screens/about.dart';
import 'package:marku/Screens/settings.dart';
import 'package:marku/Screens/signIn.dart';
import 'package:marku/Screens/excelsheet.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerWidgetState();
  }
}

class DrawerWidgetState extends State<DrawerWidget> {
  AuthServices _auth = new AuthServices();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.85,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Drawer(
        elevation: 8,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 70, right: 20),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 40, 20, 40),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF3a5af9), Color(0xFF7449fa),],
                                stops:[0.0, 0.8],
                              ),
                              //color: Color(0XFF5959fc),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(24.0),
                                  topRight: Radius.circular(24.0))),
                          /*User Profile*/
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                  backgroundImage: NetworkImage(profileimg),
                                  radius: 40),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Bold",
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      email,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Bold",
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> ExcelSheet())
                        );
                      },
                      child: Container(
                        color: bgCardColor,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Row(
                          children: <Widget>[
                            //SvgPicture.asset("assets/images/settings.svg", width: 20, height: 20, color: iconColor,),
                            // Icon(Icons.date_range_outlined, color: iconColor, size: 20,),
                            const SizedBox(width: 20),
                            Text(
                              "Generate Attendance",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Medium",
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Color(0XFFDADADA), height: 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> Settings())
                        );
                      },
                      child: Container(
                        color: bgCardColor,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Row(
                          children: <Widget>[
                            // SvgPicture.asset("assets/images/settings.svg", width: 20, height: 20, color: iconColor,),
                            const SizedBox(width: 20),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Medium",
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Color(0XFFDADADA), height: 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> About())
                        );
                      },
                      child: Container(
                        color: bgCardColor,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Row(
                          children: <Widget>[
                            //SvgPicture.asset("assets/images/settings.svg", width: 20, height: 20, color: iconColor,),
                            // Icon(Icons.update, color: iconColor, size: 20,),
                            const SizedBox(width: 20),
                            Text(
                              "About",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Medium",
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Color(0XFFDADADA), height: 1),
                    //SizedBox(height: 15),
                    GestureDetector(
                      onTap: () async {
                        await _auth.signOutGoogle();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                                (route) => false);
                      },
                      child: Container(
                        color: bgCardColor,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                        child: Row(
                          children: <Widget>[

                            // SvgPicture.asset("assets/images/logout.svg", width: 20, height: 20, color: iconColor,),
                            const SizedBox(width: 20),
                            Text(
                              "Sign Out",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: "Medium",
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
              Column(
                children: [
                  const Divider(color: Color(0XFFDADADA), height: 1),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "2021 \u00a9 GenCoders",
                        style: TextStyle(
                          color: Colors.indigo[500],
                          fontFamily: "Bold",
                          fontSize: 17.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}