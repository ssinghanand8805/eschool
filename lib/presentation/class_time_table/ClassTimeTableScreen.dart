import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';

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
          future:  controller.fetchDataFuture,//controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            }
            else {
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
        newWidget: day.length > 0 ? DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Time',
                  style: TextStyle(fontStyle: FontStyle.italic,color: Colors.lightBlue),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Subject',
                  style: TextStyle(fontStyle: FontStyle.italic,color: Colors.lightBlue),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Room',
                  style: TextStyle(fontStyle: FontStyle.italic,color: Colors.lightBlue),
                ),
              ),
            ),
          ],
          rows: day.map<DataRow>((Day singleDay) => DataRow(
            cells: <DataCell>[
              DataCell(Text(singleDay.startTime! + ' - ' +  singleDay.endTime!)), // Assuming Day has a time attribute
              DataCell(Text('${singleDay.subjectName!} ( ${singleDay.sectionId!} )')), // Assuming Day has a subject attribute
              DataCell(Text(singleDay.roomNo!)), // Assuming Day has a roomNo attribute
            ],
          )).toList(),



        ) : Center(child: Image.asset("assets/projectImages/no_data.png",height: 100,)))  ;
  }
}
