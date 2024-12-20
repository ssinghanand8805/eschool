import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/promote_student_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../common_widgets/model/CommonModel.dart';
import 'PromoteStudent.dart';

class PromoteStudentController extends GetxController{
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Sessionlist> SessionlistModel = <Sessionlist>[].obs;
  RxList<dynamic> SessionlistModelMap = <dynamic>[].obs;
  RxList<Classes> pramotedClassListModel = <Classes>[].obs;
  RxList<dynamic> pramotedClasslistModelMap = <dynamic>[].obs;
  RxList<Sections> pramotedSectionListModel = <Sections>[].obs;
  RxList<dynamic> pramotedSectionListModelMap = <dynamic>[].obs;
  Rx<String> pramotedSelectedClassId = "".obs;
  Rx<PromoteStudent> studentList = PromoteStudent().obs;
  Rx<String> pramotedSelectedSectionId = "".obs;
  RxMap selecetedStudents = {}.obs;
  RxMap isContinue = {}.obs;
  RxMap isPassed = {}.obs;
  RxBool isSessionLoading = false.obs;
  RxBool isClassLoading = false.obs;
  RxBool isSectionLoading = false.obs;
  Rx<String> selectedSessionId = "".obs;
  Rx<String> selectedSessionName = "".obs;
  void onInit() {
    super.onInit();
    getAllSessionList();
  }


  List demo = [
    {
      'name':"Faheem"
    },
    {
      'name':"Faheem"
    },
    {
      'name':"Faheem"
    },
  ];

  List<Map<String, dynamic>> data = [
    {
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentId': 18002,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Kirti Singh',
      'approvedId': 9000,
    },
    // Add more data as needed
  ];
  Future<void> getClassList() async
  {
    isClassLoading.value = true;
    var data  = await apiRespository.getApiCallByJson(Constants.getClassListUrl);
    print("DATA @@@@ ${data.body}");
    if(data.body != null)
    {
      for(var i=0;i<data.body.length;i++)
      {
        Classes s = Classes.fromJson(data.body[i]);
        pramotedClassListModel.value.add(s);
      }


      pramotedClasslistModelMap.value = pramotedClassListModel.value.map((item) {
        return item.toJson();
      }).toList();
      print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQ${pramotedClasslistModelMap.value}");
      isClassLoading.value = false;
  update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Class Loading Failed..Try Again"));
      isClassLoading.value = false;
    }
  }


  Future<void> getSectionList() async
  {
    isSectionLoading.value = true;
    pramotedSectionListModelMap.clear();
    var body = {
      "class_id": pramotedSelectedClassId.value
    };
    var data  = await apiRespository.postApiCallByJson(Constants.getSectionListUrl,body);
    print("DATA @@@@ ${data.body}");

    if(data.body != null)
    {
      for(var i=0;i<data.body.length;i++)
      {
        Sections s = Sections.fromJson(data.body[i]);
        pramotedSectionListModel.value.add(s);
      }


      pramotedSectionListModelMap.value = pramotedSectionListModel.value.map((item) {
        return item.toJson();
      }).toList();
      isSectionLoading.value = false;
      update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
      isSectionLoading.value = false;
    }

  }
  Future<void> findStudentList() async
  {
    CommonApiController controller3 = Get.put(CommonApiController());
    pramotedSectionListModelMap.clear();
    var body = {
      "class_id": controller3.selectedClassId.value,
      "class_promote_id": pramotedSelectedClassId.value,
      "section_id": controller3.selectedSectionId.value,
      "section_promote_id": pramotedSelectedSectionId.value,
      "session_id": selectedSessionId.value,
    };
    var data  = await apiRespository.postApiCallByFormData(Constants.findStudentsrequest,body);
    print("DATA @@@@ ${data.body}");

    if(data.body != null)
    {
      studentList.value = PromoteStudent.fromJson(data.body);
      for(var student in studentList.value.data!.resultlist!)
      {

        isContinue["${student.id}"] = true;
        isPassed["${student.id}"] = true;
        selecetedStudents["${student.id}"] = false;
      }
      update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Student Loading Failed..Try Again"));

    }

  }

  Future<void> getAllSessionList() async
  {
    isSessionLoading.value = true;
    update();
   await getClassList();
    var body = {};
    var data  = await apiRespository.postApiCallByJson(Constants.getAllSessionList,body);
    print("DATA @@@@ getAllSessionList ${data.body}");
    if(data.body != null)
    {
      var sessionList = data.body['data']['sessionlist'];
      for(var i=0;i<sessionList.length;i++)
      {
        Sessionlist s = Sessionlist.fromJson(sessionList[i]);
        SessionlistModel.value.add(s);
      }


      SessionlistModelMap.value = SessionlistModel.value.map((item) {
        return item.toJson();
      }).toList();

      isSessionLoading.value = false;
      update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
      isSessionLoading.value = false;
      update();
    }

  }
  Future<void> promoteStudent() async
  {
    List<String> selectedStudentsList = selecetedStudents.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key.toString())
        .toList();
    var body = {
      "class_promote_id": pramotedSelectedClassId.value,
      "section_promote_id": pramotedSelectedSectionId.value,
      "session_id": selectedSessionId.value,
      "student_list":selectedStudentsList.join(',')
    };
    for(var i=0;i<selectedStudentsList.length;i++)
      {
        String student_id = selectedStudentsList[i];
        body["result_${student_id}"] = isPassed[student_id] == true? "pass":"fail";
        body["next_working_${student_id}"] = isContinue[student_id] == true? "countinue":"leave";
      }
    print(body);
    var data  = await apiRespository.postApiCallByFormData(Constants.promoteStudentsrequest,body);
    print("dddd${data}");
    if(data.body != null)
    {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Promote Successfull"));
    }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: data.body.toString()));
      }


  }



}