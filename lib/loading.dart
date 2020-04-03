import 'package:covid19india/getdata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void receiveData() async{
    CoronaApi instance = new CoronaApi();
    await instance.getData();
    Navigator.pushReplacementNamed(context,'/home',arguments: {
      'active' : instance.active,
      'confirmed' : instance.confirmed,
      'deaths' : instance.deaths,
      'recovered': instance.recovered,
      'deltaconfirmed' : instance.deltaconfirmed,
      'deltarecovered' : instance.deltarecovered,
      'deltadeaths' : instance.deltadeaths,
    } );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    receiveData();
  }

  @override
  Widget build(BuildContext context) {
    receiveData();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitRing(color: Colors.amberAccent,
            size: 80.0,
            lineWidth: 10.0,
            ),
            SizedBox(height: 15.0,),
            Text('Fetching Data',
              style: TextStyle(
                color: Colors.white70,
                letterSpacing: 2.0,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
