import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FilterGraphData extends StatelessWidget {

  Future<void> receiveData(BuildContext context) async{
    String dd,mm;
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
      ['December','12']
    ];
    Response response = await get("https://api.covid19india.org/data.json");
    Map total = jsonDecode(response.body);
    List data= total["cases_time_series"];
    data.forEach((dailyData) {
      months.forEach((month) {
        if((dailyData['date']).toString().contains(month[0])){
          dd=dailyData['date'].toString().substring(0,2);
          mm=month[1];
          dailyData['date']=DateTime.parse('2020-$mm-$dd');
        }
      });
    });
    Navigator.pushReplacementNamed(context,'/createGraph',arguments: {
      'data' : data
    });
    }

  @override
  Widget build(BuildContext context) {
    receiveData(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(
              size: 80.0,
              color: Colors.amberAccent,
              lineWidth: 8.0,
            ),
            SizedBox(height: 30.0,),
            Text(
              'Loading Graphs',
              style: TextStyle(
                color: Colors.amberAccent,
                fontSize: 20.0,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
    }
  }


