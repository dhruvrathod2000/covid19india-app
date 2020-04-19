import 'package:flutter/material.dart';
import 'package:covid19india/getstate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19india/mydatatable.dart';

class LoadingState extends StatefulWidget {
  @override
  _LoadingStateState createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {
  CoronaStateApi instance = new CoronaStateApi();
  List data=[];
  Future<void> receiveStateData() async{
    await instance.getStateData();
    data=instance.total;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('State / UT Stats'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: receiveStateData(),
        // ignore: missing_return
        builder: (context,snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              return SpinKitRing(
                size: 80.0,
                lineWidth: 8.0,
                color: Colors.amberAccent,
              );
              break;
            case ConnectionState.waiting:
              return SpinKitRing(
                size: 80.0,
                lineWidth: 8.0,
                color: Colors.amberAccent,
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if(snapshot.hasError)
                return Text('Error');
              else
                return MyDataTable(data: data,);
              break;
          }
        },
      ),
    );
  }
}