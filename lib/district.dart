import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class District extends StatefulWidget {
  @override
  _DistrictState createState() => _DistrictState();
}

class _DistrictState extends State<District> {
  Map data={};
  //bool sort=false;
  List<String> districts=[];
  Future<void> receiveData(String state) async{
    Response response= await get("https://api.covid19india.org/state_district_wise.json");
    Map state_data = jsonDecode(response.body);
    data=state_data['$state']['districtData'];
    districts = data.keys.toList();
    //print(districts);
    //print(districts);
    //print(data.keys);
  }

  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    dynamic state=data['state'];
    //receiveData(state);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(state),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: receiveData(state),
        // ignore: missing_return
        builder: (context,snapshot) {
          switch(snapshot.connectionState){
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
              return SpinKitRing(
                size: 80.0,
                lineWidth: 8.0,
                color: Colors.amberAccent,
              );
              break;
            case ConnectionState.done:
              if(snapshot.hasError)
                print('error');
              else
                {
                  return SingleChildScrollView(
                    child: DataTable(
                            columnSpacing: 20.0,
                            columns: <DataColumn> [
                              DataColumn(
                                label: Text('District'),
                                tooltip: "District Name",
                              ),
                              DataColumn(
                                label: Text('Confirmed'),
                                tooltip: "Confirmed Cases",
                                numeric: true,
                              ),
                            ],
                            rows: districts.map((district) => DataRow(
                              cells: [
                                DataCell(
                                  Text((district.toString()=="Unknown")?"OTHERS":(district.toString().toUpperCase()),
                                    style: TextStyle(
                                      letterSpacing: 2.0,
                                      fontSize: 15.0,
                                      color: Colors.blueGrey[300],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: (data[district]['delta']['confirmed']==0)?' ':'▲${data[district]['delta']['confirmed'].toString()}   ',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 10.0,
                                        ),
                                        children: <TextSpan> [
                                          TextSpan(
                                            text: data[district]['confirmed'].toString(),
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            )).toList(),
                          ),
                  );
                }
              break;
          }
        }
      ),
    );
  }
}
