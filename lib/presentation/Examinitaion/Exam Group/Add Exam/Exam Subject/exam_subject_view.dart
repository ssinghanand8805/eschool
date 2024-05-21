
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../../widgets/datePickerTextField.dart';
import '../../../../../widgets/timePickerTextField.dart';
import 'exam_subject_controller.dart';

class AddExamExamSubjectView extends GetView<AddExamExamSubjectController> {
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
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Start Time')),
                  DataColumn(label: Text('Duration (minute)')),
                  DataColumn(label: Text('Credit Hours')),
                  DataColumn(label: Text('Room No')),
                  DataColumn(label: Text('Marks (Max..)')),
                  DataColumn(label: Text('Marks (Min..)')),
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
                        controller: controller.creditHoursC.value,
                        hint: 'Credit Hours',
                        keyboardType: TextInputType.number,
                        title: '',
                      )),
                      DataCell(CustomTextField(
                        controller: controller.roomNoC.value,
                        hint: 'Room No.',
                        keyboardType: TextInputType.number,
                        title: '',
                      )),
                      DataCell(CustomTextField(
                        controller: controller.maxMarksC.value,
                        hint: 'Marks (Max..)',
                        keyboardType: TextInputType.number,
                        title: '',
                      )),
                      DataCell(CustomTextField(
                        controller: controller.minMarksC.value,
                        hint: 'Marks (Min..)',
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
