import 'package:attendance_app/Authentication/dbdata.dart';
import 'package:attendance_app/Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/Helpers/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

Container loadingContainer(String text){
  return Container(
    height: 116,
    width: 288,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: themeColor == "dark" ? Colors.white : Color(0XFF2d2e2d),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: "Medium",
              fontSize: 20.0,
              color: themeColor == "dark"? Colors.black: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 12.0, 25.0,0.0),
                child: SpinKitFadingCircle(color: Colors.deepPurple.shade300, size: 40,),
              ),
            ],
          )
        ],
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

Container deleteSubject(BuildContext context, int ind){
  bool del = false;
  return Container(
    height: 116,
    width: 288,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      color: themeColor == "dark" ? Colors.white : Color(0XFF2d2e2d),
    ),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Are you sure you want to remove this subject?",
            style: TextStyle(
              fontFamily: "Medium",
              fontSize: 20.0,
              color: themeColor == "dark"? Colors.black: Colors.white,
            ),
          ),
          Text(
            subjects[ind] + " in " + year[ind],
            style: TextStyle(
              fontFamily: "Medium",
              fontSize: 18.0,
              color: themeColor == "dark"? Colors.black: Colors.white,
            ),
          ),
          del ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SpinKitFadingCircle(
                color: Colors.blue[600],
                size: 60.0,
              ),
            ]
          ):Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    del = true;

                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 18.0,
                      color: Colors.green,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
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
