import 'package:flutter/material.dart';

class MyDataTable extends StatefulWidget {
  @override
  _MyDataTableState createState() => _MyDataTableState();
  final List data;
  MyDataTable({this.data});
}

class _MyDataTableState extends State<MyDataTable> {
  List duplicateData=[];
  List data;
  List filterData(String searched) {
    data=widget.data;
    List newData=[];
    //print(data);
    //print(searched);
    String stateName='';
    data.forEach((stateData) {
      stateName=stateData['state'];
      if(stateName.contains(searched)){
        newData.add(stateData);
      }
    });
    return newData;
  }

  @override
  Widget build(BuildContext context) {
    data  = widget.data;
    duplicateData = duplicateData.isEmpty? data : duplicateData;
    //print(duplicateData);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 17.0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: TextFormField(
              autocorrect: false,
              onChanged: (searched){
                setState(() {
                  duplicateData = filterData(searched);
                });
              },
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'Search',
                labelText:'Press on any row for district data',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Colors.blueGrey[200],
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                columnSpacing:10,
                columns: [
                  DataColumn(
                    label: Text('State/UT',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey[300],
                    ),
                    ),
                    tooltip: "State name / Union Territory",
                  ),
                  DataColumn(
                    label: Text("C",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey[300],
                    ),
                    ),
                    numeric: true,
                    tooltip: "Confirmed Cases",
                  ),
                  DataColumn(
                      label: Text('A',
                      style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.blueGrey[300],
                    ),
                      ),
                      numeric: true,
                      tooltip: "Active Cases",
                  ),
                  DataColumn(
                      label: Text('R',
                      style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey[300],
                    ),
                      ),
                      numeric: true,
                      tooltip: "Recovered Cases"
                  ),
                  DataColumn(
                    label: Text('D',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey[300],
                    ),
                    ),
                    numeric: true,
                    tooltip: "Deceased",
                  ),
                ],
                rows: duplicateData.map((state) => DataRow(
                  //onSelectChanged: (b) { if(b){print('Selected state is ${state['state']}');}},
                  cells: [
                    DataCell(
                      Container(
                        width: 120,
                        child: Text(state['state']),
                      ),
                      onTap: () {
                        //print('Selected state is ${state['state']}');
                        Navigator.pushNamed(context,'/district',arguments: {
                          'state' : state['state'],
                        });
                        },
                    ),
                    DataCell(
                      RichText(
                        text: TextSpan(
                          text: (state['deltaconfirmed']=="0")?'':'▲${state['deltaconfirmed'].toString()}  ',
                            style: TextStyle(
                              color: Colors.red[600],
                              fontSize: 10.0,
                            ),
                          children: <TextSpan> [
                            TextSpan(
                              text: state['confirmed'],
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15.0,
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
                        fontSize: 15.0,
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
                                fontSize: 15.0,
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
                                fontSize: 15.0,
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
          ),
        ],
      ),
    );
  }
}