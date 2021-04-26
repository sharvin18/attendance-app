import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'addSubjects.dart';
import 'home.dart';

class MySubjects extends StatefulWidget {
  @override
  _MySubjectsState createState() => _MySubjectsState();
}

class _MySubjectsState extends State<MySubjects> {

  bool _load = false;
  bool del = false;
  int del_index;

  showAlertDialog(BuildContext context, int ind) {

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
      child: Text(
        "Yes",
        style: TextStyle(
          fontFamily: "Medium",
          fontSize: 18.0,
          color: Colors.green,
        ),
      ),
      onPressed:  () async {
        subjects.remove(subjects[ind]);
        year.remove(year[ind]);
        await updateSubject(subjects,year);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(snackBar("Subject Removed Successfully", true));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
                (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Remove Subject"),
      content: Text("Are you sure you want to remove this subject?", style: TextStyle(fontFamily: "Medium")),
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
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgCardColor,
        title: Text(
            "My subjects",
            style: TextStyle(
              fontFamily: "Medium",
              color: textColor,
            )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddSubjects())
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 28.0,
                  color: iconColor,
                ),
              )
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: h,
            width: w,
            color: bgColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 30, color: dividerColor,),
                        scrollDirection: Axis.vertical,
                        itemCount: subjects.length,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onLongPress: (){
                              print("Long pressed");
                              setState(() {
                                showAlertDialog(context, index);
                              });
                            },
                            child: Text(
                              subjects[index] + " in class: " + year[index],
                              style: TextStyle(
                                fontFamily: "Medium",
                                fontSize: 21.0,
                                color: textColor,
                              ),
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}
