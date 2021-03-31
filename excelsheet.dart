import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Excelsheet extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return time_subject_excel();
  }
}

class time_subject_excel extends State<Excelsheet>{

  var _subjects = ['subject1', 'subject2', 'subject3'];
  var subjectIsSelected = 'subject1';
  var startdate =  DateTime.now();
  var enddate =  DateTime.now();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context, String when) async {
    final DateTime picked = await showDatePicker(
        helpText: 'Select your Booking date',
        cancelText: 'Back',
        confirmText: "Select",
        // fieldLabelText: when == "start ? 'Start Date': 'End date',
        // fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        context: context,
        // builder: (BuildContext context, Widget child) {
        //   return CustomTheme(
        //     child: child,
        //   );
        // },
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked);
        selectedDate = picked;
      });

    if(when == "start"){
      setState(()=> startdate = selectedDate);
    }else{
    setState(()=> enddate = selectedDate);
    }
  }

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
        title: Text(" Generate Excel sheet"),
      ),
      body:
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Select subject"),
              DropdownButton<String>(
                items: _subjects.map((String dropDownStringItem){
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String newValueSelected) {
                  setState(() {
                    this.subjectIsSelected = newValueSelected;
                  });
                },
                value: subjectIsSelected,
              ),
              SizedBox(height: 10.0,),
              Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      _selectDate(context, "start");
                    },
                    title: Text(
                      'Select the start date',
                      style: TextStyle(
                        fontFamily: "Bold",
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      "${startdate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  )),
              SizedBox(height: 10.0,),
              Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      _selectDate(context, "end");
                    },
                    title: Text(
                      'Select the end date',
                      style: TextStyle(
                        fontFamily: "Bold",
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      "${enddate.toLocal()}".split(' ')[0],
                      style: TextStyle(
                        fontFamily: "Medium",
                        fontSize: 16.0,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  )),
              SizedBox(height: 10.0,),
              ElevatedButton(onPressed: () {},
                child: Text("Generate excel sheet"),
              ),
            ],
          ),
        ),
      );
  }
}