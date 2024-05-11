import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/Exam%20Subject/exam_subject_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../../theme/theme_helper.dart';
import '../../../../widgets/datePickerTextField.dart';
import '../../../../widgets/timePickerTextField.dart';

class ExamSubjectView extends GetView<ExamSubjectController>{
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
                    Text("Exam",style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
                    Text("CBSE Monthly Week Test",style: theme.textTheme.titleMedium,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Class (Section)",style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
                    Text("Class (Section)",style: theme.textTheme.titleMedium,),
                  ],
                ),
              ],
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
                        valFrom: 'name',
                        borderColor: Colors.grey,
                        onChanged: (value) {  },)
                      ),
                      DataCell(
                        Obx(() {
                          return Column(
                            children: [
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
                                  Text("Theory (TH02)",style: theme.textTheme.titleSmall,)
                                ],
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                      checkColor: Colors.white,
                                      //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                                      value: controller.isPracticalChecked.value,
                                      onChanged: (value) {
                                        controller.isPracticalChecked.value = value!;
                                        print(value);
                                      },
                                  ),
                                  Text("Practical (PC03)",style: theme.textTheme.titleSmall,)

                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                      DataCell(
                          DatePickerTextField(
                            controller: controller.dateC.value,
                            title: '',)
                      ),
                      DataCell(
                          TimePickerTextField(
                            controller: controller.startTimeC.value,
                            title: '',)
                      ),
                      DataCell(
                        CustomTextField(
                          controller: controller.durationC.value,
                          hint: 'Duration (minute)',
                          keyboardType: TextInputType.number,
                          title: '',)
                      ),
                      DataCell(CustomTextField(
                        controller: controller.roomNoC.value,
                        hint: 'Room No.',
                        keyboardType: TextInputType.number,
                        title: '',)),
                      DataCell(Row(
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
                      ),),

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