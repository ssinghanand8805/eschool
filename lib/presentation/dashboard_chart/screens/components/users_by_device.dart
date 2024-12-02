import 'package:flutter/material.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/radial_painter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/constants.dart';


class UsersByDevice extends StatelessWidget {
  const UsersByDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Android', 170,Colors.greenAccent),
      ChartData('IOS', 5,Colors.blue)
    ];
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users by device',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(
              margin: EdgeInsets.all(appPadding),
              padding: EdgeInsets.all(appPadding),
              height: 230,
              child: SfCircularChart(
                  series: <CircularSeries>[
                    // Render pie chart
                    PieSeries<ChartData, String>(
                        dataSource: chartData,
                        pointColorMapper:(ChartData data,  _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                      dataLabelMapper:  (ChartData data, _) => data.y.toString() + ' ' + data.x,
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,  // Make data labels visible
                        labelPosition: ChartDataLabelPosition.outside,  // Position of the label
                        textStyle: TextStyle(fontSize: 12, color: Colors.black),  // Customize label text style
                        connectorLineSettings: ConnectorLineSettings(
                          type: ConnectorType.curve,  // Optional: Use curved connector lines
                          length: '15%',  // Length of the connector line
                          width: 2,  // Width of the connector line
                        ),

                      ),
                    )
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}