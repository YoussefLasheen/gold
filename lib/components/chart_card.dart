import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/bars.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartCard extends StatefulWidget {
  const ChartCard({super.key});

  @override
  State<ChartCard> createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  late Future<Bars> futureAlbum;

  @override
  void initState() {
    super.initState();
    
    futureAlbum = fetchBars();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Bars>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          child: SfCartesianChart(
            backgroundColor: Colors.transparent,
            title: ChartTitle(
              text: 'سعر أونصه الدهب بالدولار',
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            series: <ChartSeries<Bar, String>>[
              SplineSeries(
                color: Color(0xFFFFD700),
                width: 2,
                dataSource: snapshot.data!.bars,
                xValueMapper: (Bar c, i) => (DateFormat('MM/dd').format(DateTime.now().subtract(Duration(days: 30-i)))).toString(),
                yValueMapper: (Bar c, i) => c.close,
                animationDuration: 1500,
                splineType: SplineType.natural,
              ),
            ],
          ),
        );
        
        }return Container();
      }
    );
  }
}