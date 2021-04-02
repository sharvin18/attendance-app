import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/generateExcel.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:flutter/material.dart';

class ExcelSheet extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ExcelSheetstate();
  }
}

class _ExcelSheetstate extends State<ExcelSheet>{

  String start = "",end="",a = "";
  String subjectIsSelected;
  var startdate =  DateTime.now();
  var enddate =  DateTime.now();
  List<String> subjectyear = [];
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, String when) async {
    final DateTime picked = await showDatePicker(
        helpText: 'Select your Booking date',
        cancelText: 'Back',
        confirmText: "Select",
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        String month = picked.month.toString();
        String day = picked.day.toString();
        String y = picked.year.toString();
        a = formatDateAndMonth(y+"/"+month+"/"+day);
        print(a);
        selectedDate = picked;
      });

    if(when == "start"){
      setState((){
        startdate = selectedDate;
        start = a;
      });
    }else{
      setState((){
        enddate = selectedDate;
        end = a;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
    getInitialDates();
  }

  getInitialDates(){
    String m = startdate.month.toString();
    String d = startdate.day.toString();
    String y = startdate.year.toString();
    start = formatDateAndMonth(y+"/"+m+"/"+d);

    m = enddate.month.toString();
    d = enddate.day.toString();
    y = enddate.year.toString();
    end = formatDateAndMonth(y+"/"+m+"/"+d);

    print(start);
    print(end);
  }


  getList(){
    for(int i = 0;  i < subjects.length ; i++){
      subjectyear.add(subjects[i]+" - "+year[i]);
      print(subjectyear[i]);
    }
    subjectIsSelected = subjectyear[0];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgCardColor,
        title: Text(
          'Generate attendance',
          style: TextStyle(
            color:textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: iconColor,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Select Subject",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: textColor
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0,),
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Subject',
                  labelStyle: TextStyle(
                    color: textColor
                  ),
                  contentPadding: EdgeInsets.all(8.0),
                  border: const OutlineInputBorder(),
                  fillColor: bgColor,
                  focusColor: bgColor,
                ),
                child:DropdownButtonHideUnderline(
                  child:DropdownButton(
                    dropdownColor: bgCardColor,
                    focusColor: textColor,
                    elevation: 4,
                    icon: Icon(Icons.arrow_drop_down, color: iconColor),
                    items: subjectyear.map<DropdownMenuItem<String>>((String dropDownStringItem){
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: textColor,
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
              SizedBox(height: 35.0,),
              Card(
                color: bgCardColor,
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
                      color: textColor
                    ),
                  ),
                  subtitle: Text(
                    "${startdate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 16.0,
                      color: textColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: iconColor
                    ),
                    onPressed: () {},
                  ),
                )),
              SizedBox(height: 12.0,),
              Card(
                color: bgCardColor,
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
                      color: textColor
                    ),
                  ),
                  subtitle: Text(
                    "${enddate.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 16.0,
                      color: textColor
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      color: iconColor,
                    ),
                    onPressed: () {},
                  ),
                )),
              SizedBox(height: 60.0,),
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                    onPressed: () async {
                      await generateExcel(subjectIsSelected, start, end);
                      snackBar("Excel Sheet generated successfully", true);
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
                            "Generate Excel sheet",
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
    );
  }
}