import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/promote_student_modal.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/toastMessage.dart';

class PromoteStudentController extends GetxController{
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<Sessionlist> SessionlistModel = <Sessionlist>[].obs;
  RxList<dynamic> SessionlistModelMap = <dynamic>[].obs;
  RxBool isChecked = false.obs;
  RxBool isPassed = false.obs;
  RxBool isClassLoading = false.obs;
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


  Future<void> getAllSessionList() async
  {
    isClassLoading.value = true;
    update();
    var body = {};
    var data  = await apiRespository.postApiCallByJson(Constants.getAllSessionList,body);
    print("DATA @@@@ getAllSessionList ${data.body}");
    if(data.body != null)
    {
      for(var i=0;i<data.body.length;i++)
      {
        Sessionlist s = Sessionlist.fromJson(data.body[i]);
        SessionlistModelMap.value.add(s);
      }


      SessionlistModelMap.value = SessionlistModel.value.map((item) {
        return item.toJson();
      }).toList();

      isClassLoading.value = false;
      update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Section Loading Failed..Try Again"));
      isClassLoading.value = false;
      update();
    }

  }

}