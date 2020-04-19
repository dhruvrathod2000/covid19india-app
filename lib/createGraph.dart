import 'package:covid19india/dailyseries_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailySeriesChart extends StatefulWidget {
  @override
  _DailySeriesChartState createState() => _DailySeriesChartState();
}

class _DailySeriesChartState extends State<DailySeriesChart> {
  double multiplierConfirmed=0.3,multiplierRecovered=0.3,multiplierDeaths=0.3;
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
    //print(newData[50].date);
    return Scaffold(
      backgroundColor: Colors.white54,
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
            'Tap anywhere on the graph for respective date and value.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 20.0,),
          Text(
            'COMBINED CHARTS',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            'Confirmed',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),
          Text(
            'Deceased',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),
          Text(
            'Recovered',
            style: TextStyle(
              color: Colors.lightGreenAccent,
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          CombinedConfirmedChart(data: newData),
          SizedBox(height: 50.0,),
          SizedBox(height: 20.0,),
          Text(
            'CONFIRMED',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 20.0,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10.0,),
          ConfirmedChart(data: newData),
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
          DeathChart(data: newData),
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
          RecoveredChart(data: newData),
          SizedBox(height: 50.0,),
        ],
      ),
    );

  }
}