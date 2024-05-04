import 'package:flutter/cupertino.dart';
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

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0,right: 5,top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lesson Topic",style: theme.textTheme.titleSmall,),
                          Text("Completion \nDate",style: theme.textTheme.titleSmall),
                          Text("Status",style: theme.textTheme.titleSmall),
                          Text("Action",style: theme.textTheme.titleSmall),
                        ],
                      ),
                    ),
                    Expanded(
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
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columnSpacing: Get.width*0.2,
                                      columns: const [
                                        DataColumn(label: Text('')),
                                        DataColumn(label: Text('')),
                                        DataColumn(label: Text('')),
                                      ],
                                      rows: controller.data.asMap().entries.map((entry) {
                                        int index = entry.key;
                                        return DataRow(
                                          cells: [
                                            DataCell(Text(controller.lessonTopics[index]['subtopics'][subIndex]['title'].toString(),
                                                style: theme.textTheme.bodySmall!)),
                                            DataCell(Center(
                                              child: Text(controller.lessonTopics[index]['subtopics'][subIndex]['competitionDate'].toString(),
                                                  style: theme.textTheme.bodySmall!),
                                            )),
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
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
