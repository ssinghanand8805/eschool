
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../widgets/button.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/CommonCard.dart';
import '../../teacher_lesson_plan/Lesson/modal/lesson_modal.dart';
import 'add_class_time_table.dart';
import 'class_timetable_controller.dart';

class ClassTimetableScreen extends StatefulWidget {
  const ClassTimetableScreen({Key? key});

  @override
  State<ClassTimetableScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<ClassTimetableScreen> {
  ClassTimetableController controller = Get.put(ClassTimetableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text(
            'Class Time Table',
            style: theme.textTheme.bodyLarge,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddClassTimetable()),);
                }
                ,
                child: Container(
                  height: 28,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade50
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,size: 17,),
                      Text("Add",style: theme.textTheme.titleMedium,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: GetBuilder(
            init: controller,
            builder: (_) {
              // return FutureBuilder(
              //   future: controller.fetchDataFuture, //controller.getData(context),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState != ConnectionState.done) {
              //       return CustomLoader(); // CustomLoader();
              //     } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCustomSD(
                        labelText: 'Teachers',
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.lesson,
                        valFrom: "name",
                        label: 'Teachers name',
                        onChanged: (val) {
                          print(val);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyCustomSD(
                        labelText: 'Section',
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.lesson,
                        valFrom: "name",
                        label: 'Section',
                        onChanged: (val) {
                          print(val);
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
                      ),
                      _buildTimeTableCard(
                        title: 'Tuesday',
                      ),
                      _buildTimeTableCard(
                        title: 'Wednesday',
                      ),
                      _buildTimeTableCard(
                        title: 'Thursday',
                      ),
                      _buildTimeTableCard(
                        title: 'Friday',
                      ),
                      _buildTimeTableCard(
                        title: 'Saturday',
                      ),
                      _buildTimeTableCard(
                        title: 'Sunday',
                      ),
                    ],
                  ),
                ),
              );
            }
            // },
            //     );
            //   },
            // ),
            ));
  }

  Widget _buildTimeTableCard({required String title, List<Day>? day}) {
    return CommonCard(
        title: title,
        newWidget: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(children: [Icon(Icons.subject,size: 15,), SizedBox(width: 10,),Text("Subject :English (210)",style: theme.textTheme.titleMedium,)]),
              Row(children: [Icon(Icons.timelapse,size: 15,), SizedBox(width: 10,),Text("9:00 AM - 09:40 AM",style: theme.textTheme.titleMedium,)]),
              Row(children: [Icon(Icons.person,size: 15,), SizedBox(width: 10,),Text("Shivam Verma (9002)",style: theme.textTheme.titleMedium,)]),
              Row(children: [Icon(Icons.meeting_room,size: 15,), SizedBox(width: 10,),Text("Room No.: 120",style: theme.textTheme.titleMedium,)]),
            ],
          ),
        ));
  }
}
