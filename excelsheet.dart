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
        String a = picked.day.toString() + "-" + picked.month.toString() + "-" + picked.year.toString();
        print(a);
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
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(bottom: 25.0),
                child:Text(
                "Select Subject",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              ),
              InputDecorator(decoration: InputDecoration(
                labelText: 'Subject',
                border: const OutlineInputBorder(),

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
              SizedBox(height: 25.0,),
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
              SizedBox(height: 12.0,),
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
                            "Generate Excel sheet",
                            style: TextStyle(fontSize: 18, fontFamily: "Bold"),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                ),
              ),
              // ElevatedButton.icon(
              //    icon: Icon(Icons.view_list_rounded),
              //   onPressed: () {},
              //   label:
              //   Text(
              //       "Generate excel sheet",
              //     style: TextStyle(
              //       fontSize: 15.0,
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
              //   ),
                // child: Container(
                //   width: MediaQuery.of(context).size.width,
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(colors: <Color>[Color(0xFF3a5af9), Color(0xFF7449fa)]),
                //     borderRadius: BorderRadius.all(Radius.circular(80.0)),
                //   ),
                //   child: Center(
                //     child: Padding(
                //       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                //       child: Text(
                //         "Sign In",
                //         style: TextStyle(fontSize: 18, fontFamily: "Bold"),
                //         textAlign: TextAlign.center,
                //       ),
                //     ),
                //   ),
                // )
              // ),
            ],
          ),
        ),
      );
  }
}