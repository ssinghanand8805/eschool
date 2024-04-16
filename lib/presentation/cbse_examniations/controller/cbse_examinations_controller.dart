import 'dart:convert';
import 'dart:developer';

import 'package:learnladder/apiHelper/userData.dart';
import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../../dashboard/dashboard_screen.dart';
import '../model/CbseExaminations.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class CbseExaminationsController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Exam> cbseResultModelObj = <Exam>[].obs;

  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getCBSEEXamResult();
  }

  getCBSEEXamResult()async{
    Map<String,dynamic> body = {
      "student_session_id" : userData.getStudent_session_id };

      var data  = await apiRespository.postApiCallByJson(Constants.getCbseexamresultUrl, body);
  // var data1 = {
  //   "exams": [
  //     {
  //       "id": "218",
  //       "cbse_exam_id": "20",
  //       "student_session_id": "166",
  //       "staff_id": "1",
  //       "roll_no": null,
  //       "remark": "Keep Hard Working",
  //       "total_present_days": "99",
  //       "delete_student_id": "0",
  //       "created_at": "2024-04-04 06:27:20",
  //       "cbse_exam_assessment_id": "1",
  //       "cbse_term_id": "1",
  //       "name": "Monthly Test (APRIL-2024)",
  //       "use_exam_roll_no": "0",
  //       "is_active": "1",
  //       "is_publish": "1",
  //       "cbse_exam_grade_id": "1",
  //       "total_working_days": "150",
  //       "subjects": [
  //         {
  //           "id": "67",
  //           "cbse_exam_id": "20",
  //           "subject_id": "1",
  //           "date": "2024-04-04",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "101",
  //               "cbse_exam_timetable_id": "67",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "102",
  //               "cbse_exam_timetable_id": "67",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "68",
  //           "cbse_exam_id": "20",
  //           "subject_id": "4",
  //           "date": "2024-04-06",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "11F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "103",
  //               "cbse_exam_timetable_id": "68",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "69",
  //           "cbse_exam_id": "20",
  //           "subject_id": "5",
  //           "date": "2024-04-08",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "15G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "104",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "105",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "2",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "106",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "70",
  //           "cbse_exam_id": "20",
  //           "subject_id": "9",
  //           "date": "2024-04-10",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "16G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Computer",
  //           "subject_code": "00220",
  //           "subject_assessments": [
  //             {
  //               "id": "107",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "108",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "2",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "109",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         }
  //       ],
  //       "grades": [
  //         {
  //           "id": "1",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A +",
  //           "minimum_percentage": "90",
  //           "maximum_percentage": "100",
  //           "description": "Excellent",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "2",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A",
  //           "minimum_percentage": "80",
  //           "maximum_percentage": "90",
  //           "description": "Very Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "3",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B+",
  //           "minimum_percentage": "70",
  //           "maximum_percentage": "80",
  //           "description": "Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "4",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B",
  //           "minimum_percentage": "60",
  //           "maximum_percentage": "70",
  //           "description": "Better",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_grade_id": "1",
  //           "name": "C",
  //           "minimum_percentage": "50",
  //           "maximum_percentage": "60",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "16",
  //           "cbse_exam_grade_id": "1",
  //           "name": "D",
  //           "minimum_percentage": "40",
  //           "maximum_percentage": "50",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "17",
  //           "cbse_exam_grade_id": "1",
  //           "name": "E",
  //           "minimum_percentage": "0",
  //           "maximum_percentage": "40",
  //           "description": "",
  //           "created_by": "1",
  //           "created_at": "2023-07-15 05:44:25"
  //         }
  //       ],
  //       "exam_assessments": [
  //         {
  //           "id": "1",
  //           "cbse_exam_assessment_id": "1",
  //           "name": "Theory",
  //           "code": "TH02",
  //           "maximum_marks": "100",
  //           "pass_percentage": "35",
  //           "description": "An examination is a formal test that you take to show your knowledge or ability in a particular subject, or to obtain a qualification. If you have a medical examination, a doctor looks at your body, feels it, or does simple tests in order to check how healthy you are. ",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:42:32"
  //         },
  //         {
  //           "id": "2",
  //           "cbse_exam_assessment_id": "1",
  //           "name": "Practical",
  //           "code": "PC03",
  //           "maximum_marks": "75",
  //           "pass_percentage": "25",
  //           "description": "Practical exams test students' practical skills and techniques usually in laboratory, clinical or field settings",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:43:25"
  //         },
  //         {
  //           "id": "3",
  //           "cbse_exam_assessment_id": "1",
  //           "name": "Assignment",
  //           "code": "AS05",
  //           "maximum_marks": "20",
  //           "pass_percentage": "15",
  //           "description": "An examination is a formal test that you take to show your knowledge or ability in a particular subject, or to obtain a qualification. If you have a medical examination, a doctor looks at your body, feels it, or does simple tests in order to check how healthy you are. ",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:42:32"
  //         }
  //       ],
  //       "exam_subject_assessments": [
  //         {
  //           "id": "67",
  //           "cbse_exam_id": "20",
  //           "subject_id": "1",
  //           "date": "2024-04-04",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "101",
  //               "cbse_exam_timetable_id": "67",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "102",
  //               "cbse_exam_timetable_id": "67",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "68",
  //           "cbse_exam_id": "20",
  //           "subject_id": "4",
  //           "date": "2024-04-06",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "11F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "103",
  //               "cbse_exam_timetable_id": "68",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "69",
  //           "cbse_exam_id": "20",
  //           "subject_id": "5",
  //           "date": "2024-04-08",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "15G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "104",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "105",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "2",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "106",
  //               "cbse_exam_timetable_id": "69",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "70",
  //           "cbse_exam_id": "20",
  //           "subject_id": "9",
  //           "date": "2024-04-10",
  //           "time_from": "11:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "90",
  //           "room_no": "16G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:29:17",
  //           "subject_name": "Computer",
  //           "subject_code": "00220",
  //           "subject_assessments": [
  //             {
  //               "id": "107",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "1",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "108",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "2",
  //               "created_at": "2024-04-04 06:29:17"
  //             },
  //             {
  //               "id": "109",
  //               "cbse_exam_timetable_id": "70",
  //               "cbse_exam_assessment_type_id": "3",
  //               "created_at": "2024-04-04 06:29:17"
  //             }
  //           ]
  //         }
  //       ],
  //       "exam_data": {
  //         "subjects": [
  //           {
  //             "subject_id": "1",
  //             "subject_name": "English",
  //             "subject_code": "210",
  //             "exam_assessments": {
  //               "1": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "1",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2645",
  //                 "marks": "87.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "2": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "2",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "3": {
  //                 "cbse_exam_assessment_type_name": "Assignment",
  //                 "cbse_exam_assessment_type_id": "3",
  //                 "cbse_exam_assessment_type_code": "AS05",
  //                 "maximum_marks": "20",
  //                 "cbse_student_subject_marks_id": "2646",
  //                 "marks": "10.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "4",
  //             "subject_name": "Mathematics",
  //             "subject_code": "110",
  //             "exam_assessments": {
  //               "1": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "1",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2669",
  //                 "marks": "90.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "2": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "2",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "3": {
  //                 "cbse_exam_assessment_type_name": "Assignment",
  //                 "cbse_exam_assessment_type_id": "3",
  //                 "cbse_exam_assessment_type_code": "AS05",
  //                 "maximum_marks": "20",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "5",
  //             "subject_name": "Science",
  //             "subject_code": "111",
  //             "exam_assessments": {
  //               "1": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "1",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2681",
  //                 "marks": "90.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "2": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "2",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2682",
  //                 "marks": "74.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "3": {
  //                 "cbse_exam_assessment_type_name": "Assignment",
  //                 "cbse_exam_assessment_type_id": "3",
  //                 "cbse_exam_assessment_type_code": "AS05",
  //                 "maximum_marks": "20",
  //                 "cbse_student_subject_marks_id": "2683",
  //                 "marks": "15.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "9",
  //             "subject_name": "Computer",
  //             "subject_code": "00220",
  //             "exam_assessments": {
  //               "1": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "1",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2717",
  //                 "marks": "93.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "2": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "2",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2718",
  //                 "marks": "34.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "3": {
  //                 "cbse_exam_assessment_type_name": "Assignment",
  //                 "cbse_exam_assessment_type_id": "3",
  //                 "cbse_exam_assessment_type_code": "AS05",
  //                 "maximum_marks": "20",
  //                 "cbse_student_subject_marks_id": "2719",
  //                 "marks": "14.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           }
  //         ]
  //       },
  //       "exam_total_marks": 610,
  //       "exam_obtain_marks": 507,
  //       "exam_percentage": "83.11",
  //       "exam_grade": "A",
  //       "exam_rank": "2"
  //     },
  //     {
  //       "id": "230",
  //       "cbse_exam_id": "21",
  //       "student_session_id": "166",
  //       "staff_id": "1",
  //       "roll_no": null,
  //       "remark": "Very Good",
  //       "total_present_days": "78",
  //       "delete_student_id": "0",
  //       "created_at": "2024-04-04 06:54:40",
  //       "cbse_exam_assessment_id": "2",
  //       "cbse_term_id": "1",
  //       "name": "Chapter Wise Weekly Test",
  //       "use_exam_roll_no": "0",
  //       "is_active": "1",
  //       "is_publish": "1",
  //       "cbse_exam_grade_id": "1",
  //       "total_working_days": "120",
  //       "subjects": [
  //         {
  //           "id": "71",
  //           "cbse_exam_id": "21",
  //           "subject_id": "1",
  //           "date": "2024-04-10",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "23G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "110",
  //               "cbse_exam_timetable_id": "71",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "72",
  //           "cbse_exam_id": "21",
  //           "subject_id": "3",
  //           "date": "2024-04-12",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "45F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "111",
  //               "cbse_exam_timetable_id": "72",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "73",
  //           "cbse_exam_id": "21",
  //           "subject_id": "4",
  //           "date": "2024-04-15",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "56G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "112",
  //               "cbse_exam_timetable_id": "73",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "74",
  //           "cbse_exam_id": "21",
  //           "subject_id": "6",
  //           "date": "2024-04-18",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Social Studies",
  //           "subject_code": "212",
  //           "subject_assessments": [
  //             {
  //               "id": "113",
  //               "cbse_exam_timetable_id": "74",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             },
  //             {
  //               "id": "114",
  //               "cbse_exam_timetable_id": "74",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         }
  //       ],
  //       "grades": [
  //         {
  //           "id": "1",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A +",
  //           "minimum_percentage": "90",
  //           "maximum_percentage": "100",
  //           "description": "Excellent",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "2",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A",
  //           "minimum_percentage": "80",
  //           "maximum_percentage": "90",
  //           "description": "Very Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "3",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B+",
  //           "minimum_percentage": "70",
  //           "maximum_percentage": "80",
  //           "description": "Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "4",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B",
  //           "minimum_percentage": "60",
  //           "maximum_percentage": "70",
  //           "description": "Better",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_grade_id": "1",
  //           "name": "C",
  //           "minimum_percentage": "50",
  //           "maximum_percentage": "60",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "16",
  //           "cbse_exam_grade_id": "1",
  //           "name": "D",
  //           "minimum_percentage": "40",
  //           "maximum_percentage": "50",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "17",
  //           "cbse_exam_grade_id": "1",
  //           "name": "E",
  //           "minimum_percentage": "0",
  //           "maximum_percentage": "40",
  //           "description": "",
  //           "created_by": "1",
  //           "created_at": "2023-07-15 05:44:25"
  //         }
  //       ],
  //       "exam_assessments": [
  //         {
  //           "id": "4",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Theory",
  //           "code": "TH02",
  //           "maximum_marks": "100",
  //           "pass_percentage": "35",
  //           "description": "An examination is a formal test that you take to show your knowledge or ability in a particular subject, or to obtain a qualification. If you have a medical examination, a doctor looks at your body, feels it, or does simple tests in order to check how healthy you are. ",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Practical",
  //           "code": "PC03",
  //           "maximum_marks": "75",
  //           "pass_percentage": "25",
  //           "description": "Practical exams test students' practical skills and techniques usually in laboratory, clinical or field settings",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         }
  //       ],
  //       "exam_subject_assessments": [
  //         {
  //           "id": "71",
  //           "cbse_exam_id": "21",
  //           "subject_id": "1",
  //           "date": "2024-04-10",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "23G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "110",
  //               "cbse_exam_timetable_id": "71",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "72",
  //           "cbse_exam_id": "21",
  //           "subject_id": "3",
  //           "date": "2024-04-12",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "45F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "111",
  //               "cbse_exam_timetable_id": "72",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "73",
  //           "cbse_exam_id": "21",
  //           "subject_id": "4",
  //           "date": "2024-04-15",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "56G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "112",
  //               "cbse_exam_timetable_id": "73",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "74",
  //           "cbse_exam_id": "21",
  //           "subject_id": "6",
  //           "date": "2024-04-18",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 06:55:55",
  //           "subject_name": "Social Studies",
  //           "subject_code": "212",
  //           "subject_assessments": [
  //             {
  //               "id": "113",
  //               "cbse_exam_timetable_id": "74",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 06:55:55"
  //             },
  //             {
  //               "id": "114",
  //               "cbse_exam_timetable_id": "74",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 06:55:55"
  //             }
  //           ]
  //         }
  //       ],
  //       "exam_data": {
  //         "subjects": [
  //           {
  //             "subject_id": "1",
  //             "subject_name": "English",
  //             "subject_code": "210",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2753",
  //                 "marks": "90.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "3",
  //             "subject_name": "Hindi",
  //             "subject_code": "230",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2766",
  //                 "marks": "98.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "4",
  //             "subject_name": "Mathematics",
  //             "subject_code": "110",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2779",
  //                 "marks": "65.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "6",
  //             "subject_name": "Social Studies",
  //             "subject_code": "212",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2792",
  //                 "marks": "93.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2793",
  //                 "marks": "72.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           }
  //         ]
  //       },
  //       "exam_total_marks": 475,
  //       "exam_obtain_marks": 418,
  //       "exam_percentage": "88.00",
  //       "exam_grade": "A",
  //       "exam_rank": "2"
  //     },
  //     {
  //       "id": "243",
  //       "cbse_exam_id": "22",
  //       "student_session_id": "166",
  //       "staff_id": "1",
  //       "roll_no": null,
  //       "remark": "",
  //       "total_present_days": "56",
  //       "delete_student_id": "0",
  //       "created_at": "2024-04-04 11:18:15",
  //       "cbse_exam_assessment_id": "2",
  //       "cbse_term_id": "5",
  //       "name": "CBSE Practical Test",
  //       "use_exam_roll_no": "0",
  //       "is_active": "1",
  //       "is_publish": "1",
  //       "cbse_exam_grade_id": "1",
  //       "total_working_days": "120",
  //       "subjects": [
  //         {
  //           "id": "75",
  //           "cbse_exam_id": "22",
  //           "subject_id": "1",
  //           "date": "2024-04-16",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "115",
  //               "cbse_exam_timetable_id": "75",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "76",
  //           "cbse_exam_id": "22",
  //           "subject_id": "3",
  //           "date": "2024-04-18",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "11F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "116",
  //               "cbse_exam_timetable_id": "76",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "77",
  //           "cbse_exam_id": "22",
  //           "subject_id": "4",
  //           "date": "2024-04-20",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "14G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "117",
  //               "cbse_exam_timetable_id": "77",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:18"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "78",
  //           "cbse_exam_id": "22",
  //           "subject_id": "5",
  //           "date": "2024-04-22",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "15F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:18",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "118",
  //               "cbse_exam_timetable_id": "78",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:18"
  //             },
  //             {
  //               "id": "119",
  //               "cbse_exam_timetable_id": "78",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:19:18"
  //             }
  //           ]
  //         }
  //       ],
  //       "grades": [
  //         {
  //           "id": "1",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A +",
  //           "minimum_percentage": "90",
  //           "maximum_percentage": "100",
  //           "description": "Excellent",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "2",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A",
  //           "minimum_percentage": "80",
  //           "maximum_percentage": "90",
  //           "description": "Very Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "3",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B+",
  //           "minimum_percentage": "70",
  //           "maximum_percentage": "80",
  //           "description": "Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "4",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B",
  //           "minimum_percentage": "60",
  //           "maximum_percentage": "70",
  //           "description": "Better",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_grade_id": "1",
  //           "name": "C",
  //           "minimum_percentage": "50",
  //           "maximum_percentage": "60",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "16",
  //           "cbse_exam_grade_id": "1",
  //           "name": "D",
  //           "minimum_percentage": "40",
  //           "maximum_percentage": "50",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "17",
  //           "cbse_exam_grade_id": "1",
  //           "name": "E",
  //           "minimum_percentage": "0",
  //           "maximum_percentage": "40",
  //           "description": "",
  //           "created_by": "1",
  //           "created_at": "2023-07-15 05:44:25"
  //         }
  //       ],
  //       "exam_assessments": [
  //         {
  //           "id": "4",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Theory",
  //           "code": "TH02",
  //           "maximum_marks": "100",
  //           "pass_percentage": "35",
  //           "description": "An examination is a formal test that you take to show your knowledge or ability in a particular subject, or to obtain a qualification. If you have a medical examination, a doctor looks at your body, feels it, or does simple tests in order to check how healthy you are. ",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Practical",
  //           "code": "PC03",
  //           "maximum_marks": "75",
  //           "pass_percentage": "25",
  //           "description": "Practical exams test students' practical skills and techniques usually in laboratory, clinical or field settings",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         }
  //       ],
  //       "exam_subject_assessments": [
  //         {
  //           "id": "75",
  //           "cbse_exam_id": "22",
  //           "subject_id": "1",
  //           "date": "2024-04-16",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "12G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "115",
  //               "cbse_exam_timetable_id": "75",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "76",
  //           "cbse_exam_id": "22",
  //           "subject_id": "3",
  //           "date": "2024-04-18",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "11F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "116",
  //               "cbse_exam_timetable_id": "76",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:17"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "77",
  //           "cbse_exam_id": "22",
  //           "subject_id": "4",
  //           "date": "2024-04-20",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "14G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:17",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "117",
  //               "cbse_exam_timetable_id": "77",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:18"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "78",
  //           "cbse_exam_id": "22",
  //           "subject_id": "5",
  //           "date": "2024-04-22",
  //           "time_from": "10:00:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "15F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:19:18",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "118",
  //               "cbse_exam_timetable_id": "78",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:19:18"
  //             },
  //             {
  //               "id": "119",
  //               "cbse_exam_timetable_id": "78",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:19:18"
  //             }
  //           ]
  //         }
  //       ],
  //       "exam_data": {
  //         "subjects": [
  //           {
  //             "subject_id": "1",
  //             "subject_name": "English",
  //             "subject_code": "210",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2818",
  //                 "marks": "90.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "3",
  //             "subject_name": "Hindi",
  //             "subject_code": "230",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2831",
  //                 "marks": "84.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "4",
  //             "subject_name": "Mathematics",
  //             "subject_code": "110",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2844",
  //                 "marks": "65.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "5",
  //             "subject_name": "Science",
  //             "subject_code": "111",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2857",
  //                 "marks": "98.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2858",
  //                 "marks": "67.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           }
  //         ]
  //       },
  //       "exam_total_marks": 475,
  //       "exam_obtain_marks": 404,
  //       "exam_percentage": "85.05",
  //       "exam_grade": "A",
  //       "exam_rank": "2"
  //     },
  //     {
  //       "id": "256",
  //       "cbse_exam_id": "23",
  //       "student_session_id": "166",
  //       "staff_id": "1",
  //       "roll_no": null,
  //       "remark": "",
  //       "total_present_days": null,
  //       "delete_student_id": "0",
  //       "created_at": "2024-04-04 11:25:41",
  //       "cbse_exam_assessment_id": "2",
  //       "cbse_term_id": "5",
  //       "name": "Monthly Exam Test",
  //       "use_exam_roll_no": "0",
  //       "is_active": "1",
  //       "is_publish": "1",
  //       "cbse_exam_grade_id": "1",
  //       "total_working_days": "0",
  //       "subjects": [
  //         {
  //           "id": "79",
  //           "cbse_exam_id": "23",
  //           "subject_id": "1",
  //           "date": "2024-04-22",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "23G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "120",
  //               "cbse_exam_timetable_id": "79",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             },
  //             {
  //               "id": "121",
  //               "cbse_exam_timetable_id": "79",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "80",
  //           "cbse_exam_id": "23",
  //           "subject_id": "3",
  //           "date": "2024-04-24",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "24F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "122",
  //               "cbse_exam_timetable_id": "80",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "81",
  //           "cbse_exam_id": "23",
  //           "subject_id": "4",
  //           "date": "2024-04-26",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "25G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "123",
  //               "cbse_exam_timetable_id": "81",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "82",
  //           "cbse_exam_id": "23",
  //           "subject_id": "5",
  //           "date": "2024-04-30",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "26G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "124",
  //               "cbse_exam_timetable_id": "82",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             },
  //             {
  //               "id": "125",
  //               "cbse_exam_timetable_id": "82",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         }
  //       ],
  //       "grades": [
  //         {
  //           "id": "1",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A +",
  //           "minimum_percentage": "90",
  //           "maximum_percentage": "100",
  //           "description": "Excellent",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "2",
  //           "cbse_exam_grade_id": "1",
  //           "name": "A",
  //           "minimum_percentage": "80",
  //           "maximum_percentage": "90",
  //           "description": "Very Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "3",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B+",
  //           "minimum_percentage": "70",
  //           "maximum_percentage": "80",
  //           "description": "Good",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "4",
  //           "cbse_exam_grade_id": "1",
  //           "name": "B",
  //           "minimum_percentage": "60",
  //           "maximum_percentage": "70",
  //           "description": "Better",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_grade_id": "1",
  //           "name": "C",
  //           "minimum_percentage": "50",
  //           "maximum_percentage": "60",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "16",
  //           "cbse_exam_grade_id": "1",
  //           "name": "D",
  //           "minimum_percentage": "40",
  //           "maximum_percentage": "50",
  //           "description": "Keep Hard Working",
  //           "created_by": "1",
  //           "created_at": "2023-08-08 07:27:26"
  //         },
  //         {
  //           "id": "17",
  //           "cbse_exam_grade_id": "1",
  //           "name": "E",
  //           "minimum_percentage": "0",
  //           "maximum_percentage": "40",
  //           "description": "",
  //           "created_by": "1",
  //           "created_at": "2023-07-15 05:44:25"
  //         }
  //       ],
  //       "exam_assessments": [
  //         {
  //           "id": "4",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Theory",
  //           "code": "TH02",
  //           "maximum_marks": "100",
  //           "pass_percentage": "35",
  //           "description": "An examination is a formal test that you take to show your knowledge or ability in a particular subject, or to obtain a qualification. If you have a medical examination, a doctor looks at your body, feels it, or does simple tests in order to check how healthy you are. ",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         },
  //         {
  //           "id": "5",
  //           "cbse_exam_assessment_id": "2",
  //           "name": "Practical",
  //           "code": "PC03",
  //           "maximum_marks": "75",
  //           "pass_percentage": "25",
  //           "description": "Practical exams test students' practical skills and techniques usually in laboratory, clinical or field settings",
  //           "created_by": "1",
  //           "created_at": "2023-07-11 07:44:57"
  //         }
  //       ],
  //       "exam_subject_assessments": [
  //         {
  //           "id": "79",
  //           "cbse_exam_id": "23",
  //           "subject_id": "1",
  //           "date": "2024-04-22",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "23G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "English",
  //           "subject_code": "210",
  //           "subject_assessments": [
  //             {
  //               "id": "120",
  //               "cbse_exam_timetable_id": "79",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             },
  //             {
  //               "id": "121",
  //               "cbse_exam_timetable_id": "79",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "80",
  //           "cbse_exam_id": "23",
  //           "subject_id": "3",
  //           "date": "2024-04-24",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "24F",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Hindi",
  //           "subject_code": "230",
  //           "subject_assessments": [
  //             {
  //               "id": "122",
  //               "cbse_exam_timetable_id": "80",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "81",
  //           "cbse_exam_id": "23",
  //           "subject_id": "4",
  //           "date": "2024-04-26",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "25G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Mathematics",
  //           "subject_code": "110",
  //           "subject_assessments": [
  //             {
  //               "id": "123",
  //               "cbse_exam_timetable_id": "81",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         },
  //         {
  //           "id": "82",
  //           "cbse_exam_id": "23",
  //           "subject_id": "5",
  //           "date": "2024-04-30",
  //           "time_from": "10:30:00",
  //           "time_to": "00:00:00",
  //           "duration": "120",
  //           "room_no": "26G",
  //           "is_written": "1",
  //           "written_maximum_marks": "0",
  //           "is_practical": "0",
  //           "practical_maximum_mark": null,
  //           "created_by": null,
  //           "created_at": "2024-04-04 11:26:51",
  //           "subject_name": "Science",
  //           "subject_code": "111",
  //           "subject_assessments": [
  //             {
  //               "id": "124",
  //               "cbse_exam_timetable_id": "82",
  //               "cbse_exam_assessment_type_id": "4",
  //               "created_at": "2024-04-04 11:26:51"
  //             },
  //             {
  //               "id": "125",
  //               "cbse_exam_timetable_id": "82",
  //               "cbse_exam_assessment_type_id": "5",
  //               "created_at": "2024-04-04 11:26:51"
  //             }
  //           ]
  //         }
  //       ],
  //       "exam_data": {
  //         "subjects": [
  //           {
  //             "subject_id": "1",
  //             "subject_name": "English",
  //             "subject_code": "210",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2883",
  //                 "marks": "99.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2884",
  //                 "marks": "74.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "3",
  //             "subject_name": "Hindi",
  //             "subject_code": "230",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2911",
  //                 "marks": "98.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "4",
  //             "subject_name": "Mathematics",
  //             "subject_code": "110",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2925",
  //                 "marks": "89.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": null,
  //                 "marks": "xx",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           },
  //           {
  //             "subject_id": "5",
  //             "subject_name": "Science",
  //             "subject_code": "111",
  //             "exam_assessments": {
  //               "4": {
  //                 "cbse_exam_assessment_type_name": "Theory",
  //                 "cbse_exam_assessment_type_id": "4",
  //                 "cbse_exam_assessment_type_code": "TH02",
  //                 "maximum_marks": "100",
  //                 "cbse_student_subject_marks_id": "2939",
  //                 "marks": "99.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               },
  //               "5": {
  //                 "cbse_exam_assessment_type_name": "Practical",
  //                 "cbse_exam_assessment_type_id": "5",
  //                 "cbse_exam_assessment_type_code": "PC03",
  //                 "maximum_marks": "75",
  //                 "cbse_student_subject_marks_id": "2940",
  //                 "marks": "43.00",
  //                 "note": "",
  //                 "is_absent": "0"
  //               }
  //             }
  //           }
  //         ]
  //       },
  //       "exam_total_marks": 550,
  //       "exam_obtain_marks": 502,
  //       "exam_percentage": "91.27",
  //       "exam_grade": "A +",
  //       "exam_rank": "2"
  //     }
  //   ]
  // };
  //   for(var i=0;i<data1!['exams']!.length; i++)
  //   {
  //     // print("getdailyassignmentUrl ${data.body}");
  //     var d = Exam.fromJson(data1!['exams']![i]);
  //     cbseResultModelObj.value.add(d);
  //   }
  for(var i=0;i<data.body!['exams'].length; i++)
    {
      print("getdailyassignmentUrl ${data.body}");
      var d = Exam.fromJson(data.body!['exams'][i]);
      cbseResultModelObj.value.add(d);
    }
 update();


    log("####### ${cbseResultModelObj.value![0].toJson()}");


  }

}
