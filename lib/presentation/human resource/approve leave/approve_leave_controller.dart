import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'approve_leave_modal.dart';

class ApproveLeaveController extends GetxController{

  TextEditingController searchC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx< ApproveLeaveModal> filteredContentTypeList =  ApproveLeaveModal().obs;
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  TextEditingController titleC = TextEditingController();
  final reasonC = TextEditingController();
  final noteC = TextEditingController();
  String status = 'Pending';

  Rx<TextEditingController> applyDate = TextEditingController().obs;
  Rx<TextEditingController> fromDate = TextEditingController().obs;
  Rx<TextEditingController> toDate = TextEditingController().obs;
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  late Future<void> fetchDataFuture;
  List<LeaveRequest> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.data!.leaveRequest!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data!.leaveRequest = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<LeaveRequest> filteredList = originalContentTypeList
          .where((element) => element.name != null &&
          element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.data!.leaveRequest = filteredList;
      });
    }
  }


  Future<void> initializeData() async  {
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getLeaverequest, body);

      filteredContentTypeList.value =  ApproveLeaveModal.fromJson(data.body);
      print(filteredContentTypeList.value.toJson());
      initializeOriginalList();
      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }

  }


  deleteLeave(context, staffId,id) async {
    try {
      var body = {

        "id": id,
        "staff_id": staffId,

      };
      var data = await apiRespository.postApiCallByFormData(
          Constants.removeLeaverequest, body);

      if (data.body['status'] == 1) {
        Get.showSnackbar(
            Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        initializeData();
      } else {
        Get.showSnackbar(
            Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }


}