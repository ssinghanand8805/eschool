import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lerno/presentation/common_widgets/CommonCard.dart';
import 'package:lerno/presentation/common_widgets/MainBody.dart';

import '../../theme/theme_helper.dart';
import '../class_time_table/weekTab.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/lesson_plan_controller.dart';
import 'modal/lesson_modal.dart';

class LessonPlanScreen extends GetWidget<LessonPlanController> {
  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: 'Your Lesson Plan\nis here!',
        imageUrl: "assets/projectImages/lessonplanpage.jpg",
        AppbarTitle: "Lesson Plan",
        widget: _buildChildWidget());
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture, //controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            } else {
              return WeekTabScreen(
                tabTitles: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'],
                tabContents: [
                  _buildTimeTableCard(
                      title: 'Monday',
                      day: controller
                          .lessonPlanModelObj.value.timetable!.monday!),
                  _buildTimeTableCard(
                      title: 'Tuesday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.tuesday!),
                  _buildTimeTableCard(
                      title: 'Wednesday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.wednesday!),
                  _buildTimeTableCard(
                      title: 'Thursday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.thursday!),
                  _buildTimeTableCard(
                      title: 'Friday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.friday!),
                  _buildTimeTableCard(
                      title: 'Saturday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.saturday!),
                  _buildTimeTableCard(
                      title: 'Sunday',
                      day: controller
                          .lessonPlanModelObj.value!.timetable!.sunday!),
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required String title, List<Day>? day}) {


    if (day!.isEmpty) {
      return _buildNoDataWidget();
    }

    Map<String, List<Day>> lessonsGroupedByDay = {};

    if (day != null) {
      for (var singleDay in day) {
        if (singleDay.lessonName != null) {
          lessonsGroupedByDay
              .putIfAbsent(singleDay.lessonName!, () => [])
              .add(singleDay);
        }
      }
    }

    return Column(
      children: lessonsGroupedByDay.entries.map((entry) {
        List<Day> lessonDays = entry.value;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: DataTable(
              dividerThickness: 0.1,
              columnSpacing: 28.0,
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Time',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.lightBlue, fontSize: 13),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Subject',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.lightBlue, fontSize: 13),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Lesson',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.lightBlue, fontSize: 13),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Topic',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: Colors.lightBlue, fontSize: 13),
                  ),
                ),
              ],
              rows: lessonDays
                  .map<DataRow>(
                    (Day singleDay) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${singleDay.timeFrom!} - ${singleDay.timeTo!}",
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                        DataCell(
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${singleDay.name!.capitalize}  (${singleDay.section!})',
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              singleDay.lessonName!,
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ),
                        DataCell(
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              singleDay.topicName!,
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/projectImages/no_data.png",
          ),
          const SizedBox(height: 16),
          Text(
            'No data found!',
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}
