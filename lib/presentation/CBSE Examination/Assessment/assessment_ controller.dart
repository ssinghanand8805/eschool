import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widgets/customTextField.dart';

class AssessmentController extends GetxController{



  Rx<TextEditingController> assessmentC = TextEditingController().obs;
  Rx<TextEditingController> assessmentDescriptionC = TextEditingController().obs;
  Rx<TextEditingController> assessmentTypeC = TextEditingController().obs;
  Rx<TextEditingController> maxMarksC = TextEditingController().obs;
  Rx<TextEditingController> passPercentageC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
  Rx<TextEditingController> codeC = TextEditingController().obs;



  Rx<TextEditingController> searchC = TextEditingController().obs;

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
                      hint: "Assessment Type",
                      title: "",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomTextField(
                      controller: controllers[i],
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
                      controller: controllers[i],
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
                      controller: controllers[i],
                      hint: "Pass Percentage",
                      title: "",
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controllers[i],
                      hint: "Description",
                      title: "",
                      keyboardType: TextInputType.number,
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


}