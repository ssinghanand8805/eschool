import 'package:get_storage/get_storage.dart';
import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/class_time_table/weekTab.dart';

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
      widget: Column(
        children: [
          _buildChildWidget(),
        ],
      ),
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
              return Expanded(
                child: WeekTabScreen(
                  tabTitles: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'],
                  tabContents: [
                    _buildTimeTableCard(context: context,  day: controller.classTimeTableModelObj.value!.timetable!.monday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.tuesday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.wednesday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.thursday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.friday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.saturday!),
                    _buildTimeTableCard(context: context, day: controller.classTimeTableModelObj.value!.timetable!.sunday!),
                  ],
                )
              );
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required BuildContext context,  required List<Day> day}) {
    return SubjectWiseScheduleCard(
      day: day,
      theme: Theme.of(context),
    );
  }
}


class SubjectWiseScheduleCard extends StatelessWidget {

final List<Day> day;
final ThemeData theme;

const SubjectWiseScheduleCard({
Key? key,
required this.day,
required this.theme,
}) : super(key: key);

@override
Widget build(BuildContext context) {
  if (day.isEmpty) {
    return _buildNoDataWidget();
  }

  // Group the schedule by subject
  Map<String, List<Day>> subjectWiseSchedule = {};
  for (var schedule in day) {
    String subjectKey = '${schedule.subjectName} (${schedule.sectionId})';
    if (!subjectWiseSchedule.containsKey(subjectKey)) {
      subjectWiseSchedule[subjectKey] = [];
    }
    subjectWiseSchedule[subjectKey]!.add(schedule);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: subjectWiseSchedule.length,
          itemBuilder: (context, index) {
            String subject = subjectWiseSchedule.keys.elementAt(index);
            List<Day> schedules = subjectWiseSchedule[subject]!;
            return _buildSubjectCard(subject, schedules);
          },
        ),
      ),
    ],
  );
}

Widget _buildSubjectCard(String subject, List<Day> schedules) {
  return Container(
    margin: const  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),// Space between cards
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color:  Colors.grey.shade300,), // Set your desired border color
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 14,fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8.0),
          ...schedules.map((schedule) => _buildScheduleRow(schedule)).toList(),
        ],
      ),
    ),
  );
}

Widget _buildScheduleRow(Day schedule) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            '${schedule.startTime} - ${schedule.endTime}',
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 14,color: Colors.grey.shade700),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Room No.  ",
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 13,fontWeight: FontWeight.bold),
            ),
            Text(
              "${schedule.roomNo!}",
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 13,color: Colors.grey.shade700),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildNoDataWidget() {
  return Card(
    margin: const EdgeInsets.all(8.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/projectImages/no_data.png",
            height: 80,
          ),
          const SizedBox(height: 16),
          Text(
            'No data found!',
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    ),
  );
}
}