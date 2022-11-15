import 'package:marku/Authentication/dbdata.dart';
import 'package:flutter/material.dart';
import 'package:marku/Helpers/constants.dart';
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
      color: themeColor == "dark"? Colors.white: Colors.black,
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
                padding: const EdgeInsets.fromLTRB(0.0, 15.0, 25.0,0.0),
                child: SpinKitThreeBounce(color: Colors.deepPurple.shade300, size: 40,),
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

displayInvalidIds(BuildContext context, List data) {

  var height = MediaQuery.of(context).size.height;
  // set up the buttons
  Widget okButton = TextButton(
    child: Text(
      "Ok",
      style: TextStyle(
        fontFamily: "Medium",
        fontSize: 18.0,
        color: Colors.green,
      ),
    ),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Invalid"),
    content: Container(
      height: height*0.6,
      child: SingleChildScrollView(
        child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 30, color: dividerColor,),
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data[index][1],
                    style: TextStyle(
                      fontFamily: "Medium",
                      fontSize: 14.0,
                      color: themeColor == "dark"? Colors.black: Colors.white,
                    ),
                  ),
                  Text(
                    data[index][0],
                    style: TextStyle(
                      fontFamily: "Regular",
                      fontSize: 12.0,
                      color: themeColor == "dark"? Colors.black: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
    actions:[
      okButton
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
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
