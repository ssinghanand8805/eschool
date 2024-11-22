
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonApiController.dart';

import 'daily_collection_modal.dart';


class DailyCollectionController extends GetxController{

  TextEditingController searchC = TextEditingController();
  Rx<TextEditingController> fromDate = TextEditingController().obs;
  Rx<TextEditingController> toDate = TextEditingController().obs;
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  Rx<DailyCollection> filteredContentTypeList =  DailyCollection().obs;

  late Future<void> fetchDataFuture;
  List<FeesData> originalContentTypeList = [];
  RxString selectedSearchType = 'all'.obs;

  @override
  void onInit() async {
    super.onInit();

    fetchDataFuture = setDateOnInit();
  }
  void initializeOriginalList() {
    originalContentTypeList = List.from(filteredContentTypeList.value.feesData!);  // Make a copy of the original data
  }
  setDateOnInit()
  async {
    DateTime now = DateTime.now();
    var d =  await GlobalData().ConvertToSchoolDateTimeFormat(now);
    fromDate.value.text = d;
    toDate.value.text = d;
     initializeData();
  }
  Future<void> searchContentType(String searchKey) async {
    // Check if the searchKey is empty or not
    if (searchKey.isEmpty) {
      // Reset to the original list when searchKey is cleared
      filteredContentTypeList.update((val) {
        val?.feesData = originalContentTypeList;  // Reset to original list
      });
    } else {
      // Filter the list based on the searchKey
      List<FeesData> filteredList = originalContentTypeList
          .where((element) => element.txn!.date != null &&
          element.txn!.date!.toString().toLowerCase().contains(searchKey.toLowerCase().trim()))  // Perform case-insensitive search
          .toList();

      // Update the filtered list
      filteredContentTypeList.update((val) {
        val?.feesData = filteredList;
      });
    }
  }
  Future<void> initializeData() async  {
    //isLoading.value = true;
    DateTime parsedDate = DateFormat("dd/MM/yyyy").parse(fromDate.value.text.toString());
    String fromDateString = await GlobalData().ConvertToSchoolDateTimeFormat(parsedDate);
    DateTime parsedDateTo = DateFormat("dd/MM/yyyy").parse(toDate.value.text.toString());
    String toDateString = await GlobalData().ConvertToSchoolDateTimeFormat(parsedDateTo);
    var body = {"date_from":fromDateString,"date_to":toDateString};
    try
    {

      var data = await apiRespository.postApiCallByJson(Constants.dailycollectionreportUrl, body);

     filteredContentTypeList.value =  DailyCollection.fromJson(data.body);
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