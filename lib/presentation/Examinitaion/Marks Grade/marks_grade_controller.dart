import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarksGradeController extends GetxController {

  Rx<TextEditingController> searchC = TextEditingController().obs;
  Rx<TextEditingController> gradeNameC = TextEditingController().obs;
  Rx<TextEditingController> percentUpToC  = TextEditingController().obs;
  Rx<TextEditingController> percentFromC  = TextEditingController().obs;
  Rx<TextEditingController> gradePointC  = TextEditingController().obs;
  Rx<TextEditingController> descriptionC  = TextEditingController().obs;

  List demo = [
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
    {
      "name":"Faheem"
    },
  ];

  final Map<String, dynamic> gradingSystemsJson = {
    "grading_systems": [
      {
        "exam_type": "General Purpose (Pass/Fail)",
        "grades": [
          {
            "grade_name": "B-",
            "percent_range": "0.00 To 40.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B",
            "percent_range": "40.00 To 50.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B+",
            "percent_range": "50.00 To 60.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B++",
            "percent_range": "60.00 To 70.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A",
            "percent_range": "70.00 To 80.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A+",
            "percent_range": "80.00 To 90.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A++",
            "percent_range": "90.00 To 100.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          }
        ]
      },
      {
        "exam_type": "School Based Grading System",
        "grades": [
          {
            "grade_name": "B-",
            "percent_range": "0.00 To 40.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B",
            "percent_range": "40.00 To 50.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B+",
            "percent_range": "50.00 To 60.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B++",
            "percent_range": "60.00 To 70.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A",
            "percent_range": "70.00 To 80.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A+",
            "percent_range": "80.00 To 90.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A++",
            "percent_range": "90.00 To 100.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          }
        ]
      },
      {
        "exam_type": "College Based Grading System",
        "grades": [
          {
            "grade_name": "B-",
            "percent_range": "0.00 To 40.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B",
            "percent_range": "40.00 To 50.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B+",
            "percent_range": "50.00 To 60.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B++",
            "percent_range": "60.00 To 70.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A",
            "percent_range": "70.00 To 80.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A+",
            "percent_range": "80.00 To 90.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A++",
            "percent_range": "90.00 To 100.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          }
        ]
      },
      {
        "exam_type": "GPA Grading System",
        "grades": [
          {
            "grade_name": "A+",
            "percent_range": "90.00 To 100.00",
            "grade_point": 4.5,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A",
            "percent_range": "80.00 To 90.00",
            "grade_point": 4.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B+",
            "percent_range": "70.00 To 80.00",
            "grade_point": 3.5,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B",
            "percent_range": "60.00 To 70.00",
            "grade_point": 3.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "C+",
            "percent_range": "50.00 To 60.00",
            "grade_point": 2.5,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "C",
            "percent_range": "40.00 To 50.00",
            "grade_point": 2.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "D",
            "percent_range": "0.00 To 40.00",
            "grade_point": 1.0,
            "actions": ["edit", "delete"]
          }
        ]
      },
      {
        "exam_type": "Average Passing",
        "grades": [
          {
            "grade_name": "A+",
            "percent_range": "90.00 To 100.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "A",
            "percent_range": "80.00 To 90.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B+",
            "percent_range": "70.00 To 80.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "B",
            "percent_range": "60.00 To 70.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "C+",
            "percent_range": "50.00 To 60.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "C",
            "percent_range": "40.00 To 50.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          },
          {
            "grade_name": "D",
            "percent_range": "0.00 To 40.00",
            "grade_point": 0.0,
            "actions": ["edit", "delete"]
          }
        ]
      }
    ]
  };
}
List<GradingSystem> parseGradingSystems(Map<String, dynamic> json) {
  var gradingSystemsJson = json['grading_systems'] as List;
  return gradingSystemsJson
      .map((gradingSystemJson) => GradingSystem.fromJson(gradingSystemJson))
      .toList();
}

class GradingSystem {
  final String examType;
  final List<Grade> grades;

  GradingSystem({
    required this.examType,
    required this.grades,
  });

  factory GradingSystem.fromJson(Map<String, dynamic> json) {
    var gradesJson = json['grades'] as List;
    List<Grade> gradesList =
    gradesJson.map((gradeJson) => Grade.fromJson(gradeJson)).toList();

    return GradingSystem(
      examType: json['exam_type'],
      grades: gradesList,
    );
  }
}

class Grade {
  final String gradeName;
  final String percentRange;
  final double gradePoint;
  final List<String> actions;

  Grade({
    required this.gradeName,
    required this.percentRange,
    required this.gradePoint,
    required this.actions,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      gradeName: json['grade_name'],
      percentRange: json['percent_range'],
      gradePoint: json['grade_point'].toDouble(),
      actions: List<String>.from(json['actions']),
    );
  }
}