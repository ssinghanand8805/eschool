import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import 'exam_controller.dart';

class AddExamView extends GetView<AddExamController>{
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

              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exam Group",style: theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                    Text("Class 4 (Pass / Fail)",style: theme.textTheme.labelMedium),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exam Type",style: theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                    Text("General Purpose (Pass/Fail)",style: theme.textTheme.labelMedium),
                  ],
                )

              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Session')),
                  DataColumn(label: Text('Subjects Included')),
                  DataColumn(label: Text('Publish Exam')),
                  DataColumn(label: Text('Publish Result')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Icon(Icons.check_box_outlined)),
                      DataCell(Icon(Icons.check_box_outlined)),
                      DataCell(Text("A")),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              tooltip: "Assign/View Student",
                              icon: Icon(Icons.tag, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_assign_view_studentRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Subjects",
                              icon: Icon(Icons.book, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_exam_subjectRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Marks",
                              icon: Icon(Icons.branding_watermark_sharp,
                                  size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_markRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Teacher Remark",
                              icon: Icon(Icons.chat_bubble_outline, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_teacher_remarksRoute);
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

}