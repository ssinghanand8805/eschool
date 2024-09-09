import 'package:get_storage/get_storage.dart';
import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';

import '../common_widgets/CommonCard.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'model/ClassTimeTable.dart';

class ClassTimeTableScreen extends StatefulWidget {
  @override
  State<ClassTimeTableScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<ClassTimeTableScreen> {
  ClassTimeTableController controller = Get.put(ClassTimeTableController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Class\nTimetable!',
      imageUrl: 'assets/projectImages/assignmentpage.jpg',
      AppbarTitle: 'Class Timetable',
      widget: _buildChildWidget(),
    );
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
                            .classTimeTableModelObj.value!.timetable!.monday!),
                    _buildTimeTableCard(
                        title: 'Tuesday',
                        day: controller
                            .classTimeTableModelObj.value!.timetable!.tuesday!),
                    _buildTimeTableCard(
                        title: 'Wednesday',
                        day: controller.classTimeTableModelObj.value!.timetable!
                            .wednesday!),
                    _buildTimeTableCard(
                        title: 'Thursday',
                        day: controller.classTimeTableModelObj.value!.timetable!
                            .thursday!),
                    _buildTimeTableCard(
                        title: 'Friday',
                        day: controller
                            .classTimeTableModelObj.value!.timetable!.friday!),
                    _buildTimeTableCard(
                        title: 'Saturday',
                        day: controller.classTimeTableModelObj.value!.timetable!
                            .saturday!),
                    _buildTimeTableCard(
                        title: 'Sunday',
                        day: controller
                            .classTimeTableModelObj.value!.timetable!.sunday!),
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
             columnSpacing: 40.0, // Adjust the spacing between columns as needed
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
                    'Room',
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
                          singleDay.startTime!+'-',
                          style: theme.textTheme.titleMedium!,
                        ), Text(
                           singleDay.endTime!,
                          style: theme.textTheme.titleMedium!,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${singleDay.subjectName!} (${singleDay.sectionId!})',
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  DataCell(
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        singleDay.roomNo!,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                ],
              ))
                  .toList(),
            )

            : Center(
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
              )));
  }
}
