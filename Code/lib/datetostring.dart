class DateToString {
  //DateTime time;
  String month,date;
  //DateToString({this.time});
  List months=[
    ['January','01'],
    ['February','02'],
    ['March','03'],
    ['April','04'],
    ['May','05'],
    ['June','06'],
    ['July','07'],
    ['August','08'],
    ['September','09'],
    ['October','10'],
    ['November','11'],
    ['December','12'],
  ];
  String printDate(DateTime time) {
    month=time.toString().substring(5,7);
    date=time.toString().substring(8,10);
    months.forEach((element) {
      if(element[1]==month) {
        month=element[0];
        }
    });
    return '$date $month';
  }
}


String betterDate(String lastUpdatedTime) {
  //print(lastUpdatedTime);
  DateTime latestTime = DateTime.now();
  //print(latestTime);
  String lastUpdated,yy,mm,dd,time;
  lastUpdated = lastUpdatedTime.substring(11);
  yy=lastUpdatedTime.substring(6,10);
  mm=lastUpdatedTime.substring(3,5);
  dd=lastUpdatedTime.substring(0,2);
  DateTime latestUpdated = DateTime.parse('$yy-$mm-$dd $lastUpdated');
  lastUpdated = latestUpdated.day == latestTime.day ? 'Today ' : 'Yesterday ';
  if(latestTime.day>latestUpdated.day+1) {
    lastUpdated = '$dd/$mm ';
  }
  time = latestUpdated.hour>12 ? '${latestUpdated.hour-12}:${latestUpdated.minute} PM' : '${latestUpdated.hour}:${latestUpdated.minute} AM' ;
  time = time.startsWith('12') ? '12 noon' : time ;
  time = time.startsWith('0 ') ? '12 AM' : time ;
  lastUpdated = lastUpdated + time;
  return lastUpdated;
}