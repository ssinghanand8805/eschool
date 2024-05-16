import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/exam_controller.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class ExamView extends GetView<ExamController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addExam(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exam List",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.searchC.value,
              hint: "Search...",
              title: "",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.1,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Exam Name')),
                  DataColumn(label: Text('Class (Section)')),
                  DataColumn(label: Text('Term')),
                  DataColumn(label: Text('Subject Included')),
                  DataColumn(label: Text('Exam Published')),
                  DataColumn(label: Text('Published Result')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Created At')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Text(
                        "gree or step in value, or intensity.",
                        maxLines: null,
                        overflow: TextOverflow.ellipsis,
                      )),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              tooltip: "Assign/View Student",
                              icon: Icon(Icons.tag, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.assign_view_studentRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Subjects",
                              icon: Icon(Icons.book, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.exam_subjectRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Marks",
                              icon: Icon(Icons.branding_watermark_sharp,
                                  size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.exam_markRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Attendance",
                              icon: Icon(Icons.fact_check, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.exam_attendanceRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Teacher Remark",
                              icon: Icon(Icons.chat_bubble_outline, size: 15),
                              onPressed: () {
                                //editHomework(index);
                              },
                            ),
                            IconButton(
                              tooltip: "Generate Rank",
                              icon: Icon(Icons.chrome_reader_mode, size: 15),
                              onPressed: () {
                                //editHomework(index);
                              },
                            ),
                            IconButton(
                              tooltip: "Edit",
                              icon: Icon(Icons.edit, size: 15),
                              onPressed: () {
                                print("Edit leave");
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
          ],
        ),
      ),
    );
  }

  addExam(context) {
    AlertDialogue().show(context, newWidget: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Add Exam",
          style: theme.textTheme.bodyMedium,
        ),
        CustomTextField(
          controller: controller.examNameC.value,
          hint: "Exam Name",
          title: "",
        ),
        Obx(() {
          return Row(
            children: [
              Checkbox(
                  checkColor: Colors.white,
                  //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                  value: controller.isChecked.value,
                  onChanged: (value) {
                    controller.isChecked.value = value!;
                    print(value);
                  }),
              Text("Publish",style: theme.textTheme.titleMedium,)
            ],
          );
        }),
        CustomTextField(
          controller: controller.descriptionC.value,
          hint: "Description",
          title: "",
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomSD(
              borderColor: Colors.grey,
              listToSearch: controller.demo,
              valFrom: 'name',
              label: "Select Term",
              onChanged: (value) {},
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: MyCustomSD(
              borderColor: Colors.grey,
              listToSearch: controller.demo,
              valFrom: 'name',
              label: "Select Class",
              onChanged: (value) {},
            )),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomSD(
              borderColor: Colors.grey,
              listToSearch: controller.demo,
              valFrom: 'name',
              label: "Select Section",
              onChanged: (value) {},
            )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: MyCustomSD(
              borderColor: Colors.grey,
              listToSearch: controller.demo,
              valFrom: 'name',
              label: "Select Assessment",
              onChanged: (value) {},
            )),
          ],
        ),
        MyCustomSD(
          borderColor: Colors.grey,
          listToSearch: controller.demo,
          valFrom: 'name',
          label: "Select Grade",
          onChanged: (value) {},
        ),
        SizedBox(
          height: 15,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: MyButton(
            width: 120,
            title: 'Save',
            textStyle: TextStyle(
              color: Colors.black,
            ),
            color: Colors.green.shade100,
            onPress: () {},
          ),
        ),
      ])
    ]);
  }
}
