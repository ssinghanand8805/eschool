import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import 'book_list_modal.dart';

class BookListController  extends GetxController {

  TextEditingController searchC = TextEditingController();
  final bookTypeController = TextEditingController();
  final bookTitleController = TextEditingController();
  final bookNumberController = TextEditingController();
  final isbnNumberController = TextEditingController();
  final publisherController = TextEditingController();
  final authorController = TextEditingController();
  final subjectController = TextEditingController();
  final rackNumberController = TextEditingController();
  final quantityController = TextEditingController();
  final bookPriceController = TextEditingController();
  final postDateController = TextEditingController(text: '13/11/2024');
  final descriptionController = TextEditingController();

  Rx<TextEditingController> postDate = TextEditingController().obs;
  CommonApiController commonApiController = Get.put(CommonApiController());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<BookDataModal> filteredContentTypeList = BookDataModal().obs;
  late Future<void> fetchDataFuture;
  List<Listbook> originalContentTypeList = [];
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
    // bookList();
  }

  void initializeOriginalList() {
    print("fffff${filteredContentTypeList.value.data!.listbook}");
    originalContentTypeList = List.from(filteredContentTypeList.value.data!.listbook!); // Make a copy of the original data
  }

  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data!.listbook = originalContentTypeList; // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<Listbook> filteredList = originalContentTypeList
          .where((element) =>
      element.bookTitle != null &&
          element.bookTitle!.toLowerCase().contains(searchKey.toLowerCase().trim())) // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val!.data!.listbook = filteredList;
      });
    }
  }

  Future<void> initializeData() async {
    //isLoading.value = true;
    try {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getAllBookUrl, body);

      filteredContentTypeList.value = BookDataModal.fromJson(data.body);
      print("wwwww${filteredContentTypeList.value.toJson()}");
      initializeOriginalList();
      update();
    }
    catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  /// api work by faheem


  clearController(){
    bookTitleController.clear();
    bookNumberController.clear();
    isbnNumberController.clear();
    subjectController.clear();
    rackNumberController.clear();
    publisherController.clear();
    authorController.clear();
    quantityController.clear();
    bookPriceController.clear();
    descriptionController.clear();
    postDateController.clear();
  }

  bookList() async {
    var body = {};
    var data = await apiRespository.postApiCallByJson(Constants.getAllBookUrl, body);
    print("LibraryApi: ${data.body}");
  }

  RxString bookTypeId = "".obs;

  createBook(context) async {
    var body = {
      "book_type": bookTypeId.value,
      "book_title": bookTitleController.value.text,
      "book_no": bookNumberController.value.text,
      "isbn_no": isbnNumberController.value.text,
      "subject": subjectController.value.text,
      "rack_no": rackNumberController.value.text,
      "publish": publisherController.value.text,
      "author": authorController.value.text,
      "qty": quantityController.value.text,
      "perunitcost": bookPriceController.value.text,
      "description": descriptionController.value.text,
      "postdate": postDateController.value.text
    };
    print("BODY ${body}");
    var data = await apiRespository.postApiCallByFormData(Constants.crateBookUrl, body);
    print("sssssssssss"+data.body.toString());
    if(data.body['status']==1){
      fetchDataFuture = initializeData();
      Get.showSnackbar(Ui.SuccessSnackBar(message: data.body['msg'].toString()));
      Navigator.pop(context);
      clearController();
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(message: data.body['msg'].toString()));
    }
  }

  deleteBookDetails(){

  }

}