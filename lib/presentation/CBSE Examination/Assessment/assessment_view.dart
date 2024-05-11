import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assessment/assessment_%20controller.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/button.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class AssessmentView extends GetView<AssessmentController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Assessment List',
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
                addAssessment(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
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
                  DataColumn(label: Text('Assessment ')),
                  DataColumn(label: Text('Assessment Description')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Maximum Marks')),
                  DataColumn(label: Text('Passing Percentage')),
                  DataColumn(label: Text('Description')),
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
      ),
    );
  }

  addAssessment(context){
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
                    "Add Assessment",
                    style: theme.textTheme.bodyMedium,
                  ),
                  CustomTextField(
                    controller: controller.assessmentC.value,
                    hint: "Assessment",
                    title: "",
                  ),
                  CustomTextField(
                    controller: controller.assessmentDescriptionC.value,
                    hint: "Assessment Description",
                    title: "",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: controller.assessmentTypeC.value,
                          hint: "Assessment Type",
                          title: "",
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.codeC.value,
                          hint: "Code",
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
                          controller: controller.maxMarksC.value,
                          hint: "Minimum Marks",
                          title: "",
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: controller.passPercentageC.value,
                          hint: "Pass Percentage",
                          title: "",
                        ),
                      ),
                    ],
                  ),

                  CustomTextField(
                    controller: controller.descriptionC.value,
                    hint: "Description",
                    title: "",
                    keyboardType: TextInputType.number,
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