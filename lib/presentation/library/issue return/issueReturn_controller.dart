import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../book list/book_list_modal.dart';
import 'issueBook_view.dart';
import 'issueReturn_modal.dart';
import 'member_details.dart' as meberdetails;

class IssueReturnController extends GetxController{

  TextEditingController searchC = TextEditingController();
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<LibraryMemberList> filteredContentTypeList =  LibraryMemberList().obs;
  RxList bookList = [].obs;

  Rx< meberdetails.LibraryMemberDetails> memberDetailsModel =  meberdetails.LibraryMemberDetails().obs;
  Rx<TextEditingController> attendanceDate = TextEditingController().obs;
  late Future<void> fetchDataFuture;
  List<MemberList> originalContentTypeList = [];
  RxBool isLoading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    fetchDataFuture = initializeData();
    getAllBook();
  }
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.data!.memberList!);  // Make a copy of the original data
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.data!.memberList = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<MemberList> filteredList = originalContentTypeList
          .where((element) => element.firstname != null &&
          element.firstname!.toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.data!.memberList = filteredList;
      });
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    try
    {
      var body = {};
      var data = await apiRespository.postApiCallByJson(Constants.getMemberListUrl, body);

      filteredContentTypeList.value =  LibraryMemberList.fromJson(data.body);
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

  Future<void> getAllBook() async {

    try {
      var body = {};
      var data =
      await apiRespository.postApiCallByJson(Constants.getAllBookUrl, body);
      bookList.value = data.body['data']['listbook'];
      print("all book${bookList.value}");
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }



  Future<void> getMemberDetails(id,context) async  {
    //isLoading.value = true;
    try
    {
      var body = {"id":id.toString()};
      var data = await apiRespository.postApiCallByFormData(Constants.getMemberDetailsUrl, body);
print("hfhfhfhfh$body");
      memberDetailsModel.value =  meberdetails.LibraryMemberDetails.fromJson(data.body);

      update();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LibraryManagementPage()),
      );
    }
    catch(e)
    {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }


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