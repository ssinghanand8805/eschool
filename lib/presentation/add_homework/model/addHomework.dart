import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../controller/add_homework_controller.dart';

class AddHomeWorkModal{

  AddHomeWorkController controller = Get.put(AddHomeWorkController());
  CommonApiController commonApiController = Get.put(CommonApiController());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());


  addHomeWork() async {

    Map<String, dynamic> body = {
      "modal_class_id":commonApiController.selectedClassId.value,
      "modal_section_id":commonApiController.selectedSectionId.value,
      "homework_date":"09/06/2024",
      "submit_date":"09/06/2024",
      "modal_subject_id":"1",
      "description":"demo from api"
    };

    var data = await apiRespository.postApiCallByJson(Constants.searchStudentInfo, body);

    print("DATA @@@@ ${data.body}");


  }

  subjectGroup() async {
    Map<String, dynamic> body = {
      "class_id":commonApiController.selectedClassId.value,
      "section_id":commonApiController.selectedSectionId.value,
    };

    var data = await apiRespository.postApiCallByJson(Constants.subjectGroup, body);
    print("DATA @@@@ ${data.body}");
    controller.updateSubjectGroup = data.body;
  }

  subject() async {
    var headers = {
      'Auth-Key': 'schoolAdmin@',
      'Client-Service': 'smartschool',
      'Staff-Id': '1',
      'Role': '1',
      'userID': '2',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=eaacoc5i2vqe7bisibtqndud6panmgtc'
    };
    var request = http.Request('POST', Uri.parse('http://172.16.19.96/school3/api/webservice/getGroupsubjects'));
    request.body = json.encode({
      "subject_group_id": 1
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = jsonDecode(await response.stream.bytesToString());
      print("ffff"+data.toString());
      controller.updateSubjectList = data;
    }
    else {
    print(response.reasonPhrase);
    }

  }

  // subject() async {
  //   Map<String, dynamic> body = {
  //     "subject_group_id": controller.getListGroupId.value
  //   };
  //
  //   var data = await apiRespository.postApiCallByJson(Constants.subject, body);
  //   print("DATA @@@@ ${data.body}");
  //
  //   controller.updateSubjectList = data.body;
  //
  // }



}












class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class Attendance {
  String? attendenceType;
  List<Data>? data;

  Attendance({this.attendenceType, this.data});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendenceType = json['attendence_type'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendence_type'] = this.attendenceType;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? date;
  String? type;

  Data({this.date, this.type});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['type'] = this.type;
    return data;
  }
}