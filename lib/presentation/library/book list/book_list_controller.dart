import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
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
  RxString selectedId = "".obs;
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
  resetData()
  async {
    selectedId.value = "";
    bookTypeController.text = "";
    bookTitleController.text = "";
    bookNumberController.text = "";
    isbnNumberController.text = "";
    publisherController.text ="";
    authorController.text = "";
    subjectController.text = "";
    rackNumberController.text = "";
    quantityController.text = "";
    bookPriceController.text = "";
    descriptionController.text =  "";
    String formattedDate = await GlobalData().ConvertToSchoolDateTimeFormat(DateTime.now());
    postDate.value.text = formattedDate;
    update();
  }
  Future<void> getEditData(rowId) async {
    //isLoading.value = true;
    try {
      await resetData();
      var body = {"id":rowId};
      var data = await apiRespository.postApiCallByFormData(Constants.getBookByIdUrl, body);
      selectedId.value = rowId;
      BookDataModal bookDataModal = BookDataModal.fromJson(data.body);
      bookTypeController.text = bookDataModal.data!.listbook![0].bookTypeId!;
      bookTitleController.text = bookDataModal.data!.listbook![0].bookTitle!;
      bookNumberController.text = bookDataModal.data!.listbook![0].bookNo!;
      isbnNumberController.text = bookDataModal.data!.listbook![0].isbnNo!;
      publisherController.text = bookDataModal.data!.listbook![0].publish!;
      authorController.text = bookDataModal.data!.listbook![0].author!;
      subjectController.text = bookDataModal.data!.listbook![0].subject!;
      rackNumberController.text = bookDataModal.data!.listbook![0].rackNo!;
      quantityController.text = bookDataModal.data!.listbook![0].qty!;
      bookPriceController.text = bookDataModal.data!.listbook![0].perunitcost!;
    //  postDateController.text = bookDataModal.data!.listbook![0].postdate!;
      descriptionController.text = bookDataModal.data!.listbook![0].description!;
      DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(bookDataModal.data!.listbook![0].postdate!);
      String formattedDate = await GlobalData().ConvertToSchoolDateTimeFormat(parsedDate);
      postDate.value.text = formattedDate;

      update();
    }
    catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

  /// api work by faheem




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
      "postdate": postDate.value.text
    };
    String url = Constants.crateBookUrl;
    if(selectedId.value != "")
    {
body["id"] = selectedId.value;
url = Constants.updateBookByIdUrl;
    }
    print("BODY ${body}");
    var data = await apiRespository.postApiCallByFormData(url, body);
    print("sssssssssss"+data.body.toString());
    if(data.body['status']==1){
      fetchDataFuture = initializeData();
      Get.showSnackbar(Ui.SuccessSnackBar(message: data.body['msg'].toString()));
      Navigator.pop(context);
      resetData();
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(message: data.body['msg'].toString()));
    }
  }

  deleteBookDetails(context,id) async {
    try {
      var body = {"id":id};
      var data = await apiRespository.postApiCallByFormData(Constants.deleteBookByIdUrl, body);
      if(data.body['status']==1){
        fetchDataFuture = initializeData();
        Get.showSnackbar(Ui.SuccessSnackBar(message: data.body['msg'].toString()));
        //Navigator.pop(context);
        resetData();
      }else{
        Get.showSnackbar(Ui.ErrorSnackBar(message: data.body['msg'].toString()));
      }
    }
    catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }

}