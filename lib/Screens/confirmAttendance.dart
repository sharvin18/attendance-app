import 'package:marku/Authentication/dbdata.dart';
import 'package:marku/Helpers/constants.dart';
import 'package:marku/Helpers/utils.dart';
// import 'package:marku/Helpers/widgets.dart';
import 'package:marku/Screens/loading.dart';
import 'package:marku/Screens/home.dart';
import 'package:marku/Screens/camScan.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../Helpers/widgets.dart';


class ConfirmAttendance extends StatefulWidget {
  final List<List> attendance;
  final List<List> invalidIds;
  const ConfirmAttendance(this.attendance, this.invalidIds);

  @override
  _ConfirmAttendanceState createState() => _ConfirmAttendanceState();
}

class _ConfirmAttendanceState extends State<ConfirmAttendance> {
  var date = DateFormat.yMd().format(DateTime.now());
  var storeDate;
  String displayDate="", strength="";
  List details = [];
  bool _loading = false, isInvalid=false;
  late List ids = [];

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

  displayInvalidIds(BuildContext context, List<List> data) {
    print("DATA: " +data.toString());
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text(
        "Ok",
        style: TextStyle(
          fontFamily: "Medium",
          fontSize: 18.0,
          color: Colors.green,
        ),
      ),
      onPressed:  () {
        Navigator.of(context).pop();
        // setState(() {
        //   isInvalid = false;
        // });
      },
    );

    // set up the AlertDialog
    AlertDialog alertDia = AlertDialog(
      // backgroundColor: Colors.grey[350],
      title: const Text("Invalid"),
      content: Material(
        elevation: 2,
        child: Container(
          height: h*0.4,
          width: w*0.8,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            // color:bgColor,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 30, color: dividerColor,),
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, index) {
               return Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                       data[0][1],
                       style: TextStyle(
                         fontFamily: "Medium",
                         fontSize: 18.0,
                         color: themeColor == "dark"? Colors.white: Colors.black,
                       ),
                   ),
                   Text(
                     data[0][0],
                     style: TextStyle(
                       fontFamily: "Medium",
                       fontSize: 14.0,
                       color: themeColor == "dark"? Colors.white: Colors.black,
                     ),
                   ),
                 ],
               );
              }
            ),
          ),
        ),
      ),
      actions:[
        okButton
      ],
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Invalid"),
      content: Material(
        elevation: 20,
        child: Container(
          height: h*0.4,
          child: SingleChildScrollView(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 30, color: dividerColor,),
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data[index][1],
                        style: TextStyle(
                          fontFamily: "Medium",
                          fontSize: 14.0,
                          color: themeColor == "dark"? Colors.black: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      actions:[
        okButton
      ],
    );

    // show the dialog
    return showDialog(
      context: context,
      builder: (context) {
        return alertDia;
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDate = getTodaysDate();
    displayDate = formatDateYMD(storeDate);

    print("Invalid details: " + widget.invalidIds.toString());
    setids();
    // if(widget.invalidIds.isNotEmpty){
    //   print("Invalid details: " + widget.invalidIds.toString());
    //   // displayInvalidIds(context, widget.invalidIds);
    //   Future.delayed(const Duration(seconds: 1), () async {
    //     isInvalid = true;
    //   });
    // }

  }

  setids(){
    for(int i=0; i<widget.attendance.length; i++){
      ids.add(widget.attendance[i][0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    if(widget.invalidIds.isNotEmpty) {
      print("displaying invalids");
      Future.delayed(Duration.zero, () => displayInvalidIds(context, widget.invalidIds));
    }
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
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CamScan(widget.attendance)));
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
                                        await markAttendance(widget.attendance, storeDate);
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
                                    .collection(studentCollection)
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
                                                var name = studentlist.data()['name'];
                                                print(studentlist);

                                                return ids.contains(id.toString()) ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
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
            ),
            // isInvalid? displayInvalidIds(context, widget.invalidIds): Container()
          ],
        ),
      ),
    );
  }
}