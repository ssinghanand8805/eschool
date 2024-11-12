import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../download_center/Upload Content/ParrentUserList.dart';
import '../../download_center/Upload Content/StaffUser.dart';
import '../../download_center/Upload Content/StudentGaurdian_modal.dart';
import '../model/CommonModel.dart';
import '../model/UserRole.dart';

class CommonUserSelectionController extends GetxController {
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Classes> classListModel = <Classes>[].obs;
  RxList<dynamic> classListModelMap = <dynamic>[].obs;
  RxList<Sections> sectionListModel = <Sections>[].obs;
  RxList<dynamic> sectionListModelMap = <dynamic>[].obs;
  Rx<String> selectedClassId = "".obs;
  RxBool isClassLoading = false.obs;
  RxBool isSectionLoading = false.obs;
  Rx<String> selectedSectionId = "".obs;
  Rx<bool> isLoadingStudentList = false.obs;
  Rx<String> selectedClassName = "".obs;
  Rx<String> selectedSectionName = "".obs;
  Rx<String> selectedUserType = "group".obs;
  RxList<String> selectedGroup = <String>[].obs;
  RxList<String> selectedClassSectionId = <String>[].obs;
  Rx<String> selectedCategory = "".obs;
  TextEditingController userSearch = TextEditingController();
  RxList<Map<String, dynamic>> userTypeList = <Map<String, dynamic>>[
    { 'id':'group','name':'Group'  },
    { 'id':'class','name':'Class'  },
    { 'id':'individual','name':'Individual'  },

  ].obs;
  RxList<Map<String, String?>> groupList = [  {    'id': "student",    "name": "Students"  },  {    'id': "parent",    "name": "Guardians"  }].obs;
  RxList<Map<String, String?>> searchGroupList = [  {    'id': "student",    "name": "Students"  },  {    'id': "parent",    "name": "Guardians"  },{    'id': "student_guardian",    "name": "Student Guardian"  }].obs;

  Rx<String> slectedCategoryType = "".obs;


  @override
  void onInit() {
    super.onInit();

   getClassList();
    // Initialize the future when the controller is created
  }

  RxList<UserItem> userList = <UserItem>[].obs;
  RxList<UserItem> selectedUserList = <UserItem>[].obs;
  Future<void> getClassList() async
  {
    await getUserRoleList();
    isClassLoading.value = true;
    update();
    var data  = await apiRespository.getApiCallByJson(Constants.getClassListUrl);
    print("DATA @@@@ ${data.body}");
    if(data.body != null)
      {
        for(var i=0;i<data.body.length;i++)
        {
          Classes s = Classes.fromJson(data.body[i]);
          classListModel.value.add(s);
        }


        classListModelMap.value = classListModel.value.map((item) {
          return item.toJson();
        }).toList();

        isClassLoading.value = false;
        update();
      }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Class Loading Failed..Try Again"));
        isClassLoading.value = false;
        update();
      }

  }
  Future<void> getUserRoleList() async
  {
print("dddddddddddddddddddddddd");
    var data  = await apiRespository.postApiCallByJson(Constants.getUserRoleListUrl,{});
    print("DATA @@@@ ${data.body}");
    if(data.body != null)
      {
        UserRole s = UserRole.fromJson(data.body);
        for(var i=0;i<s.data!.length;i++)
        {
          var d = {'id': s.data![i].id ?? "",    "name": s.data![i].name ?? ""};
          if(d['id'] != "" && d['name'] != "")
            {
              if (!groupList.any((item) => item['id'] == d['id'] && item['name'] == d['name'])) {
                groupList.add(d);
              }

              // Check if the element is not already in searchGroupList
              if (!searchGroupList.any((item) => item['id'] == d['id'] && item['name'] == d['name'])) {
                searchGroupList.add(d);
              }
            }



        }


        update();
      }
    else
      {
      //  Get.showSnackbar(Ui.ErrorSnackBar(message: "Class Loading Failed..Try Again"));

        update();
      }

  }

  Future<void> getSectionList() async
  {
    isSectionLoading.value = true;
    update();
    sectionListModel.clear();
    sectionListModelMap.clear();
var body = {
  "class_id": selectedClassId.value
};
    var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl,body);
    print("DATA @@@@ ${data.body}");

    if(data.body != null)
      {
        for(var i=0;i<data.body.length;i++)
        {
          Sections s = Sections.fromJson(data.body[i]);
          sectionListModel.value.add(s);
        }


        sectionListModelMap.value = sectionListModel.value.map((item) {
          return item.toJson();
        }).toList();

        isSectionLoading.value = false;
        update();
      }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
        isSectionLoading.value = false;
        update();
      }

  }
  Future<void> getUserList() async
  {

String url = '';
var body = {
};
if(selectedCategory.value == 'student')
  {
    url = Constants.getAllStudentsGaurdianListUrl;
    var data  = await apiRespository.postApiCallByJson(url,body);
    if(data.body != null)
    {
      StudentGaurdian st = StudentGaurdian.fromJson(data.body);
      var stuList = st.data!.map((item) {
        return UserItem(id: item.id!,name: item.firstname!    + item.lastname!,type: selectedCategory.value);
       // return {"id":item.id,"name":item.firstname!    + item.lastname!,"type": selectedCategory.value};
      }).toList();
      userList.value = stuList;
      print("4444444444444444444444444${stuList}");
    }
  }
else if(selectedCategory.value == 'parent')
  {
    url = Constants.getAllParentListUrl;
    var data  = await apiRespository.postApiCallByJson(url,body);
    if(data.body != null)
    {
      ParentUser st = ParentUser.fromJson(data.body);
      var stuList = st.data!.map((item) {
        return UserItem(id: item.id!,name: item.firstname!    + item.lastname!,type: selectedCategory.value);
       // return {"id":item.id,"name":item.firstname!    + item.lastname! + " ( " + item.guardianName! + " )","type": selectedCategory.value};
      }).toList();
      userList.value = stuList;
      print("4444444444444444444444444${stuList}");
    }
  }
else
{
  url = Constants.getAllStaffListUrl;
  body = {"role_id":selectedCategory.value};
  var data  = await apiRespository.postApiCallByJson(url,body);
  print("4444444444444444444444444${data.body}");
  if(data.body != null)
  {

    StaffUser st = StaffUser.fromJson(data.body);
    var stuList = st.data!.map((item) {
      return UserItem(id: item.id!,name: item.name!    + " ( " + item.employeeId! + " )",type: selectedCategory.value);
      // return {"id":item.id,"name":item.name!    + " ( " + item.employeeId! + " )","type": selectedCategory.value};
    }).toList();
    userList.value = stuList;
    print("4444444444444444444444444${stuList}");
  }
  update();
}

    // var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl,body);
    // print("DATA @@@@ ${data.body}");
    //
    // if(data.body != null)
    //   {
    //     for(var i=0;i<data.body.length;i++)
    //     {
    //       Sections s = Sections.fromJson(data.body[i]);
    //       sectionListModel.value.add(s);
    //     }
    //
    //
    //     sectionListModelMap.value = sectionListModel.value.map((item) {
    //       return item.toJson();
    //     }).toList();
    //
    //     isSectionLoading.value = false;
    //     update();
    //   }
    // else
    //   {
    //     Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
    //     isSectionLoading.value = false;
    //     update();
    //   }

  }
}
class UserItem {
  final String id;
  final String name;
  final String type;

  UserItem({required this.id, required this.name,required this.type});

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(id: json['id'], name: json['name'],type: json['type']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}
