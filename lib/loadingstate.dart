import 'package:flutter/material.dart';
import 'package:covid19india/getstate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    //data.removeAt(0);
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
            // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if(snapshot.hasError)
                print('error');
              else
              {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 17.0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Click on any state for district information.\nLong press on any column for more info.',
                        style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.amber,
                          fontSize: 13.0,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: DataTable(
                            columnSpacing:15,
                            columns: [
                              DataColumn(
                                label: Text('S/UT'),
                                tooltip: "State name / Union Territory",
                              ),
                              DataColumn(
                                label: Text("C"),
                                numeric: true,
                                tooltip: "Confirmed Cases",
                              ),
                              DataColumn(
                                  label: Text('A'),
                                  numeric: true,
                                  tooltip: "Active Cases",
                              ),
                              DataColumn(
                                  label: Text('R'),
                                  numeric: true,
                                  tooltip: "Recovered Cases"
                              ),
                              DataColumn(
                                label: Text('D'),
                                numeric: true,
                                tooltip: "Deceased",
                              ),
                            ],
                            rows: data.map((state) => DataRow(
                              //onSelectChanged: (b) { if(b){print('Selected state is ${state['state']}');}},
                              cells: [
                                DataCell(
                                  Text(state['state']),
                                  onTap: () {
                                    print('Selected state is ${state['state']}');
                                    Navigator.pushNamed(context,'/district',arguments: {
                                      'state' : state['state'],
                                    });
                                    },
                                ),
                                DataCell(
                                  RichText(
                                    text: TextSpan(
                                      text: (state['deltaconfirmed']=="0")?' ':'▲${state['deltaconfirmed'].toString()}  ',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 10.0,
                                        ),
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: state['confirmed'],
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print('Selected state is ${state['state']}');
                                    Navigator.pushNamed(context,'/district',arguments: {
                                      'state' : state['state'],
                                    });
                                  },
                                ),
                                DataCell(
                                  Text(state['active'],
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                  ),
                                  onTap: () {
                                    print('Selected state is ${state['state']}');
                                    Navigator.pushNamed(context,'/district',arguments: {
                                      'state' : state['state'],
                                    });
                                  },
                                ),
                                DataCell(
                                  RichText(
                                    text: TextSpan(
                                      text: (state['deltarecovered']=="0")?' ':'▲${state['deltarecovered'].toString()}  ',
                                      style: TextStyle(
                                        color: Colors.lightGreenAccent,
                                        fontSize: 10.0,
                                      ),
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: state['recovered'],
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print('Selected state is ${state['state']}');
                                    Navigator.pushNamed(context,'/district',arguments: {
                                      'state' : state['state'],
                                    });
                                  },
                                ),
                                DataCell(
                                  RichText(
                                    text: TextSpan(
                                      text: (state['deltadeaths']=="0")?' ':'▲${state['deltadeaths'].toString()}  ',
                                      style: TextStyle(
                                        color: Colors.red[600],
                                        fontSize: 10.0,
                                      ),
                                      children: <TextSpan> [
                                        TextSpan(
                                          text: state['deaths'],
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 13.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    print('Selected state is ${state['state']}');
                                    Navigator.pushNamed(context,'/district',arguments: {
                                      'state' : state['state'],
                                    });
                                  },
                                ),
                              ],
                            )).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              break;
          }
        },
      ),
    );
  }
}