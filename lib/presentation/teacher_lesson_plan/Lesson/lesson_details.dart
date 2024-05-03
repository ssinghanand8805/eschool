import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../widgets/button.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import 'controller/lesson_controller.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  LessonController controller = Get.put(LessonController());

  Widget buildCustomTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < controller.controllers.length; i++) {
      textFields.add(
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller.controllers[i],
                hint: 'lesson name',
                title: 'Lesson Name',
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete_forever, size: 18),
              onPressed: () {
                controller.controllers.removeAt(i);
                setState(() {});
              },
            ),
          ],
        ),
      );
    }
    return Column(children: textFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Add Lesson', style: theme.textTheme.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
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
              Button(
                icon: Icons.add,
                onTap: () {
                  controller.controllers.add(TextEditingController());
                  setState(() {});
                },
                text: 'Add More',
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: controller.AddMoreController.value,
                hint: 'lesson name',
                title: 'Lesson Name',
              ),
              SizedBox(height: 10),
              buildCustomTextFields(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FittedBox(
                  child: DataTable(
                    columnSpacing: 8,
                    columns: const [
                      DataColumn(label: Text('Class Section')),
                      DataColumn(label: Text('Subject Group')),
                      DataColumn(label: Text('Subject')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: controller.data.asMap().entries.map((entry) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Text("${entry.value['class']} ${'-'} ${entry.value['section']}",
                                style: theme.textTheme.bodySmall!),
                          ),
                          DataCell(
                            Text(entry.value['subjectGroup'], style: theme.textTheme.bodySmall!),
                          ),
                          DataCell(
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: entry.value['subjects']
                                  .map<Widget>((subject) => Text(subject, style: theme.textTheme.bodySmall!))
                                  .toList(),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, size: 15),
                                  onPressed: () {
                                    //editHomework(index);
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
                      );
                    }).toList(),
                  ),
                ),
              ),

              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: DataTable(
              //     columnSpacing: 8,
              //     columns: const [
              //       DataColumn(label: Text('Class Section')),
              //       DataColumn(label: Text('Subject Group')),
              //       DataColumn(label: Text('Subject')),
              //       DataColumn(label: Text('Action')),
              //     ],
              //     rows: controller.data.asMap().entries.map((entry) {
              //       return DataRow(
              //         cells: [
              //           DataCell(Text("${entry.value['class']} ${'-'} ${entry.value['section']}",
              //               style: theme.textTheme.bodySmall!)),
              //           DataCell(Text(entry.value['subjectGroup'],
              //               style: theme.textTheme.bodySmall!)),
              //       DataCell(
              //       Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: entry.value['subjects'].map<Widget>((subject) => Text(subject, style: theme.textTheme.bodySmall!)).toList(),
              //       )),
              //           DataCell(
              //             Row(
              //               children: [
              //                 IconButton(
              //                   icon: Icon(Icons.edit, size: 15),
              //                   onPressed: () {
              //                     //editHomework(index);
              //                   },
              //                 ),
              //                 IconButton(
              //                   icon: Icon(Icons.delete, size: 15),
              //                   onPressed: () {
              //                     print("Delete leave");
              //                   },
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
