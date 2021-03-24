import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Screens/subclass.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF3a5af9), Color(0xFF7449fa),],
                stops:[0.0, 0.8],
              ),
            ),
          ),
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
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.menu_rounded, color: Colors.white, size: 28.0,),
                                  onPressed: (){
                                    _scaffoldKey.currentState.openDrawer();
                                  }
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:10.0, top:5.0),
                                  child: Text(
                                      'MarkU',
                                      style: TextStyle(
                                          fontFamily: "Medium",
                                          fontSize: 24.0,
                                          color: Colors.white
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:5.0),
                              child: IconButton(
                                icon: Icon(Icons.notifications_none_sharp, color: Colors.white, size: 28),
                                onPressed: (){}
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ),
                SizedBox(height: 28.0,),
                Text(
                  'Manage Your Classrooms',
                    style: TextStyle(
                      fontFamily: "Bold",
                      fontSize: 20.0,
                      color: Colors.white
                    )
                ),
                SizedBox(height: 35.0,),
                Container(
                  height: height - 165,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40.0)),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left:16.0, right:20.0),
                      child: Column(
                        children: [
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
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                      onTap: () async {
                                        List detail = year[index].split("-");
                                        await getTotalStudents(detail[1].toLowerCase(),detail[0]);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SubClass(year[index], subjects[index]))
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: index%4==0? [Colors.blue[500], Colors.blue[200]]
                                                : index%4==1?[Colors.green[500], Colors.green[200]]
                                                : index%4==2?[Colors.orange[500], Colors.orange[200]]
                                                : [Colors.purple[500], Colors.purple[200]],
                                            stops:[0.0, 0.8],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                                              topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                                          //borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(
                                                        subjects[index],
                                                        style: TextStyle(
                                                            fontFamily: "Medium",
                                                            fontSize: 24.0,
                                                            color: Colors.black54
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 5.0,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(right:8.0),
                                                    child: Text(
                                                        year[index],
                                                        style: TextStyle(
                                                            fontFamily: "Medium",
                                                            fontSize: 18.0,
                                                            color: Colors.black87
                                                        )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                  ),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]
      ),
      drawer: DrawerWidget(),
    );
  }
}
