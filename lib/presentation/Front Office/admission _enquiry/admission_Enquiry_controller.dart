import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../widgets/alert_dialogue.dart';
import 'enquiry_data_modal.dart';

class AdmissionEnquiryController extends GetxController {

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  GlobalKey<FormState> addEnquiryFormKey = GlobalKey<FormState>();
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
    fromDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    toDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    enquiry();
  }

  enquiry() async {
    Map<String, dynamic> body = {
      "class_id":1,
      "from_date" : fromDateC.value.text,
      "to_date" :   toDateC.value.text
    };
print("ssss "+body.toString());
    var data = await apiRespository.postApiCallByJson(Constants.admissionEnquiry, body);

    print("DATA @@@@ ${data.body}");

    // updateStudentDetailsList = data.body;
    if (data.statusCode == 200) {
          // print(await response.stream.bytesToString());
          updateAdmissionEnquiryController = data.body;
         print("ddd "+getAdmissionEnquiryList.toString());
        }
        else {

        }
  }

  // enquiry() async {
  //   var headers = {
  //     'Auth-Key': 'schoolAdmin@',
  //     'Client-Service': 'smartschool',
  //     'Staff-Id': '1',
  //     'Role': '1',
  //     'userID': '2',
  //     'Content-Type': 'application/json',
  //     'Cookie': 'ci_session=ql6gntkacdr40vh44he4jr4i4uomi8s0'
  //   };
  //   var request = http.Request('POST', Uri.parse('http://aatreya.avadhconnect.com/api/enquiry/getEnquiryList'));
  //   request.body = json.encode({
  //     "from_date": fromDateC.value.text,
  //     "to_date":   toDateC.value.text
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     // print(await response.stream.bytesToString());
  //     var data = jsonDecode(await response.stream.bytesToString());
  //     print("APIRESPONSE "+data.toString());
  //     updateAdmissionEnquiryController = data;
  //    print("ddd "+getAdmissionEnquiryList.toString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  // }

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


  addAdmissionEnquiry(context) async {
    var body=
    {
      "name": nameC.value.text.toString(),
      "contact": phoneC.value.text.toString(),
      "source": sourceId.value,
      "date": dateC.value.text.toString(),
      "follow_up_date": nextFollowUpDateC.value.text.toString(),
      "address": addressC.value.text.toString(),
      "reference_id": referenceId.value,
      "description": descriptionC.value.text.toString(),
      "note": noteC.value.text.toString(),
      "email": emailC.value.text.toString(),
      "assigned": assignedId.value,
      "class_id": classId.value,
      "no_of_child": numberOfChildC.value.text.toString()
    };
    print(body);
    var data = await apiRespository.postApiCallByJson(Constants.addEntry, body);
    print(data.body);
    if(data.body['status']=="success"){
      alertToast(context, data.body["message"]);
      Get.back();
      clearEnquiryForm();
      enquiry();


    }else{
      alertToast(context, data.body["message"]);
    }
  }

  clearEnquiryForm(){
    nameC.value.clear();
    emailC.value.clear();
    phoneC.value.clear();
    addressC.value.clear();
    numberOfChildC.value.clear();
    noteC.value.clear();

  }

  // addAdmissionEnquiry() async {
  //   var headers = {
  //     'Auth-Key': 'schoolAdmin@',
  //     'Client-Service': 'smartschool',
  //     'Staff-Id': '1',
  //     'Role': '1',
  //     'userID': '2',
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('POST', Uri.parse('http://172.16.19.96/school3/api/enquiry/add'));
  //   request.body = json.encode({
  //     "name": nameC.value.text.toString(),
  //     "contact": phoneC.value.text.toString(),
  //     "source": sourceId.value.toString(),
  //     "date": dateC.value.text.toString(),
  //     "follow_up_date": nextFollowUpDateC.value.text.toString(),
  //     "address": addressC.value.text.toString(),
  //     "reference_id": referenceId.value,
  //     "description": descriptionC.value.text.toString(),
  //     "note": noteC.value.text.toString(),
  //     "email": emailC.value.text.toString(),
  //     "assigned": assignedId.value,
  //     "class_id": classId.value,
  //     "no_of_child": "1"
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //   print(response.reasonPhrase);
  //   }
  //
  //
  // }





  List demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ];
}