import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../widgets/customHtmlEditor.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../../widgets/timePickerTextField.dart';
import 'controller/teacher_lesson_plan_controller.dart';

class AddLessonPLan extends StatefulWidget {
  const AddLessonPLan({Key? key});

  @override
  State<AddLessonPLan> createState() => _AddLessonPLanState();
}

class _AddLessonPLanState extends State<AddLessonPLan> {
  TeacherLessonPlanController controller =
      Get.put(TeacherLessonPlanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Add Lesson Plan', style: theme.textTheme.titleMedium),
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
                labelText: 'Lesson',
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Lesson',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 5,
              ),
              MyCustomSD(
                labelText: 'Topic',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Topic',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                controller: controller.subtopic.value,
                hint: 'sub topic',
                title: 'Sub Topic',
              ),
              DatePickerTextField(
                controller: controller.addLessonDate.value,
                onDateSelected: (date) {
                  controller.addLessonDate.value.text =
                      DateFormat('dd/MM/yyyy').format(date);
                },
                title: 'Date',
              ),
              TimePickerTextField(
                controller: controller.timeFrom.value,
                onTimeSelected: (time) {
                  controller.timeFrom.value.text =
                      controller.formatTimeOfDay(time);
                },
                title: 'Time From',
              ),
              TimePickerTextField(
                controller: controller.timeTo.value,
                onTimeSelected: (time) {
                  controller.timeTo.value.text =
                      controller.formatTimeOfDay(time);
                },
                title: 'Time To',
              ),
              CustomTextField(
                controller: controller.lectureYoutubeUrl.value,
                hint: 'lecture youTube url',
                title: 'Lecture YouTube URL',
              ),
              CustomTextField(
                controller: controller.teachingMethod.value,
                hint: 'teaching method',
                title: 'Teaching Method',
              ),
              CustomTextField(
                controller: controller.generalObjectives.value,
                hint: 'general objectives',
                title: 'General Objectives',
              ),
              CustomTextField(
                controller: controller.previousKnowledge.value,
                hint: 'previous knowledge',
                title: 'Previous Knowledge',
              ),
              CustomTextField(
                controller: controller.comprehensiveQuestions.value,
                hint: 'comprehensive questions',
                title: 'Comprehensive Questions',
              ),
              CustomHtmlEditor(
                controller: controller.presentation.value,
                height: 250,
                title: 'Presentation',
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    height: 35,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green.shade300,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
