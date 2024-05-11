import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_button.dart';
import 'exam_grade_controller.dart';

class ExamGradeView extends GetView<ExamGradeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Grade List',
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
                addExamGrade(context);
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exam Grade List",
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
                      DataColumn(label: Text('Grade Title')),
                      DataColumn(label: Text('Description')),
                      DataColumn(label: Text('Grade')),
                      DataColumn(label: Text('Maximum Percentage')),
                      DataColumn(label: Text('Minimum Percentage')),
                      DataColumn(label: Text('Remark')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: controller.data.asMap().entries.map((entry) {
                      int index = entry.key;
                      return DataRow(
                        cells: [
                          DataCell(Text(entry.value['class'],
                              style: theme.textTheme.bodySmall!)),
                          DataCell(Text(
                            "a degree or step in a scale, as of rank, advancement, quality a degree or step in a scale, as of rank, advancement, quality, value, or intensity.",
                            maxLines: null,
                            overflow: TextOverflow.ellipsis,
                          )),
                          DataCell(Text("A")),
                          DataCell(Text("A")),
                          DataCell(Text("A")),
                          DataCell(Text("A")),
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
              ],
            ),
          );
        }
      ),
    );
  }

  addExamGrade(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        GetBuilder(
          init: controller,
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Grade",
                  style: theme.textTheme.bodyMedium,
                ),
                CustomTextField(
                  controller: controller.gradeTitleC.value,
                  hint: "Grade Title",
                  title: "",
                ),
                CustomTextField(
                  controller: controller.descriptionC.value,
                  hint: "Description",
                  title: "",
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.gradeC.value,
                        hint: "Grade",
                        title: "",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.maxPercentageC.value,
                        hint: "Maximum Percentage",
                        title: "",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: controller.minPercentageC.value,
                        hint: "Minimum Percentage",
                        title: "",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.remarkC.value,
                        hint: "Remark",
                        title: "",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Button(
                  icon: Icons.add,
                  onTap: () {
                    controller.controllers.add(TextEditingController());
                  },
                  text: 'Add More',
                ),
                controller.buildCustomTextFields(),
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
            );
          }
        )
      ],
    );
  }
}
