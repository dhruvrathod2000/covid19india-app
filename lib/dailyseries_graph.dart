import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

class ConfirmedChart extends StatelessWidget {

  final List<DailySeries> data;

  ConfirmedChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Confirmed',
        data: data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.confirmed,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.amberAccent),
      ),
    ];

    return charts.TimeSeriesChart(series, animate: true,behaviors: [
      charts.LinePointHighlighter(
        dashPattern: [3,5],
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.all,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.all),
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
      ],
    );
  }
}

class DeathChart extends StatelessWidget {
  
  final List<DailySeries> data;

  DeathChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Confirmed',
        data: data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.deaths,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red[600]),
      ),
    ];

    return charts.TimeSeriesChart(series, animate: true,behaviors: [
      charts.LinePointHighlighter(
        dashPattern: [3,5],
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.all,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.all),
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
    ],);
  }
}


class RecoveredChart extends StatelessWidget {
  
  final List<DailySeries> data;

  RecoveredChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DailySeries,DateTime>> series=[
      charts.Series(
        id: 'Confirmed',
        data: data,
        domainFn: (DailySeries series, _) => series.date,
        measureFn: (DailySeries series, _) => series.recovered,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.lightGreenAccent),
      ),
    ];

    return charts.TimeSeriesChart(series, animate: true,behaviors: [
      charts.LinePointHighlighter(
        dashPattern: [3,5],
          showHorizontalFollowLine:
              charts.LinePointHighlighterFollowLineType.all,
          showVerticalFollowLine:
              charts.LinePointHighlighterFollowLineType.all),
      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)
    ],);
  }
}