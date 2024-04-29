import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import '../../widgets/myCustomsd.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/teacher_lesson_plan_controller.dart';
import 'modal/lesson_modal.dart';

class TeacherLessonPlanScreen extends GetWidget<TeacherLessonPlanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
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

                      MyCustomSD(
                        labelText: 'Teachers',
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.students,
                        valFrom: "name",
                        label: 'Teachers name',
                        onChanged: (val) {
                          print(val);
                          // if(val!=null){
                          //   controller.updateDutyFor = val['id'];
                          //
                          // }
                          // else{
                          //   controller.updateDutyFor=0;
                          // }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Button(icon: Icons.search, onTap: () {}, text: 'Search'),
                      SizedBox(
                        height: 10,
                      ),
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
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildTimeTableCard({required String title, required List<Day> day}) {
    return CommonCard(
        title: title,
        newWidget: day.length > 0
            ? DataTable(
                dividerThickness: 0.1,
                columnSpacing:
                    25.0, // Adjust the spacing between columns as needed
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Subject',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.lightBlue, fontSize: 16),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Class',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.lightBlue, fontSize: 16),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Room No.',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.lightBlue, fontSize: 16),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Action',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: Colors.lightBlue, fontSize: 16),
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
                                    singleDay.timeFrom! + '-',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    singleDay.timeTo!,
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            DataCell(
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '${singleDay.name!} (${singleDay.section!})',
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            DataCell(
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "dd",
                                  style: theme.textTheme.titleMedium!
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 15),
                                    onPressed: () {
                                      showEditLeave(context);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, size: 15),
                                    onPressed: () {
                                      print("Delete leave");
                                    },
                                  ),
                                ],
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

  void showEditLeave(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Edit Lesson Plan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyCustomSD(
                    hideSearch: true,
                    labelText: 'Lesson',
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Lesson',
                    onChanged: (val) {
                      print(val);
                      // if(val!=null){
                      //   controller.updateDutyFor = val['id'];
                      //
                      // }
                      // else{
                      //   controller.updateDutyFor=0;
                      // }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Topic',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch:  controller.students,
                    valFrom: "name",
                    label: 'Topic',
                    onChanged: (val) {
                      print(val);
                      // if(val!=null){
                      //   controller.updateDutyFor = val['id'];
                      //
                      // }
                      // else{
                      //   controller.updateDutyFor=0;
                      // }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
                        child: Text('Sub Topic',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green.shade50,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: 'Sub Topic',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () {
                            // Show date picker for apply date
                          },
                        ),
                      ),
                    ],
                  ),
                  MyCustomSD(
                    labelText: 'Student',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Student',
                    onChanged: (val) {
                      print(val);
                      // if(val!=null){
                      //   controller.updateDutyFor = val['id'];
                      //
                      // }
                      // else{
                      //   controller.updateDutyFor=0;
                      // }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: '04/05/2024',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          onTap: () {
                            // Show date picker for apply date
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('Time From',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: '12:00 PM', // Change the hint text to a time format
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          onTap: () async {
                            // Show time picker
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              // Handle the selected time
                              // You can update the TextField with the selected time
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('Time To',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: '12:00 PM', // Change the hint text to a time format
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          onTap: () async {
                            // Show time picker
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            if (pickedTime != null) {
                              // Handle the selected time
                              // You can update the TextField with the selected time
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
                        child: Text('Reason',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green.shade50,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: 'reason',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () {
                            // Show date picker for apply date
                          },
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle form submission
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
