import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:intl/intl.dart';

class Add_subject extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return add_subject();
  }
}

class add_subject extends State<Add_subject>{

  var _subjects = ['subject1', 'subject2', 'subject3'];
  var _year = ['FE', 'SE', 'TE', 'BE'];
  var _department = ['Computer', 'AI', 'IT', 'EXTC', 'Mechanical'];
  var deptisSelected = 'Computer';
  var yearisSelected = 'FE';
  var subjectIsSelected = 'subject1';

  // Future<Null> _endselectDate (BuildContext context) async{
  //   DateTime _datePicker = await showDatePicker(
  //     context: context,
  //     initialDate: _date,
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime(2021),
  //
  //   );
  //
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    debugPrint("subject is created.");
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Add Subjects",
            style: TextStyle(
                fontFamily: "Medium",
                fontSize: 24.0,
                // color: Colors.white
            )
        ),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 100.0,),
            InputDecorator(
              decoration: InputDecoration(
              labelText: 'Department',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(25))
              ),
            ),
              child:DropdownButtonHideUnderline(
                child:DropdownButton(
                  elevation: 8,
                  icon: Icon(Icons.arrow_drop_down),
                  items: _department.map((String dropDownStringItem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.deptisSelected = newValueSelected;
                    });
                  },
                  value: deptisSelected,
                ),
              ),
            ),
            SizedBox(height: 25.0,),
            InputDecorator(decoration: InputDecoration(
              labelText: 'Year',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),

            ),
              child:DropdownButtonHideUnderline(
                child:DropdownButton(
                  elevation: 8,
                  icon: Icon(Icons.arrow_drop_down),
                  items: _year.map((String dropDownStringItem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.yearisSelected = newValueSelected;
                    });
                  },
                  value: yearisSelected,
                ),
              ),
            ),


            SizedBox(height: 25.0,),
            InputDecorator(decoration: InputDecoration(
              labelText: 'Subject',
              contentPadding: EdgeInsets.fromLTRB(20, 5, 0, 5),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),

            ),
              child:DropdownButtonHideUnderline(
                child:DropdownButton(

                  elevation: 8,
                  icon: Icon(Icons.arrow_drop_down),
                  items: _subjects.map((String dropDownStringItem){
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(
                        dropDownStringItem,
                        style: TextStyle(
                            fontSize: 20.0
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    setState(() {
                      this.subjectIsSelected = newValueSelected;
                    });
                  },
                  value: subjectIsSelected,
                ),
              ),
            ),
            SizedBox(height: 50.0,),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  onPressed: () {},
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
                          "Add Subject",
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
    );
  }
}