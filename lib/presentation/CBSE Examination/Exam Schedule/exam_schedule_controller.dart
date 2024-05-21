import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ExamScheduleController extends GetxController{

  Rx<TextEditingController> searchC = TextEditingController().obs;

  final Map<String, dynamic> jsonData = {
    "tests": [
      {
        "test_name": "CBSE Monthly Week Test",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "05/06/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 342
          },
          {
            "subject": "English (210)",
            "date": "05/08/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 234
          },
          {
            "subject": "Hindi (230)",
            "date": "05/10/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 231
          },
          {
            "subject": "Science (111)",
            "date": "05/14/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 232
          }
        ]
      },
      {
        "test_name": "Online Assessment Test",
        "subjects": [
          {
            "subject": "English (210)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 34
          },
          {
            "subject": "Mathematics (110)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 23
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/25/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 12
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 45
          }
        ]
      },
      {
        "test_name": "Monthly Exam Practice",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          },
          {
            "subject": "English (210)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 14
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/26/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 15
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          }
        ]
      },
      {
        "test_name": "Cbse Online Exam",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "05/06/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 342
          },
          {
            "subject": "English (210)",
            "date": "05/08/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 234
          },
          {
            "subject": "Hindi (230)",
            "date": "05/10/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 231
          },
          {
            "subject": "Science (111)",
            "date": "05/14/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 232
          }
        ]
      },
      {
        "test_name": "Cbse Practical Test",
        "subjects": [
          {
            "subject": "English (210)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 34
          },
          {
            "subject": "Mathematics (110)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 23
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/25/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 12
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 45
          }
        ]
      },
      {
        "test_name": "Monthly Exam Test",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          },
          {
            "subject": "English (210)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 14
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/26/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 15
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          }
        ]
      },
      {
        "test_name": "CBSE Practical Test",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "05/06/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 342
          },
          {
            "subject": "English (210)",
            "date": "05/08/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 234
          },
          {
            "subject": "Hindi (230)",
            "date": "05/10/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 231
          },
          {
            "subject": "Science (111)",
            "date": "05/14/2024",
            "start_time": "11:30:00",
            "duration_minutes": 120,
            "room_no": 232
          }
        ]
      },
      {
        "test_name": "Chapter Wise Weekly Test",
        "subjects": [
          {
            "subject": "English (210)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 34
          },
          {
            "subject": "Mathematics (110)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 23
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/25/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 12
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 90,
            "room_no": 45
          }
        ]
      },
      {
        "test_name": "Monthly Test (APRIL-2024)",
        "subjects": [
          {
            "subject": "Mathematics (110)",
            "date": "04/22/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          },
          {
            "subject": "English (210)",
            "date": "04/24/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 14
          },
          {
            "subject": "Social Studies (212)",
            "date": "04/26/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 15
          },
          {
            "subject": "Science (111)",
            "date": "04/27/2024",
            "start_time": "10:30:00",
            "duration_minutes": 120,
            "room_no": 12
          }
        ]
      },

    ]
  };




}