import 'package:flutter/material.dart';
import 'package:attendance_app/Helpers/constants.dart';

Container customContainer(double h, double w){
  return Container(
    height: h,
    width: w,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
      Color(0xFF3a5af9), Color(0xFF7449fa),],
      stops:[0.0, 0.8],
      ),
    ),
  );
}

SnackBar snackBar(String text, bool col){
  return SnackBar(
    backgroundColor: col ? bgSnack : Colors.black.withOpacity(0.8),
    content: Text(
      text,
      style: TextStyle(
        fontFamily: "Medium",
        color: col ? textSnack : Colors.white,
      ),
    ),
    duration: Duration(seconds: 2),
  );
}

String getFormattedDate(String dt){
  List dateList = dt.split("-");
  String temp = dateList[0];
  dateList[0] = dateList[2];
  dateList[2] = temp;
  return dateList.join("-");
}

String formatDateAndMonth(String dt){
  List dateList = dt.split("/");
  String month = dateList[0];
  String date = dateList[1];
  String y = dateList[2];
  
  if(month.length == 1){
    month = "0" + month;
  }
  if(date.length == 1){
    date = "0" + date;
  }
  
  return y + "-" + month + "-" + date;
}
