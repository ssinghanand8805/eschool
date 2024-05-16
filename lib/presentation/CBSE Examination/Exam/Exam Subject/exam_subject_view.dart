import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/Exam%20Subject/exam_subject_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../../theme/theme_helper.dart';
import '../../../../widgets/datePickerTextField.dart';
import '../../../../widgets/timePickerTextField.dart';

class ExamSubjectView extends GetView<ExamSubjectController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Add Exam Subject',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Exam",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "CBSE Monthly Week Test",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Class (Section)",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Class (Section): A, B, C, D",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topRight,
              child: MyButton(
                width: 140,
                  title: "Add exam subject",
                prefixIcon: Icon(Icons.add),
                color: Colors.green.shade100,
                onPress: (){

                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.1,
                dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Assessment')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Start Time')),
                  DataColumn(label: Text('Duration (minute)')),
                  DataColumn(label: Text('Room No')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(MyCustomSD(
                        listToSearch: controller.demo,
                        label: 'Select Subject',
                        valFrom: 'name',
                        borderColor: Colors.grey,
                        onChanged: (value) {},
                      )),
                      DataCell(
                        SizedBox(
                          width: Get.width/1.5,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Obx(() =>
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                                        value: controller.isTheoryChecked.value,
                                        onChanged: (value) {
                                          controller.isTheoryChecked.value = value!;
                                          print(value);
                                        },
                                      ),
                                      Text(
                                        "Theory (TH02) Theory (TH02)",
                                        style: theme.textTheme.titleSmall,
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                      ),
                      DataCell(DatePickerTextField(
                        controller: controller.dateC.value,
                        title: '',
                      )),
                      DataCell(TimePickerTextField(
                        controller: controller.startTimeC.value,
                        title: '',
                      )),
                      DataCell(CustomTextField(
                        controller: controller.durationC.value,
                        hint: 'Duration (minute)',
                        keyboardType: TextInputType.number,
                        title: '',
                      )),
                      DataCell(CustomTextField(
                        controller: controller.roomNoC.value,
                        hint: 'Room No.',
                        keyboardType: TextInputType.number,
                        title: '',
                      )),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete, size: 15),
                          onPressed: () {
                            print("Delete leave");
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: MyButton(
                width: 80,
                title: "Save",
                color: Colors.green.shade100,
                onPress: (){

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
