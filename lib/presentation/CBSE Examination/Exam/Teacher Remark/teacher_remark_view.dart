import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Exam/Teacher%20Remark/teacher_remark_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';

class TeacherRemarkView extends GetView<TeacherRemarkController>{
  @override
  Widget build(BuildContext context) =>
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam List',
          style: theme.textTheme.titleLarge,
        ),
      ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width*0.2,
                 dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Roll No.')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Section')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Marks'),
                      Text('${'(475.00)'}'),
                    ],
                  )),
                  DataColumn(label: Text('Remark')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(
                          Text("12345")),
                      DataCell(
                          Text("It dept")),
                      DataCell(
                          Text("A")),
                      DataCell(
                          Text("Mohd Faheem")),
                      DataCell(
                          Text("Male")),
                      DataCell(
                          Text("450")),
                      DataCell(
                        CustomTextField(
                          controller: controller.remarkC.value,
                          hint: 'Remark',
                          title: '',)
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 80,
                  title: 'Save',
                  textStyle: TextStyle(fontSize: 18, color: Colors.white),
                  color: Colors.green.shade200,
                  onPress: () {
                    //addObservation(context);
                  },
                ),
              ),
            ),

          ],
        ),
    );

}