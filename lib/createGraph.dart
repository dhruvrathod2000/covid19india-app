import 'package:covid19india/dailyseries_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailySeriesChart extends StatefulWidget {
  @override
  _DailySeriesChartState createState() => _DailySeriesChartState();
}

class _DailySeriesChartState extends State<DailySeriesChart> {
  List data=[];
  List<DailySeries> newData=[];
  @override
  Widget build(BuildContext context) {
    dynamic total = ModalRoute.of(context).settings.arguments;
    data=total['data'];
    data.map((dailyData) {
      newData.add(
        DailySeries(
          confirmed: int.parse(dailyData['totalconfirmed']),
          date: dailyData['date'],
          recovered: int.parse(dailyData['totalrecovered']),
          deaths: int.parse(dailyData['totaldeceased']),
        )
      );
    }).toList();
    for(int i=0;i<50;i++)
      newData.removeAt(0);
    newData.forEach((caseNew) {
      print(caseNew.date);
    });
    //print(newData[50].date);
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Graphs'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(7, 10, 7, 0),
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: <Widget>[
          Text(
            'CONFIRMED',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            //width: MediaQuery.of(context).size.width*0.5,
            child: ConfirmedChart(data: newData),
          ),
          Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
          SizedBox(height: 50.0,),
          Text(
            'DECEASED',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            //width: MediaQuery.of(context).size.width*0.5,
            child: DeathChart(data: newData),
          ),
          Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
          SizedBox(height: 50.0,),
          Text(
            'RECOVERED',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            //width: MediaQuery.of(context).size.width*0.5,
            child: RecoveredChart(data: newData),
          ),
          Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
          SizedBox(height: 50.0,),
        ],
      ),
    );

  }
}