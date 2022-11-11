import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/addSubjects.dart';
import 'package:marku/Screens/subclass.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
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
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                                  Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: IconButton(
                                        icon: const Icon(Icons.add, color: Colors.white, size: 28),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => AddSubjects())
                                          );
                                        }
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                  const SizedBox(height: 28.0,),
                  Container(
                    height:30,
                    child: const Text(
                        'Manage Your Classrooms',
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
                        padding: const EdgeInsets.only(left:16.0, right:20.0),
                        child: Column(
                          children: [
                            subjects.isEmpty
                                ? Padding(
                              padding: const EdgeInsets.only(top:80),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'No Subjects Assigned',
                                    style: TextStyle(
                                      fontFamily: "Bold",
                                      fontSize: 20.0,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: subjects.length,
                                itemBuilder: (context, index) {
                                  temp = year[index].split("-");
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: GestureDetector(
                                        onTap: () async {
                                          print(h);
                                          print(h - 153);
                                          List detail = year[index].split("-");
                                          await getTotalStudents(detail[1].toLowerCase(),detail[0]);
                                          print(year[index]);
                                          print(subjects[index]);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => SubClass(year[index], subjects[index]))
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: temp[0] == "FE"? [cardFeDark, cardFeLight]
                                                  : temp[0] == "SE"?[cardSeDark, cardSeLight]
                                                  : temp[0] == "TE"?[cardTeDark, cardTeLight]
                                                  : [cardBeDark, cardBeLight],
                                              stops:const [0.0, 0.6],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: const BorderRadius.only(topRight: Radius.circular(30.0),bottomRight: Radius.circular(30.0),
                                                topLeft: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
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
                                                            color: Colors.grey[800],
                                                          )
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(height: 5.0,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right:8.0),
                                                      child: Text(
                                                        year[index],
                                                        style: const TextStyle(
                                                          fontFamily: "Medium",
                                                          fontSize: 18.0,
                                                          color: Colors.black,
                                                        ),
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
