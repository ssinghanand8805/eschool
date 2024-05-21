import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';
import 'exam_group_controller.dart';

class ExamGroupView extends GetView<ExamGroupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Group List',
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
                addExamGroup(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.searchC.value,
              hint: "Search...",
              title: "",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('No Of Exams')),
                  DataColumn(label: Text('Exam Type')),
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
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_groupRoute);
                              },
                            ),
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
          ],
        ),
      ),
    );
  }

  addExamGroup(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Marks Grade",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.nameC.value,
              hint: "Name",
              title: "",
            ),
            MyCustomSD(
                listToSearch: controller.demo,
                borderColor: Colors.grey,
                valFrom: "name",
                label: "Select Exam Type",
                onChanged: (val) {}),
            CustomTextField(
              controller: controller.descriptionC.value,
              hint: "Description",
              maxLine: 3,
              title: "",
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
          ],
        )
      ],
    );
  }
}
