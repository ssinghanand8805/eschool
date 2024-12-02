import 'package:flutter/material.dart';


import '../../../../theme/theme_helper.dart';
import '../../constants/constants.dart';
import 'bar_chart_users.dart';
import 'bar_chart_yearlly.dart';

class YearlyWidget extends StatelessWidget {
  final List<String> xAxisFields;
  final List<String> yValues;
  final List<String> yValues1;
  const YearlyWidget({Key? key, required this.xAxisFields,required this.yValues,required this.yValues1,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: EdgeInsets.all(appPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fees Collection & Expenses For Session 2024",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
          Expanded(
            child: BarChartYearly(xAxisFields:xAxisFields,yValues:yValues,yValues1:yValues1),
          )
        ],
      ),
    );
  }
}
