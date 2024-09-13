import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import 'follow_up_data_modal.dart';

class FollowUpEnquiryController extends GetxController{

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<TextEditingController> followUpDateC = TextEditingController().obs;
  Rx<TextEditingController> nextFollowUpDateC = TextEditingController().obs;
  Rx<TextEditingController> responseC = TextEditingController().obs;
  Rx<TextEditingController> noteC = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    followUpDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    nextFollowUpDateC.value.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    followUp();
  }

  followUp() async {
    Map<String, dynamic> body = {
      "enquiry_id":28,
      "status":"won"
    };
    print("ssss "+body.toString());
    var data = await apiRespository.postApiCallByJson(Constants.followUp, body);

    print("DATA @@@@ ${data.body}");

    if (data.statusCode == 200) {
       //print(await response.stream.bytesToString());
      updateFollowUpList = data.body;
      print("ddd "+getFollowUpList.toString());
    }
    else {

    }
  }

  var followUpList;
  FollowUpDataModal get getFollowUpList => FollowUpDataModal.fromJson(followUpList);
  set updateFollowUpList( val){
    followUpList = val;
    update();
  }

  addFollowUp(context) async {
    Map<String, dynamic> body = {
      "response":responseC.value.text,
      "date":followUpDateC.value.text,
      "follow_up_date":nextFollowUpDateC.value.text,
      "enquiry_id":"28",
      "note":noteC.value.text
    };
    print("ssss "+body.toString());
    var data = await apiRespository.postApiCallByJson(Constants.addFollowUp, body);
    print(data.body);
    if (data.statusCode == 200) {
      alertToast(context, data.body['message']);
      Get.back();
    }else{
      alertToast(context, data.body['message']);
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

