import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    //print(data);
    int deltaActive=int.parse(data['deltaconfirmed'])-int.parse(data['deltarecovered'])-int.parse(data['deltadeaths']);
    Color deltaColor= (deltaActive > 0)?Colors.red[600]:Colors.lightGreenAccent;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Total Cases'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/india.png',
                  height: 60.0,
                  width: 80.0,),
                SizedBox(width: 15.0,),
                Flexible(
                  child: Text(
                    'India',
                    style: TextStyle(
                      color: Colors.blueGrey[400],
                      fontSize: 35.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.blueGrey[800],
              height: 50.0,
            ),
            RaisedButton.icon(
              highlightColor: Colors.lightGreenAccent,
              color: Colors.blueGrey[500],
              onPressed: () {
                Navigator.pushNamed(context,'/loadingstate');
              },
              icon: Icon(Icons.table_chart,
                color: Colors.blueGrey[900],),
              label: Text('State-wise',
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.grey[900])
              ),
            ),
            SizedBox(height:15.0 ,),
            RaisedButton.icon(
              highlightColor: Colors.lightGreenAccent,
              color: Colors.blueGrey[500],
              onPressed: () {
                Navigator.pushNamed(context,'/filtergraph');
              },
              icon: Icon(Icons.show_chart,
                color: Colors.blueGrey[900],),
              label: Text('Graphs',
                style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 20.0,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.grey[900])
              ),
            ),
            SizedBox(height:15.0 ,),
            Text(
              'CONFIRMED',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[400],
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 15.0,),
            RichText(
              text: TextSpan(
                text: data['confirmed'].toString(),
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.blueGrey[200],
                  fontSize: 20.0,
                ),
                children: <TextSpan> [
                  TextSpan(
                      text: (data['deltaconfirmed']=='0')?' ':'  [▲${data['deltaconfirmed'].toString()}]',
                    style: TextStyle(
                      color: Colors.red[600],
                      letterSpacing: 2.0,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0,),
            Text(
              'RECOVERED',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[400],
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 15.0,),
            RichText(
              text: TextSpan(
                text: data['recovered'].toString(),
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.blueGrey[200],
                  fontSize: 20.0,
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: (data['deltarecovered']=='0')?' ':'  [▲${data['deltarecovered'].toString()}]',
                    style: TextStyle(
                      color: Colors.lightGreenAccent,
                      letterSpacing: 2.0,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0,),
            Text(
              'DEATHS',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[400],
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 15.0,),
            RichText(
              text: TextSpan(
                text: data['deaths'].toString(),
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.blueGrey[200],
                  fontSize: 20.0,
                ),
                children: <TextSpan> [
                  TextSpan(
                    text: (data['deltadeaths']=='0')?' ':'  [▲${data['deltadeaths'].toString()}]',
                    style: TextStyle(
                      color: Colors.red[600],
                      letterSpacing: 2.0,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0,),
            Text(
              'ACTIVE',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[400],
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 15.0,),
            RichText(
              text: TextSpan(
                text: data['active'].toString(),
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.blueGrey[200],
                  fontSize: 20.0,
                ),
                children: <TextSpan> [
                  TextSpan(
                      text: (deltaActive==0)?' ':(deltaActive > 0 ? '  [▲${deltaActive.toString()}]': '  [▼${(deltaActive*-1).toString()}]'),
                    style: TextStyle(
                      color: deltaColor,
                      letterSpacing: 2.0,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0,),
            Text(
              'MORTALITY RATE',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[400],
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              '${(double.parse(data['deaths'])/double.parse(data['confirmed'])).toStringAsFixed(2)}%',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.blueGrey[200],
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
