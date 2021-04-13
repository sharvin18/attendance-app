import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';

import 'addsubjects.dart';

class My_subject extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return my_subject();
  }
}

class my_subject extends State<My_subject>{

  var _subjects = ['subject1', 'subject2', 'subject3'];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint("subject is created.");
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "My subjects",
            style: TextStyle(
                fontFamily: "Medium",
                fontSize: 24.0,
                // color: Colors.white
            )
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Add_subject())
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0,),
              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 30),
                  scrollDirection: Axis.vertical,
                itemCount: _subjects.length,
                itemBuilder: (context, index){
                  return Text(
                      _subjects[index],
                      style: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 20.0,
                      ),
                  );
                }
              )



              // Card(
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              //   child: Column(
              //     children: <Widget>[
              //       ListTile(
              //         title: Text("My subject 1"),
              //       ),
              //       ListTile(
              //         title: Text("My subject 2"),
              //       ),
              //       ListTile(
              //         title: Text("My subject 3"),
              //       ),
              //       ListTile(
              //         title: Text("My subject 4"),
              //       ),
              //       ListTile(
              //         title: Text("My subject 5"),
              //       ),
              //     ],
              //   ),
              //     ),
            ],
          ),
        ),
      ),
    );
  }
}