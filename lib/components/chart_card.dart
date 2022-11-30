import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/models/bars.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          if (snapshot.hasData) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SfCartesianChart(
                backgroundColor: Colors.transparent,
                title: ChartTitle(
                  text: AppLocalizations.of(context)!.graphTitle,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                zoomPanBehavior: ZoomPanBehavior(
                    enablePinching: true,
                    enablePanning: true,
                    zoomMode: ZoomMode.x),
                primaryXAxis: CategoryAxis(
                  desiredIntervals: 30,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                series: <ChartSeries<Bar, String>>[
                  SplineSeries(
                    color: const Color(0xFFFFD700),
                    width: 2,
                    dataSource: snapshot.data!.bars,
                    xValueMapper: (Bar c, i) => (DateFormat('MM/dd').format(
                            DateTime.now().subtract(Duration(
                                days: snapshot.data!.bars.length - i))))
                        .toString(),
                    yValueMapper: (Bar c, i) => c.close,
                    animationDuration: 1500,
                    splineType: SplineType.natural,
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
