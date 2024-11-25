import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import 'gallery_modal.dart';

class GalleryController extends GetxController{

  TextEditingController searchC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<GalleryModal> galleryList =  GalleryModal().obs;

  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  TextEditingController titleC = TextEditingController();
  Rx<HtmlEditorController> HtmlController = HtmlEditorController().obs;
  Rx<File?> pickedFile = Rx<File?>(null);
  late Future<void> fetchDataFuture;
  List<Data> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }

  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getGalleryList, body);

      galleryList.value =  GalleryModal.fromJson(data.body);
      print(galleryList.value.toJson());

      update();
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }

    // Initialize fetchDataFuture here
  }
  deleteGallery(context, slug) async {
    try {
      var body = {"slug": slug};
      var data = await apiRespository.postApiCallByFormData(
          Constants.deleteSectionList, body);

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