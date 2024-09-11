import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../apiHelper/popular_product_repo.dart';
import 'enquiry_data_modal.dart';

class AdmissionEnquiryController extends GetxController {

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<TextEditingController> fromDateC = TextEditingController().obs;
  Rx<TextEditingController> toDateC = TextEditingController().obs;

  Rx<TextEditingController> nameC = TextEditingController().obs;
  Rx<TextEditingController> phoneC = TextEditingController().obs;
  Rx<TextEditingController> emailC = TextEditingController().obs;
  Rx<TextEditingController> addressC = TextEditingController().obs;
  Rx<TextEditingController> descriptionC = TextEditingController().obs;
  Rx<TextEditingController> noteC = TextEditingController().obs;
  Rx<TextEditingController> dateC = TextEditingController().obs;
  Rx<TextEditingController> nextFollowUpDateC = TextEditingController().obs;
  Rx<TextEditingController> numberOfChildC = TextEditingController().obs;

  @override
  void onInit() async {
    super.onInit();
    enquiry();
    fromDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    toDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  // admissionEnquiry() async {
  //   Map<String, dynamic> body = {
  //     "from_date" :"09/10/2024",
  //     "to_date" :"09/10/2024"
  //   };
  //
  //   var data = await apiRespository.postApiCallByJson(Constants.admissionEnquiry, body);
  //
  //   print("DATA @@@@ ${data.body}");
  //
  //   // updateStudentDetailsList = data.body;
  // }

  enquiry() async {
    var headers = {
      'Auth-Key': 'schoolAdmin@',
      'Client-Service': 'smartschool',
      'Staff-Id': '1',
      'Role': '1',
      'userID': '2',
      'Content-Type': 'application/json',
      'Cookie': 'ci_session=ql6gntkacdr40vh44he4jr4i4uomi8s0'
    };
    var request = http.Request('POST', Uri.parse('http://aatreya.avadhconnect.com/api/enquiry/getEnquiryList'));
    request.body = json.encode({
      "from_date": "09/10/2024",  //fromDateC.value.text,
      "to_date":   "09/10/2024"   //toDateC.value.text
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var data = jsonDecode(await response.stream.bytesToString());
      print("APIRESPONSE "+data.toString());
      updateAdmissionEnquiryController = data;
     print("ddd "+getAdmissionEnquiryList.toString());
    }
    else {
    print(response.reasonPhrase);
    }
  }

  var admissionEnquiryList ;
 AdmissionEnquiryDataModal get getAdmissionEnquiryList => AdmissionEnquiryDataModal.fromJson(admissionEnquiryList);
  set updateAdmissionEnquiryController( val){
    admissionEnquiryList = val;
    update();
  }

  RxString classId = "".obs;
  RxString sourceId = "".obs;
  RxString assignedId = "".obs;
  RxString referenceId = "".obs;



  addAdmissionEnquiry() async {
    var headers = {
      'Auth-Key': 'schoolAdmin@',
      'Client-Service': 'smartschool',
      'Staff-Id': '1',
      'Role': '1',
      'userID': '2',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://172.16.19.96/school3/api/enquiry/add'));
    request.body = json.encode({
      "name": nameC.value.text.toString(),
      "contact": phoneC.value.text.toString(),
      "source": sourceId.value.toString(),
      "date": dateC.value.text.toString(),
      "follow_up_date": nextFollowUpDateC.value.text.toString(),
      "address": addressC.value.text.toString(),
      "reference_id": referenceId,
      "description": descriptionC.value.text.toString(),
      "note": noteC.value.text.toString(),
      "email": emailC.value.text.toString(),
      "assigned": assignedId,
      "class_id": classId,
      "no_of_child": "1"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
    print(response.reasonPhrase);
    }


  }





  List demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ];
}
