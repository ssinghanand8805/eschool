import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
    admissionEnquiry();
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

  admissionEnquiry() async {
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
      "from_date": "09/10/2024",
      "to_date": "09/10/2024"
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






  List demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ];
}
