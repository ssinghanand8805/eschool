import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'media_manager_modal.dart';

class MediaManagerController extends GetxController {
  TextEditingController searchC = TextEditingController();
  TextEditingController titleC = TextEditingController();

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<MediaManagerModal> mediaManagerList = MediaManagerModal().obs;
  Rx<MediaTypeListModal> mediaType = MediaTypeListModal().obs;
  List<dynamic> listToSearch = [];
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  RxList<File> pickedFile = <File>[].obs;
  late Future<void> fetchDataFuture;
  List<Data> originalContentTypeList = [];
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
    getMediaType();
  }

  void initializeOriginalList() {
    originalContentTypeList = List.from(mediaManagerList.value.data!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      mediaManagerList.update((val) {
        val?.data = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<Data> filteredList = originalContentTypeList
          .where((element) => element.imgName != null &&
          element.imgName!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      mediaManagerList.update((val) {
        val?.data = filteredList;
      });
    }
  }

  Future<void> initializeData() async {
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getAllMediaList, body);

      mediaManagerList.value = MediaManagerModal.fromJson(data.body);
      print(mediaManagerList.value.toJson());
      initializeOriginalList();
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  addImage(BuildContext context, RxList<File> files) async {
    try {
      if (files.isEmpty) {
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: "No files selected for upload."),
        );
        return;
      }
      List<MultipartFile> ff =[];
      for (int i = 0; i < files.length; i++)
        {
          ff.add(MultipartFile(
            await files[i].readAsBytes(),
            filename: files[i].path.split('/').last,
          ));
        }
      print("FFFFFFF ${ff[0].filename}");
    //     'files[]': MultipartFile(
    // await files[i].readAsBytes(),
    // filename: files[i].path.split('/').last,
    // )
    //   var formData = FormData({
    //     for (int i = 0; i < files.length; i++)
    //       'files[]': MultipartFile(
    //         await files[i].readAsBytes(),
    //         filename: files[i].path.split('/').last,
    //       ),
    //   });
      var formData = FormData({
        'files[]': ff,
      });
      var data = await apiRespository.postApiCallByFormData(
        Constants.addMediaImage,
        formData,
      );
print("DATA !@# ${data.body}");
      if (data.body['status'] == 1) {
        Get.showSnackbar(
          Ui.SuccessSnackBar(message: data.body['msg'].toString()),
        );
        initializeData();
      } else {
        Get.showSnackbar(
          Ui.ErrorSnackBar(message: data.body['msg'].toString()),
        );
      }
    } catch (e) {
      print("Error in addMedia: $e");
      Get.showSnackbar(
        Ui.ErrorSnackBar(message: "Failed to upload files. Please try again."),
      );
      update();
    }
  }


  Future<void> getMediaType() async {

    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(
          Constants.getMediaTypeList, body);

      mediaType.value = MediaTypeListModal.fromJson(data.body);

       listToSearch = data.body['data']['mediaTypes']?.entries
          .map((entry) => {"key": entry.key, "value": entry.value})
          .toList() ??
          [];
      update();
    } catch (e) {
      print("error${e}");
      update();
    }
  }

  addVideo(context, videoUrl) async {
    try {
      var body = {"video_url": videoUrl};
      var data = await apiRespository.postApiCallByFormData(
          Constants.addMediaVideo, body);

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


  deleteMedia(context, recordId) async {
    try {
      var body = {"record_id": recordId};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteMediaItem, body);

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
