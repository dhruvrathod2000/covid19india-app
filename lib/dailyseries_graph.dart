import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19india/datetostring.dart';
class DailySeries {
  final DateTime date;
  final int deaths,confirmed,recovered;
  DailySeries({
    @required this.date,
    @required this.deaths,
    @required this.confirmed,
    @required this.recovered,
  });
}

class CombinedConfirmedChart extends StatefulWidget {

  final List<DailySeries> data;

  CombinedConfirmedChart({@required this.data});

  @override
  State<StatefulWidget> createState() => _CombinedConfirmedSelectionCallbackState();
}

class _CombinedConfirmedSelectionCallbackState extends State<CombinedConfirmedChart> {
  DateTime _time;
  Map <String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures['confirmed'] = datumPair.datum.confirmed;
        measures['deaths'] = datumPair.datum.deaths;
        measures['recovered']= datumPair.datum.recovered;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Confirmed',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.confirmed,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.amberAccent),
      ),

      charts.Series(
        id: 'Recovered',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.recovered,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.lightGreenAccent),
      ),

      charts.Series(
        id: 'Deceased',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.deaths,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

    List children = <Widget>[];
    children.add(
      Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: charts.TimeSeriesChart(
            series, 
            animate: true,
            selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener :  _onSelectionChanged,
                  ),
            ],
            behaviors: [
              new charts.LinePointHighlighter(
                dashPattern: [3,5],
                showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
                showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
              ),
              new charts.SelectNearest(
                eventTrigger: charts.SelectionTrigger.tapAndDrag,
              ),
            ],
          ),
      ),
    );
    children.add(
      Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
    );
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text("Date : ${DateToString().printDate(_time)}",
          style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
          )));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('$series: $value',
      style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
      ));
    });
    return new Column(children: children);
  }
}

class ConfirmedChart extends StatefulWidget {

  final List<DailySeries> data;

  ConfirmedChart({@required this.data});

  @override
  State<StatefulWidget> createState() => _ConfirmedSelectionCallbackState();
}



class _ConfirmedSelectionCallbackState extends State<ConfirmedChart> {
  DateTime _time;
  Map <String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.confirmed;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Confirmed',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.confirmed,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.amberAccent),
      ),
    ];

    List children = <Widget>[];
    children.add(
      Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: charts.TimeSeriesChart(
            series, 
            animate: true,
            selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener :  _onSelectionChanged,
                  ),
            ],
            behaviors: [
              new charts.LinePointHighlighter(
                dashPattern: [3,5],
                showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
                showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
              ),
              new charts.SelectNearest(
                eventTrigger: charts.SelectionTrigger.tapAndDrag,
              ),
            ],
        ),
      ),
    );
    children.add(
      Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
    );
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text("Date : ${DateToString().printDate(_time)}",
          style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
          )));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('$series: $value',
      style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
      ));
    });
    return new Column(children: children);
  }
}



class RecoveredChart extends StatefulWidget {

  final List<DailySeries> data;

  RecoveredChart({@required this.data});

  @override
  State<StatefulWidget> createState() => _RecoveredSelectionCallbackState();
}

class _RecoveredSelectionCallbackState extends State<RecoveredChart> {
  DateTime _time;
  Map <String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.recovered;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Recovered',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.recovered,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.lightGreenAccent),
      ),
    ];

    List children = <Widget>[];
    children.add(
      Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: charts.TimeSeriesChart(
            series, 
            animate: true,
            selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener :  _onSelectionChanged,
                  ),
            ],
            behaviors: [
              new charts.LinePointHighlighter(
                defaultRadiusPx: 4.0,
                showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
                showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
              ),
              new charts.SelectNearest(
                eventTrigger: charts.SelectionTrigger.tapAndDrag,
              ),
            ],
          ),
      ),
    );
    children.add(
      Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
    );
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text("Date : ${DateToString().printDate(_time)}",
          style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
          )));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('$series: $value',
      style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
      ));
    });
    return new Column(children: children);
  }
}



class DeathChart extends StatefulWidget {

  final List<DailySeries> data;

  DeathChart({@required this.data});

  @override
  State<StatefulWidget> createState() => _DeathSelectionCallbackState();
}

class _DeathSelectionCallbackState extends State<DeathChart> {
  DateTime _time;
  Map <String, num> _measures;

  _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    DateTime time;
    final measures = <String, num>{};

    if (selectedDatum.isNotEmpty) {
      time = selectedDatum.first.datum.date;
      selectedDatum.forEach((charts.SeriesDatum datumPair) {
        measures[datumPair.series.displayName] = datumPair.datum.deaths;
      });
    }

    // Request a build.
    setState(() {
      _time = time;
      _measures = measures;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Deceased',
        data: widget.data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.deaths,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];

    List children = <Widget>[];
    children.add(
      Container(
        height: MediaQuery.of(context).size.height*0.4,
        child: charts.TimeSeriesChart(
            series, 
            animate: true,
            selectionModels: [
                  new charts.SelectionModelConfig(
                    type: charts.SelectionModelType.info,
                    changedListener :  _onSelectionChanged,
                  ),
            ],
            behaviors: [
              new charts.LinePointHighlighter(
                dashPattern: [3,5],
                showHorizontalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
                showVerticalFollowLine:
                  charts.LinePointHighlighterFollowLineType.none,
              ),
              new charts.SelectNearest(
                eventTrigger: charts.SelectionTrigger.tapAndDrag,
              ),
            ],
          ),
      ),
    );
    children.add(
      Center(child: Text(
            'DATE',
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 15.0,
              letterSpacing: 2.0,
            ),
          ),),
    );
    if (_time != null) {
      children.add(new Padding(
          padding: new EdgeInsets.only(top: 5.0),
          child: new Text("Date : ${DateToString().printDate(_time)}",
          style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
          )));
    }
    _measures?.forEach((String series, num value) {
      children.add(new Text('$series: $value',
      style: TextStyle(color: Colors.blueGrey[900],fontSize: 15.0),
      ));
    });
    return new Column(children: children);
  }
}
