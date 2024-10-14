import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import 'follow_up_data_modal.dart';
import 'follow_up_list.dart';

class FollowUpEnquiryController extends GetxController{

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());

  Rx<TextEditingController> followUpDateC = TextEditingController().obs;
  Rx<TextEditingController> nextFollowUpDateC = TextEditingController().obs;
  Rx<TextEditingController> responseC = TextEditingController().obs;
  Rx<TextEditingController> noteC = TextEditingController().obs;
  var enquiryId;
  late Future<void> fetchDataFuture;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    enquiryId = Get.arguments['enquiry_id'];
    fetchDataFuture = initializeData();


  }
  Future<void> initializeData() async  {
    // followUpDateC.value.text =
    //     DateFormat('dd/MM/yyyy').format(DateTime.now());
    // nextFollowUpDateC.value.text =
    //     DateFormat('dd/MM/yyyy').format(DateTime.now());
    await followUp(); // Initialize fetchDataFuture here
  }
  followUp() async {
    Map<String, dynamic> body = {
      "enquiry_id":enquiryId
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
  FollowUpDetails get getFollowUpList => FollowUpDetails.fromJson(followUpList);
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

