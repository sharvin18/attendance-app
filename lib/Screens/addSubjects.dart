import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import 'loading.dart';

class AddSubjects extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return add_subject();
  }
}

class add_subject extends State<AddSubjects>{

  bool _updating = false;
  var subs =[];
  // var yr = ['Select a year'];
  // var dept = ['Select a department'];

  // var subs = ['Select a subject', 'subject1', 'subject2', 'subject3'];
  var yr = ['Select a year', 'FE', 'SE', 'TE', 'BE'];
  var dept = ['Select a department', 'Comps', 'AI', 'IT', 'EXTC', 'Mech'];
  var selectedDept = "Select a department";
  var selectedYear = "Select a year";
  var selectedSub = "Select a subject";
  String counter = "Get";
  bool flag = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // deptisSelected = _department[0];
    // yearisSelected = _year[0];
    // subjectIsSelected = _subjects[0];
  }

  timepass(){}

  Future<void> rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return _updating ? Loading("Updating the subject") :Scaffold(
      appBar: AppBar(
        backgroundColor: bgCardColor,
        title: Text(
            "Add Subjects",
            style: TextStyle(
              fontFamily: "Medium",
              color: textColor,
            )
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: h,
            width: w,
            color: bgColor,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 100.0,),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Department',
                      labelStyle: TextStyle(
                          fontFamily: "Medium",
                          color: textColor
                      ),
                      contentPadding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                    ),
                    child:DropdownButtonHideUnderline(
                      child:DropdownButton(
                        dropdownColor: bgCardColor,
                        focusColor: textColor,
                        elevation: 4,
                        icon: Icon(Icons.arrow_drop_down, color: iconColor,),
                        items: dept.map<DropdownMenuItem<String>>((String dropDownStringItem){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "Medium",
                                  color: textColor
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) {
                          setState(() {
                            this.selectedDept = newValueSelected;
                          });
                        },
                        value: selectedDept,
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  InputDecorator(decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: TextStyle(
                        fontFamily: "Medium",
                        color: textColor
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),

                  ),
                    child:DropdownButtonHideUnderline(
                      child:DropdownButton(
                        dropdownColor: bgCardColor,
                        focusColor: textColor,
                        elevation: 4,
                        icon: Icon(Icons.arrow_drop_down, color: iconColor,),
                        items: yr.map<DropdownMenuItem<String>>((String dropDownStringItem){
                          return DropdownMenuItem<String>(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Medium",
                                color: textColor
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValueSelected) async {
                          setState(() {
                            this.selectedYear = newValueSelected;
                          });
                          if(counter == "Add" && selectedDept != "Select a department" && selectedYear != "Select a year") {
                            subs = await getSubjects(selectedDept.toLowerCase(), selectedYear.toUpperCase());
                            subs.insert(0, 'Select a subject');
                            print(subs);
                            selectedSub = "Select a subject";
                            // await rebuildAllChildren(context);
                            // await rebuildAllChildren(context);
                            // timepass();
                            // print("Rebuild successfull");
                          }
                        },
                        value: selectedYear,
                      ),
                    ),
                  ),


                  SizedBox(height: 25.0,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 15.0),
                  //       child: GestureDetector(
                  //         onTap: (){
                  //
                  //         },
                  //         child: Text(
                  //           'Get Subjects',
                  //           style: TextStyle(
                  //             fontFamily: "Medium",
                  //             color: Colors.blue,
                  //             fontSize: 18
                  //           )
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 25.0,),
                  flag? InputDecorator(
                    decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(
                        fontFamily: "Medium",
                        color: textColor
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(25))
                    ),

                  ),
                    child:DropdownButtonHideUnderline(
                      child:DropdownButton(
                        dropdownColor: bgCardColor,
                        focusColor: textColor,
                        elevation: 4,
                        icon: Icon(Icons.arrow_drop_down, color: iconColor,),
                        items: subs.map<DropdownMenuItem>((var dropDownStringItem){
                          return DropdownMenuItem(
                            value: dropDownStringItem,
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: "Medium",
                                color: textColor
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (var newValueSelected) {
                          setState(() {
                            this.selectedSub = newValueSelected;
                          });
                        },
                        value: selectedSub,
                      ),
                    ),
                  ): Container(),
                  SizedBox(height: 50.0,),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                        onPressed: () async {
                          if(counter == "Get"){
                            if(selectedDept != "Select a department" && selectedYear != "Select a year"){
                              subs = await getSubjects(selectedDept.toLowerCase(), selectedYear.toUpperCase());
                              subs.insert(0, 'Select a subject');
                              print(subs);
                              selectedSub = "Select a subject";
                              await rebuildAllChildren(context);
                              await rebuildAllChildren(context);
                              timepass();
                              print("Rebuild successfull");
                              setState(() {
                                flag = true;
                                counter = "Add";
                              });
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(snackBar("Please select the appropriate fields", false));
                            }

                          }else{
                            if(selectedDept != "Select a department" && selectedYear != "Select a year" && selectedSub != "Select a subject"){
                              setState(() => _updating = true);
                              subjects.add(selectedSub.toUpperCase());
                              year.add(selectedYear.toUpperCase()+"-"+selectedDept.toUpperCase());
                              await updateSubject(subjects, year);
                              setState(() => _updating = false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home()),
                                      (route) => false);
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(snackBar("Please select the valid data", false));
                            }
                          }

                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0.0),
                          primary: Colors.white,
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(75.0)),
                          textStyle: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 18,
                            fontFamily: "Bold",
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: <Color>[Color(0xFF3a5af9), Color(0xFF7449fa)]),
                            borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                              child: Text(
                                "${counter} Subject",
                                style: TextStyle(fontSize: 18, fontFamily: "Bold"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}