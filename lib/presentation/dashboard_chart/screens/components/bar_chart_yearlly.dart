import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/constants.dart';


class BarChartYearly extends StatefulWidget {
  final List<String> xAxisFields;
  final List<String> yValues;
  final List<String> yValues1;
  const BarChartYearly({Key? key, required this.xAxisFields,required this.yValues,required this.yValues1,}) : super(key: key);

  @override
  State<BarChartYearly> createState() => _BarChartYearlyState();
}

class _BarChartYearlyState extends State<BarChartYearly> {
   List<_ChartData> data = [];
   List<_ChartData> data2 = [];
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    for(var i=0;i<widget.xAxisFields.length;i++)
      {
        var ch = _ChartData(widget.xAxisFields[i].toString(),double.parse(widget.yValues[i].toString()));
        data.add(ch);
      }
    for(var i=0;i<widget.xAxisFields.length;i++)
    {
      print("wwwww${widget.yValues1}");
      String val = widget.yValues1[i];
      print(val);
      var ch = _ChartData(widget.xAxisFields[i].toString(),double.parse(val));
      data2.add(ch);
    }
    // data = [
    //   _ChartData('CHN', 12),
    //   _ChartData('GER', 15),
    //   _ChartData('RUS', 30),
    //   _ChartData('BRZ', 6.4),
    //   _ChartData('IND', 14)
    // ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Income',
              color: Color.fromRGBO(8, 142, 255, 1)),

          ColumnSeries<_ChartData, String>(
            dataSource: data2,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Expense',
            color: Color.fromRGBO(255, 99, 71, 1), // Different color for comparison
          ),
        ]);
  }
}
class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}