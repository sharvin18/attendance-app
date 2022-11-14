

DateTime getTodaysDate(){
  return DateTime.now();
}

String formatDateYMD(DateTime date){
  String formattedDate = date.toString().split(" ")[0];
  return formattedDate;
}

String formatDateDMY(DateTime date){
  String formattedDate = date.toString().split(" ")[0];
  List ymd = formattedDate.split("-");
  String dmy = ymd[2].toString()+"-"+ymd[1].toString()+"-"+ymd[0].toString();
  return dmy;
}

bool isValidAttendance(DateTime startTime, DateTime endTime){
  int diffInMins = endTime.difference(startTime).inMinutes;
  return diffInMins >= 30 ? true: false;
}