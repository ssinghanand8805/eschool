import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/customTextField.dart';

class ExamGradeController extends GetxController{

  Rx<TextEditingController> gradeTitleC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
  Rx<TextEditingController> gradeC = TextEditingController().obs;
  Rx<TextEditingController> maxPercentageC = TextEditingController().obs;
  Rx<TextEditingController> minPercentageC = TextEditingController().obs;
  Rx<TextEditingController> remarkC = TextEditingController().obs;



  Rx<TextEditingController> searchC = TextEditingController().obs;


  List<Map<String, dynamic>> data = [
    {
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentId': 18002,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Kirti Singh',
      'approvedId': 9000,
    },
    // Add more data as needed
  ];

  List<TextEditingController> controllers = [];

   buildCustomTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < controllers.length; i++) {
      textFields.add(
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controllers[i],
                    hint: 'Grade',
                    title: '',
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controllers[i],
                    hint: 'Maximum Percentage',
                    title: '',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controllers[i],
                    hint: 'Minimum Percentage',
                    title: '',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controllers[i],
                    hint: 'Remark',
                    title: '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 8),
                  child: IconButton(
                    icon: Icon(Icons.delete_forever, size: 18),
                    onPressed: () {
                      controllers.removeAt(i);
                    },
                  ),
                ),
              ],
            ),
          ],
        )
      );
    }
    return Column(children: textFields);
  }
}