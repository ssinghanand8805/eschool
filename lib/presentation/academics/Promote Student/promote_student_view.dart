import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/promote_student_controller.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';

class PromoteStudentView extends GetView<PromoteStudentController> {
  PromoteStudentView({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Assign Class Teacher',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                      listToSearch: controller.demo,
                      valFrom: 'name',
                      label: 'Select class',
                      borderColor: Colors.grey,
                      onChanged: (val) {}),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      label: 'Select section',
                      valFrom: 'name',
                      onChanged: (val) {}),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Promote Students In Next Session",
              style: theme.textTheme.titleMedium,
            ),
            MyCustomSD(
                borderColor: Colors.grey,
                listToSearch: controller.demo,
                label: 'Select Promote In Session',
                valFrom: 'name',
                onChanged: (val) {}),
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      label: 'Select class',
                      valFrom: 'name',
                      onChanged: (val) {}),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      label: 'Select section',
                      valFrom: 'name',
                      onChanged: (val) {}),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                width: 80,
                color: Colors.green.shade400,
                title: 'Search',
                onPress: () {
                  print("object");
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Student List",
              style: theme.textTheme.labelLarge,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.07,
                columns: const [
                  DataColumn(label: Icon(Icons.check_box_outline_blank)),
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Date of Birth')),
                  DataColumn(label: Text('Current Result')),
                  DataColumn(label: Text('Next Session Status')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Obx(() {
                        return Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value!;
                              print(value);
                            });
                      })),
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Center(
                        child: Text(entry.value['section'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Obx(() {
                        return Row(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.isChecked.value = true;
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: controller.isChecked == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.circle,color: Colors.red,size: 13),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Pass')
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.isChecked.value = true;
                                  },
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: controller.isChecked == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Pass')
                              ],
                            ),
                          ],
                        );
                      })),
                      DataCell(Obx(() {
                        return Row(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.isChecked.value = true;
                                  },
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: controller.isChecked == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Continue')
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    controller.isChecked.value = true;
                                  },
                                  child: Container(
                                    height: 12,
                                    width: 12,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        color: controller.isChecked == true
                                            ? Colors.black
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Leave')
                              ],
                            ),
                          ],
                        );
                      })),
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
