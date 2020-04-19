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
  DateTime latestTime = DateTime.now();
  latestTime = latestTime.add(Duration(hours: 5,minutes: 30));
  String lastUpdated,yy,mm,dd,time;
  lastUpdated = lastUpdatedTime.substring(11);
  yy=lastUpdatedTime.substring(6,10);
  mm=lastUpdatedTime.substring(3,5);
  dd=lastUpdatedTime.substring(0,2);
  DateTime latestUpdated = DateTime.parse('$yy-$mm-$dd $lastUpdated');
  lastUpdated = latestUpdated.day == latestTime.day ? 'Today ' : 'Yesterday ';
  time = latestUpdated.hour>12 ? '${latestUpdated.hour-12} PM' : '${latestUpdated.hour} AM' ;
  time = time.startsWith('12') ? '12 noon' : time ;
  time = time.startsWith('0 ') ? '12 AM' : time ;
  lastUpdated = lastUpdated + time;
  return lastUpdated;
}