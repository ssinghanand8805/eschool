import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../widgets/button.dart';
import '../../../widgets/customHtmlEditor.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../../widgets/timePickerTextField.dart';
import 'controller/select_old_session _details_controller.dart';

class SelectOldSessionScreen extends StatefulWidget {
  const SelectOldSessionScreen({Key? key});

  @override
  State<SelectOldSessionScreen> createState() => _SelectOldSessionScreenState();
}

class _SelectOldSessionScreenState extends State<SelectOldSessionScreen> {
  SelectOldSessionController controller = Get.put(SelectOldSessionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Select Old Session Details',
            style: theme.textTheme.titleMedium),
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
                labelText: 'Session',
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Session',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 7,
              ),
              MyCustomSD(
                labelText: 'Class',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Class',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 7,
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
                height: 7,
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
                height: 7,
              ),
              MyCustomSD(
                labelText: 'Subject',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Subject',
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                height: 240,
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: controller.lessonTopics.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.lessonTopics[index]['title']!,
                          style: theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600)
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .lessonTopics[index]['subtopics'].length,
                          itemBuilder: (context, subIndex) {
                            return Container(
                              height: 40,
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                                title: Text(controller.lessonTopics[index]
                                    ['subtopics'][subIndex]['title'],style: theme.textTheme.titleMedium,),
                                value: controller.lessonTopics[index]['subtopics']
                                    [subIndex]['isChecked'],
                                onChanged: (value) {
                                  setState(() {
                                    controller.lessonTopics[index]['subtopics']
                                        [subIndex]['isChecked'] = value;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('Select Old Session Details',
                  style: theme.textTheme.bodyMedium),
              SizedBox(
                height: 7,
              ),
              MyCustomSD(
                labelText: 'Class',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Class',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 7,
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
                height: 7,
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
                height: 7,
              ),
              MyCustomSD(
                labelText: 'Subject',
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.lesson,
                valFrom: "name",
                label: 'Subject',
                onChanged: (val) {
                  print(val);
                },
              ),
              SizedBox(
                height: 10,
              ),
              Button(icon: Icons.save, onTap: () {}, text: 'Save'),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
