
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import 'balance_fees_modal.dart';


class BalanceFeeController extends GetxController{

  TextEditingController searchC = TextEditingController();

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<BalanceFee> filteredContentTypeList =  BalanceFee().obs;
  CommonApiController commonApiController = Get.put(CommonApiController());
  late Future<void> fetchDataFuture;
  List<StudentDueFee> originalContentTypeList = [];
  RxString selectedSearchType = 'all'.obs;

  RxBool isDataLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.studentDueFee!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.studentDueFee = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<StudentDueFee> filteredList = originalContentTypeList
          .where((element) => element.name != null &&
          element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.studentDueFee = filteredList;
      });
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      isDataLoading.value = true;
      var body = {"search_type":selectedSearchType.value,"class_id":commonApiController.selectedClassId.value,"section_id": commonApiController.selectedClassId.value};
      var data = await apiRespository.postApiCallByJson(Constants.balanceFeeListUrl, body);

     filteredContentTypeList.value =  BalanceFee.fromJson(data.body);
      print(filteredContentTypeList.value.toJson());
     initializeOriginalList();
      isDataLoading.value = false;
      update();
    }
    catch(e)
    {
      isDataLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));

      update();
    }

    // Initialize fetchDataFuture here
  }


}