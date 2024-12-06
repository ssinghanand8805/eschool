import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/chat_api_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../model/StaffList.dart';
import 'ChatGlobalController.dart';

class UserListController extends GetxController with GetTickerProviderStateMixin  {
  UserData userData = Get.put(UserData());
  ChatApiRespository apiRespository = ChatApiRespository(
      apiClient: Get.find(tag: 'chatApi'));
  Rx<StaffList> staffUserList = StaffList().obs;
  Rx<StaffList> studentUserList = StaffList().obs;
  late TabController tabController;
  final CommonApiController commonApiController = Get.put( CommonApiController());
  late Future<void> fetchDataFuture;
  RxBool isAddingMember = false.obs;
  TextEditingController txtController = TextEditingController();
  RxMap<String,bool> selectedItems = <String,bool>{}.obs;
  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);





    fetchDataFuture = initializeData();
    // update();
  }

  Future<void> initializeData() async {

    try {
      var body = {};
      String url = Constants.staff_users_list;
      var data  = await apiRespository.getApiCallByJson(url,);

      staffUserList.value = StaffList.fromJson(data.body);
      var isAddingMember2 = await Get.arguments['isAddingMember'];
      print("OOOOOOOOOOO${isAddingMember2}");
      isAddingMember.value = isAddingMember2;
      for(var i=0;i<staffUserList.value.data!.users!.length;i++)
      {
        Users staff = staffUserList.value.data!.users![i];
        selectedItems[staff.id!.toString()] = false;
      }
      print(staffUserList.value.toJson());
     // initializeOriginalList();
      update();
    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }
  Future<void> getStudentDataByClassAndSection() async {
    try {
      var body = {};
      if(commonApiController.selectedClassId.value.isNotEmpty && commonApiController.selectedSectionId.value.isNotEmpty)
        {
          String url = Constants.student_list + commonApiController.selectedClassId.value + '/' + commonApiController.selectedSectionId.value;
          var data  = await apiRespository.getApiCallByJson(url,);
          print("dataaaaaaa${data.body}");
          studentUserList.value = StaffList.fromJson(data.body);
          for(var i=0;i<studentUserList.value.data!.users!.length;i++)
            {
              Users student = studentUserList.value.data!.users![i];
              selectedItems[student.id!.toString()] = false;
            }
          print(studentUserList.value.toJson());
          // initializeOriginalList();
          update();
        }

    } catch (e) {
      print("EEEEEEEEEEEEEEEEEEEE${e}");
      update();
    }
  }
}