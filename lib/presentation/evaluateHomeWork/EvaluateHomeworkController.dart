import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/popular_product_repo.dart';
import '../common_widgets/controller/CommonApiController.dart';
import 'evaluateHomewrokModel.dart';

class EvaluateHomeworkController extends GetxController {
  CommonApiController commonApiController = Get.put(CommonApiController());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<EvaluateHomework> evaluateHomework = EvaluateHomework().obs;
  Rx<TextEditingController> evaluateDateC = TextEditingController().obs;
  Rx<TextEditingController> titleC = TextEditingController().obs;
  String id = "";
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    id = Get.arguments['id'];
    print("PPPPPPP${id}");
    fetchDataFuture = getEvaluationData();
  }

  Future<void> getEvaluationData() async {
    try {
      var body = {"id": id};
      var data = await apiRespository.postApiCallByJson(
          Constants.homework_evaluation, body);

      evaluateHomework.value = EvaluateHomework.fromJson(data.body);

      print("all homework_list${evaluateHomework.value.toJson()}");
      update();
    } catch (e) {
      print("homework_list${e}");
      update();
    }
  }
}
