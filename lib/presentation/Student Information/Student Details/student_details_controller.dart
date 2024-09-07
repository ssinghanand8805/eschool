import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/apiHelper/popular_product_repo.dart';
import 'package:http/http.dart' as http;

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/api.dart';
import '../../../apiHelper/userData.dart';
import '../../login_screen/models/Faculity.dart';

class StudentDetailsController extends GetxController{

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<TextEditingController> searchC = TextEditingController().obs;

  List demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ];
  //
  // List<Map<String, dynamic>> data = [
  //   {
  //     'studentId': 18001,
  //     'class': 'Class 4',
  //     'section': 'A',
  //     'subjectGroup': 'Class 1st Subject Group',
  //     'subject': 'Hindi (230)',
  //     'homeworkDate': DateTime(2024, 4, 5),
  //     'submissionDate': DateTime(2024, 4, 9),
  //     'evaluationDate': DateTime(2024, 4, 9),
  //     'createdBy': 'Joe Black',
  //     'approvedId': 9000,
  //   },
  //   {
  //     'studentId': 18002,
  //     'class': 'Class 4',
  //     'section': 'A',
  //     'subjectGroup': 'Class 1st Subject Group',
  //     'subject': 'Hindi (230)',
  //     'homeworkDate': DateTime(2024, 4, 5),
  //     'submissionDate': DateTime(2024, 4, 9),
  //     'evaluationDate': DateTime(2024, 4, 9),
  //     'createdBy': 'Kirti Singh',
  //     'approvedId': 9000,
  //   },
  //   // Add more data as needed
  // ];

  @override
  void onInit() async {
    super.onInit();
    studentByClassSection();
  }


  studentByClassSection() async {
    var headers = {
      'Auth-Key': 'schoolAdmin@',
      'Client-Service': 'smartschool',
      'Staff-Id': '1',
      'Role': '1',
      'userID': '2',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=vh5f6ka913gacjhl991sjfd2f398v5am'
    };
    var request = http.Request('POST', Uri.parse('http://aatreya.avadhconnect.com/api/webservice//getStudentsByClassSection'));
    request.body = json.encode({
      "class_id": 1,
      "section_id": 1
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      print("GetData: "+data.toString());

    }
    else {
    print(response.reasonPhrase);
    }
  }


  // studentByClassSection() async {
  //
  //   Map<String, dynamic> body = {
  //     "class_id" : 1,
  //     "section_id":1
  //   };
  //
  //   var data = await apiRespository.postApiCallByJson(Constants.studentDetails, body);
  //
  //   print("DATA @@@@ ${data.body}");
  //   Faculity fac = Faculity.fromJson(data.body);
  //   UserData usersData = UserData();
  //   usersData.saveFaculity(fac);
  //
  //   print("APIDATA ${data}");
  //   // Faculity fac = Faculity.fromJson(data.body);
  // }
}