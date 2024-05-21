
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import 'exam_attendance_controller.dart';

class ExamAttendanceView extends GetView<ExamAttendanceController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Attendance',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Column(
          children: [
            Row(

              children: [
                Expanded(child: Text("Total Attendance Days:",style: theme.textTheme.titleSmall?.copyWith(fontSize:14,fontWeight: FontWeight.w600),)),
                Expanded(
                  child: CustomTextField(
                      controller: controller.attendanceC.value,
                      hint: "Total Attendance Days",
                      keyboardType: TextInputType.number,
                      title: ""),
                )
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.1,
                dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Roll No.')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Total Present Days')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text('A')),
                      DataCell(
                        Text('A')
                      ),
                      DataCell(Text('A')),
                      DataCell(Text('A')),
                      DataCell(Text('A')),
                      DataCell(Text('A')),
                      DataCell(
                          CustomTextField(
                            controller: controller.presentDaysC.value,
                            hint: 'Total Present Days',
                            keyboardType: TextInputType.number,
                            title: '',
                          )
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