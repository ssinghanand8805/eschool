import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Video%20Tutorial/video_tutorial_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonApiController.dart';

class VideoTutorialController extends GetxController{


  TextEditingController SearchByTitleC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  CommonApiController commonApiController = Get.put(CommonApiController());
  RxString selectedClassName = "".obs;
  RxString selectedSectionName = ''.obs;
  Rx<VideoTutorial> filteredContentTypeList = VideoTutorial().obs;
  late Future<void> fetchDataFuture;
  List<VideoTutorialList> originalContentTypeList = [];
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }
  void initializeOriginalList() {
    originalContentTypeList = filteredContentTypeList.value!.data!.videoTutorialList!;//List.from(); // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data!.videoTutorialList = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<VideoTutorialList> filteredList = originalContentTypeList
          .where((element) => element.title != null &&
          element.title!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.data!.videoTutorialList = filteredList;
      });
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getVideoTutorialListUrl, body);

      filteredContentTypeList.value = VideoTutorial.fromJson(data.body);
      print(filteredContentTypeList.value.toJson());
      initializeOriginalList();
      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }

    // Initialize fetchDataFuture here
  }
  Future<void> searchApiData() async  {
    //isLoading.value = true;
    try
    {
      Map<String, dynamic> body = {
        "class_id" : commonApiController.selectedClassId.value ?? "",
        "class_section_id":commonApiController.selectedSectionId.value ?? "",
        "keyword": SearchByTitleC.value.text.trim()
      };
      var data = await apiRespository.postApiCallByFormData(Constants.getVideoTutorialListBySearchUrl, body);

      filteredContentTypeList.value = VideoTutorial.fromJson(data.body);
      print(filteredContentTypeList.value.toJson());
      initializeOriginalList();
      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }

    // Initialize fetchDataFuture here
  }

}