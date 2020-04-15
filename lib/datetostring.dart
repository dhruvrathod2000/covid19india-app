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