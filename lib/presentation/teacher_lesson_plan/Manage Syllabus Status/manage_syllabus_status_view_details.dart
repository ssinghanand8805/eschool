import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../widgets/button.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import 'manage_syllabus_status_controller.dart';

class ManageSyllabusStatusScreen extends StatefulWidget {
  const ManageSyllabusStatusScreen({Key? key});

  @override
  State<ManageSyllabusStatusScreen> createState() => _ManageSyllabusStatusState();
}

class _ManageSyllabusStatusState extends State<ManageSyllabusStatusScreen> {
  ManageSyllabusStatusController controller = Get.put(ManageSyllabusStatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Manage Syllabus Status', style: theme.textTheme.titleMedium),
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
              Button(icon: Icons.search, onTap: () {}, text: 'Search'),
              SizedBox(
                height: 10,
              ),
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
                            Container(
                              width: 200, // Adjust the width as needed
                              child: Wrap(
                                spacing: 10.0, // Add spacing between subjects
                                children: entry.value['subjects']
                                    .map<Widget>((subject) => Text(subject, style: theme.textTheme.bodySmall!))
                                    .toList(),
                              ),
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

                                  icon: Icon(Icons.close, size: 15),
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
            ],
          ),
        ),
      ),
    );
  }
}
