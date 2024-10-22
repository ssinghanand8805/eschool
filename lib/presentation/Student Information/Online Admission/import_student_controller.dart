import 'package:get/get.dart';

import '../../../apiHelper/popular_product_repo.dart';
import '../../common_widgets/controller/CommonApiController.dart';

class ImportStudentController extends GetxController{
  RxList demo = [
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
    {'name':"Faheem"},
  ].obs;


  ///for demo

  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  CommonApiController commonApiController = Get.put(CommonApiController());
  RxString selectedClassName = "".obs;
  RxString selectedSectionName = ''.obs;

  RxList groupList = [
    {'name': 'Group'}, {'name': 'Individual'}, {'name': 'Class'}
  ].obs;
  RxString selectedGroup = "".obs;

  RxList  ggroupList = [
    {
      'id': "1",
      "name": "Students"
    },
    {
      'id': "2",
      "name": "Guardians"
    },
    {
      'id': "3",
      "name": "Admin"
    },
    {
      'id': "4",
      "name": "Teacher"
    },
    {
      'id': "5",
      "name": "Accountant"
    },
    {
      'id': "6",
      "name": "Librarian"
    },
    {
      'id': "7",
      "name": "Receptionist"
    },
    {
      'id': "8",
      "name": "Super Admin"
    },
    {
      'id': "9",
      "name": "Fuckin test"
    }
  ].obs;

  RxList selectedGgroupList = [].obs;


  RxString selectIndividual = "".obs;

  RxList selectedIndividualList = [].obs;

}