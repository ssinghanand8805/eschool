import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamController extends GetxController{

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

  Rx<TextEditingController> examNameC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;

  List demo = [
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
  ];

  RxBool isChecked = false.obs;
}