import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/Helpers/save_file_mobile.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Stack, Row, Column, Alignment;

class ExcelSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExcelSheetstate();
  }
}

class _ExcelSheetstate extends State<ExcelSheet> {
  String start = "", end = "", a = "";
  String subjectIsSelected;
  var startdate = DateTime.now();
  var enddate = DateTime.now();
  List<String> subjectyear = [];
  DateTime selectedDate = DateTime.now();
  bool load = false;

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
        a = formatDateAndMonth(month + "/" + day + "/" + y);
        print(a);
        selectedDate = picked;
      });

    if (when == "start") {
      setState(() {
        startdate = selectedDate;
        start = a;
      });
    } else {
      setState(() {
        enddate = selectedDate;
        end = a;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load = false;
    getList();
    getInitialDates();
  }

  getInitialDates() {
    String m = startdate.month.toString();
    String d = startdate.day.toString();
    String y = startdate.year.toString();
    start = formatDateAndMonth(m + "/" + d + "/" + y);

    m = enddate.month.toString();
    d = enddate.day.toString();
    y = enddate.year.toString();
    end = formatDateAndMonth(m + "/" + d + "/" + y);

    print(start);
    print(end);
  }

  getList() {
    for (int i = 0; i < subjects.length; i++) {
      subjectyear.add(subjects[i] + " - " + year[i]);
      print(subjectyear[i]);
    }
    subjectIsSelected = subjectyear[0];
  }

  Future<void> generateExcel(String attendance, String startD, String endD) async {
    setState(()=> load = true);
    List details = attendance.split("-");
    //Create a Excel document.
    List studentdata =
        await getStudents(details[1].trim(), details[2].toLowerCase());
    List attendDetail = await getDates(details[1].trim(),
        details[2].toLowerCase(), details[0].trim(), startD, endD);
    startD = getFormattedDate(startD);
    endD = getFormattedDate(endD);
    //Creating a workbook.
    final Workbook workbook = Workbook();
    int row = 5;
    int col = 3;
    int length = studentdata[0].length;
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];

    // Enable calculation for worksheet.
    //sheet.enableSheetCalculations();
    //Set data in the worksheet.
    sheet.getRangeByName('A1').columnWidth = 8;
    sheet.getRangeByName('B1').columnWidth = 20;
    sheet.getRangeByName('B1').setText('Attendance Sheet');
    sheet.getRangeByName('B1').cellStyle.bold = true;
    sheet.getRangeByName('B2').setText('Comps-Se  -> ' + details[0].trim());
    sheet.getRangeByName('A4').setText('Roll No.');
    sheet.getRangeByName('B4').setText('Names');
    sheet.getRangeByName('D2').setText('Total Students = ' + length.toString());
    sheet.getRangeByName('D1').setText(startD + " to " + endD);

    for (var i = 0; i < length; i++) {
      sheet.getRangeByIndex(row, 1).setText(studentdata[1][i]); //roll no
      row = row + 1;
    }
    row = 5;
    for (var i = 0; i < length; i++) {
      sheet.getRangeByIndex(row, 2).setText(studentdata[0][i]); //names
      row = row + 1;
    }
    row = 5;
    int k = 0;
    for (var i = 3; i < attendDetail[0].length + 3; i++) {
      sheet.getRangeByIndex(4, col).setText(attendDetail[0][k].toString());
      sheet.getRangeByIndex(4, col).columnWidth = 12;
      for (var j = 0; j < length; j++) {
        if (attendDetail[1][k].contains(studentdata[2][j])) {
          sheet.getRangeByIndex(row, i).setText("P");
        } else {
          sheet.getRangeByIndex(row, i).setText("A");
        }
        row = row + 1;
      }
      row = 5;
      col = col + 1;
      k++;
    }
    //Save and launch the excel.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    setState(()=> load = false);
    await FileSaveHelper.saveAndLaunchFile(bytes, 'AttendanceSheet.xlsx');
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgCardColor,
        title: Text(
          'Generate attendance',
          style: TextStyle(
            color: textColor,
            fontFamily: "Medium",
          ),
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
      body: Stack(children: [
        Container(
          height: h,
          width: w,
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
                            color: textColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(color: textColor),
                    contentPadding: EdgeInsets.all(8.0),
                    border: const OutlineInputBorder(),
                    fillColor: bgColor,
                    focusColor: bgColor,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: bgCardColor,
                      focusColor: textColor,
                      elevation: 4,
                      icon: Icon(Icons.arrow_drop_down, color: iconColor),
                      items: subjectyear.map<DropdownMenuItem<String>>(
                          (String dropDownStringItem) {
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
                SizedBox(
                  height: 35.0,
                ),
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
                            color: textColor),
                      ),
                      subtitle: Text(
                        "${startdate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontFamily: "Medium",
                            fontSize: 16.0,
                            color: textColor),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.date_range, color: iconColor),
                        onPressed: () {},
                      ),
                    )),
                SizedBox(
                  height: 12.0,
                ),
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
                            color: textColor),
                      ),
                      subtitle: Text(
                        "${enddate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontFamily: "Medium",
                            fontSize: 16.0,
                            color: textColor),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.date_range,
                          color: iconColor,
                        ),
                        onPressed: () {},
                      ),
                    )),
                SizedBox(
                  height: 60.0,
                ),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75.0)),
                        textStyle: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 18,
                          fontFamily: "Bold",
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: <Color>[
                            Color(0xFF3a5af9),
                            Color(0xFF7449fa)
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            child: Text(
                              "Generate Excel sheet",
                              style:
                                  TextStyle(fontSize: 18, fontFamily: "Bold"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
        load? Container(
          width: w,
          height: 0.9 * h,
          color: Colors.transparent,
          child: Center(child: loadingContainer("Generating Excel sheet")),
        ):Container()
      ]),
    );
  }
}
