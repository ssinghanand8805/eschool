import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import 'book_list_modal.dart';

class BookListController  extends GetxController{

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
  Rx<BookList> filteredContentTypeList = BookList().obs;
  late Future<void> fetchDataFuture;
  List<Data> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
  }
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.data!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<Data> filteredList = originalContentTypeList
          .where((element) => element.name != null &&
          element.name!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.data = filteredList;
      });
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.contentShareListUrl, body);

      filteredContentTypeList.value = BookList.fromJson(data.body);
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
  // List<Map<String, dynamic>> data = [
  //   {
  //     'studentId': 18001,
  //     'class': 'Class 4',
  //     'section': 'A',
  //     'subjectGroup': 'Class 1st Subject Group',
  //     'subject': 'Hindi (230)',
  //     'homeworkDate': DateTime(2024, 4, 5),
  //     'submissionDate': DateTime(2024, 4, 9),
  //     'evaluationDate': DateTime(2024, 4, 9),
  //     'createdBy': 'Joe Black',
  //     'approvedId': 9000,
  //   },
  //   {
  //     'studentId': 18002,
  //     'class': 'Class 4',
  //     'section': 'A',
  //     'subjectGroup': 'Class 1st Subject Group',
  //     'subject': 'Hindi (230)',
  //     'homeworkDate': DateTime(2024, 4, 5),
  //     'submissionDate': DateTime(2024, 4, 9),
  //     'evaluationDate': DateTime(2024, 4, 9),
  //     'createdBy': 'Kirti Singh',
  //     'approvedId': 9000,
  //   },
  //   // Add more data as needed
  // ];

}