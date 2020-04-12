import 'package:covid19india/createGraph.dart';
import 'package:covid19india/loading.dart';
import 'package:flutter/material.dart';
import 'package:covid19india/home.dart';
import 'package:covid19india/loadingstate.dart';
import 'package:covid19india/district.dart';
import 'package:covid19india/graphs.dart';


void main() => runApp(MaterialApp(
      routes: {
        '/' : (context) => Loading(),
        '/home' : (context) => Home(),
        '/loadingstate' : (context) => LoadingState(),
        '/district' : (context) => District(),
        '/filtergraph' : (context) => FilterGraphData(),
        '/createGraph' : (context) => DailySeriesChart(),
      },
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
));
