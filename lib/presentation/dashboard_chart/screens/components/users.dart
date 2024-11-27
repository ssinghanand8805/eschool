import 'package:flutter/material.dart';


import '../../../../theme/theme_helper.dart';
import '../../constants/constants.dart';
import 'bar_chart_users.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

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
            "Fees Collection & Expenses For November 2024",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
          Expanded(
            child: BarChartUsers(),
          )
        ],
      ),
    );
  }
}
