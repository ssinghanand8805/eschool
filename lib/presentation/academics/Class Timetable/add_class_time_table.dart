import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/button.dart';

import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../../widgets/timePickerTextField.dart';
import 'class_timetable_controller.dart';

class AddClassTimetable extends StatefulWidget {
  const AddClassTimetable({Key? key});

  @override
  State<AddClassTimetable> createState() => _AddClassTimetableState();
}

class _AddClassTimetableState extends State<AddClassTimetable> {
  ClassTimetableController controller =
      Get.put(ClassTimetableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Add Class Time Table', style: theme.textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyCustomSD(
                hideSearch: true,
                labelText: 'Class',
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Class',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 5,
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
                height: 5,
              ),
              MyCustomSD(
                labelText: 'Subject Group',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Subject Group',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Button(icon: Icons.search, onTap: (){

              }, text: 'Search'),
              SizedBox(
                height: 10,
              ),
              Text("Select parameter to generate time table\nquickly",style: theme.textTheme.bodyMedium,),

              SizedBox(
                height: 10,
              ),
              TimePickerTextField(
                controller: controller.startTimeC.value,
                onTimeSelected: (time) {
                  controller.startTimeC.value.text =
                      controller.formatTimeOfDay(time);
                },
                title: 'Period Start Time',
              ),
              CustomTextField(
                controller: controller.durationC.value,
                hint: 'duration (minute)',
                title: 'Duration (minute)',
              ),
              CustomTextField(
                controller: controller.intervalC.value,
                hint: 'interval (minute)',
                title: 'Interval (minute)',
              ),
              CustomTextField(
                controller: controller.roomNoC.value,
                hint: 'room no.',
                title: 'Room No.',
              ),            ],
          ),
        ),
      ),
    );
  }
}
