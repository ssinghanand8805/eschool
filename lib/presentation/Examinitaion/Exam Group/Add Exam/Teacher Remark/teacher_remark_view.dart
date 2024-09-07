import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Examinitaion/Exam%20Group/Add%20Exam/Teacher%20Remark/teacher_remark_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../../widgets/custom_button.dart';

class AddExamTeacherRemarkView extends GetView<AddExamTeacherRemarkController>{
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
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Exam",style: theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                        Text("Chapter Wise Weekly Test(April-2024)",style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Exam Group",style: theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold)),
                      Text("Class 4 (Pass / Fail)",style: theme.textTheme.labelMedium),
                    ],
                  )

                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: Get.width*0.2,
                   dataRowHeight: 100,
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Admission No')),
                    DataColumn(label: Text('Roll No.')),
                    DataColumn(label: Text('Class')),
                    DataColumn(label: Text('Section')),
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Remark')),
                  ],
                  rows: controller.data.asMap().entries.map((entry) {
                    int index = entry.key;
                    return DataRow(
                      cells: [
                        DataCell(
                            Text("Mohd Faheem")),
                        DataCell(Text(entry.value['class'],
                            style: theme.textTheme.bodySmall!)),
                        DataCell(
                            Text("12345")),
                        DataCell(
                            Text("It dept")),
                        DataCell(
                            Text("A")),
                        DataCell(
                            Text("Male")),
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
        ),
    );

}