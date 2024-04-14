import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:learnladder/presentation/common_widgets/CommonCard.dart';
import 'package:learnladder/presentation/common_widgets/MainBody.dart';

import '../../theme/theme_helper.dart';
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
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeTableCard(
                        title: 'Monday',
                        day: controller
                            .lessonPlanModelObj.value!.timetable!.monday!),
                    _buildTimeTableCard(
                        title: 'Tuesday',
                        day: controller
                            .lessonPlanModelObj.value!.timetable!.tuesday!),
                    _buildTimeTableCard(
                        title: 'Wednesday',
                        day: controller.lessonPlanModelObj.value!.timetable!
                            .wednesday!),
                    _buildTimeTableCard(
                        title: 'Thursday',
                        day: controller.lessonPlanModelObj.value!.timetable!
                            .thursday!),
                    _buildTimeTableCard(
                        title: 'Friday',
                        day: controller
                            .lessonPlanModelObj.value!.timetable!.friday!),
                    _buildTimeTableCard(
                        title: 'Saturday',
                        day: controller.lessonPlanModelObj.value!.timetable!
                            .saturday!),
                    _buildTimeTableCard(
                        title: 'Sunday',
                        day: controller
                            .lessonPlanModelObj.value!.timetable!.sunday!),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required String title, required List<Day> day}) {

    return CommonCard(
        title: title,
        newWidget: day.length > 0
            ?DataTable(
          dividerThickness: 0.1,
          columnSpacing: 25.0, // Adjust the spacing between columns as needed
          columns:  <DataColumn>[
            DataColumn(
              label: Text(
                'Time',
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.lightBlue,fontSize: 16),
              ),
            ),
            DataColumn(
              label: Text(
                'Subject',
                style: theme.textTheme.titleMedium!.copyWith(color: Colors.lightBlue,fontSize: 16),
              ),
            ),
            DataColumn(
              label: Text(
                'Syllabus',
                style:  theme.textTheme.titleMedium!.copyWith(color: Colors.lightBlue,fontSize: 16),
              ),
            ),
          ],
          rows: day
              .map<DataRow>((Day singleDay) => DataRow(

            cells: <DataCell>[

              DataCell(
                Row(
                  children: [
                    Text(
                      singleDay.timeFrom!+'-',
                      style: theme.textTheme.titleMedium!.copyWith(fontSize: 12),
                    ), Text(
                      singleDay.timeTo!,
                      style: theme.textTheme.titleMedium!.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              DataCell(
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${singleDay.name!} (${singleDay.section!})',
                    style: theme.textTheme.titleMedium!.copyWith(fontSize: 12),
                  ),
                ),
              ),
              DataCell(
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "dd",
                    style: theme.textTheme.titleMedium!.copyWith(fontSize: 12),
                  ),
                ),
              ),
            ],
          ))
              .toList(),
        )

            : Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Image.asset(
                    "assets/projectImages/no_data.png",
                    height: 80,
                  ),
                  Text(
                    'No data found!',
                    style: theme.textTheme.titleMedium,
                  )
                ],
              ),
            )));
  }
}


