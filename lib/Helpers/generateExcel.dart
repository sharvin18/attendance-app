import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Helpers/save_file_mobile.dart';
import 'package:attendance_app/Helpers/widgets.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateExcel(String attendance , String startD, String endD) async {

  List details = attendance.split("-");
  //Create a Excel document.
  List studentdata = await getStudents(details[1].trim(), details[2].toLowerCase());
  List attendDetail = await getDates(details[1].trim(),details[2].toLowerCase(),details[0].trim(),startD,endD);
  startD = getFormattedDate(startD);
  endD = getFormattedDate(endD);
  //Creating a workbook.
  final Workbook workbook = Workbook();
  int row =5;
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
  sheet.getRangeByName('B2').setText('Comps-Se');
  sheet.getRangeByName('A4').setText('Roll No.');
  sheet.getRangeByName('B4').setText('Names');
  sheet.getRangeByName('D2').setText('Total Students = '+length.toString());
  sheet.getRangeByName('D1').setText(startD+" to "+ endD);

  for (var i = 0; i < length; i++) {
    sheet.getRangeByIndex(row, 1).setText(studentdata[1][i]); //roll no
    row= row+1;
  }
  row=5;
  for (var i = 0; i < length; i++) {
    sheet.getRangeByIndex(row, 2).setText(studentdata[0][i]); //names
    row= row+1;
  }
  row=5;
  int k = 0;
  for(var i = 3 ; i<attendDetail[0].length+3 ; i++){
    sheet.getRangeByIndex(4, col).setText(attendDetail[0][k].toString());
    sheet.getRangeByIndex(4, col).columnWidth = 12;
    for(var j = 0 ; j<length ; j++){

      if(attendDetail[1][k].contains(studentdata[2][j])){
        sheet.getRangeByIndex(row,i).setText("P");
      }
      else {
        sheet.getRangeByIndex(row,i).setText("A");
      }
      row=row+1;
    }
    row=5;
    col = col+1;
    k++;
  }
  //Save and launch the excel.
  final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  await FileSaveHelper.saveAndLaunchFile(bytes, 'AttendanceSheet.xlsx');

}