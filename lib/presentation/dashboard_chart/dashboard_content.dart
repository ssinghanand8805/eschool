import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/MonthallyWidget.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/YearlyWidget.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/analytic_cards.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/discussions.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/top_referals.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/users_by_device.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/viewers.dart';
import '../common_widgets/custom_loader.dart';
import 'constants/constants.dart';
import 'constants/responsive.dart';
import 'dashboard_chart_controller.dart';


class DashboardContent extends GetView<DashboardChartController> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPadding),
        child: GetBuilder<DashboardChartController>(
          init: controller,
          builder: (_) {
            return FutureBuilder(
              future: controller.fetchDataFuture,
              builder: (context2,snapshot) {
                if (snapshot.connectionState !=
                    ConnectionState.done) {
                  return CustomLoader();
                }

                return Column(
                  children: [
                    SizedBox(
                      height: appPadding,
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  AnalyticCards(data: [
                                    "5",
                                    //controller.chartData.value.data!.monthCollection == null ? "" : controller.chartData.value.data!.monthCollection!.toString(),
                                   "7",
                                    // controller.chartData.value.data!.totalStudents!.toString(),
                                   "5",//controller.chartData.value.data!.monthCollection!.toString(),
                                  "6"]//controller.chartData.value.data!.monthCollection!.toString(),
                                     ),
                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  MonthalyWidget(xAxisFields: controller.chartData.value.data!.currentMonthDays!,
                                    yValues : controller.days_collection,//controller.chartData.value.data!.daysCollection!,
                                    yValues1: controller.days_expense,//controller.chartData.value.data!.daysExpense!,
                                  ),
                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  YearlyWidget(xAxisFields: controller.chartData.value.data!.totalMonth!,
                                    yValues : controller.chartData.value.data!.yearlyCollection!,//controller.chartData.value.data!.daysCollection!,
                                    yValues1: controller.chartData.value.data!.yearlyExpense!.map((e) => e.toString()).toList(),//controller.chartData.value.data!.daysExpense!,
                                  ),
                                  if (Responsive.isMobile(context))
                                    SizedBox(
                                      height: appPadding,
                                    ),
                                  // if (Responsive.isMobile(context)) Discussions(),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  Row(
                                    children: [
                                      if(!Responsive.isMobile(context))
                                        Expanded(
                                          child: TopReferals(data: controller.chartData!.value!.data!.roles!),
                                          flex: 2,
                                        ),

                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                  SizedBox(
                                    height: appPadding,
                                  ),
                                  if (Responsive.isMobile(context))
                                    SizedBox(
                                      height: appPadding,
                                    ),
                                  if (Responsive.isMobile(context)) TopReferals(data: controller.chartData!.value!.data!.roles!),
                                  if (Responsive.isMobile(context))
                                    SizedBox(
                                      height: appPadding,
                                    ),
                                  if (Responsive.isMobile(context)) UsersByDevice(),
                                ],
                              ),
                            ),
                            if (!Responsive.isMobile(context))
                              SizedBox(
                                width: appPadding,
                              ),
                            if (!Responsive.isMobile(context))
                              Expanded(
                                flex: 2,
                                child: UsersByDevice(),
                              ),
                          ],
                        ),
                      ],
                    ),

                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }
}
