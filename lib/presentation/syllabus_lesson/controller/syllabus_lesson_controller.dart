import 'package:lerno/apiHelper/userData.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../core/app_export.dart';
import '../model/SyllabusStatus.dart';



class SyllabusLessonController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());
  RxList<SyllabusLesson> syllabusLessonModelObj = <SyllabusLesson>[].obs;
  late Future<void> fetchDataFuture;
  final args = Get.arguments; // This is a Map
  // final key1Value = args["key1"];
  // final key2Value = args["key2"];
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    print("route params    ${args["subjectGroupSubjectId"]}");
    fetchDataFuture = getData(args["subjectGroupSubjectId"],args["classSectionId"]); // Initialize the future when the controller is created
  }
  Future<void> getData(subjectGroupSubjectId,classSectionId) async
  {
    Map<String,dynamic> body = {
      "subject_group_subject_id" : subjectGroupSubjectId,
      "subject_group_class_sections_id" : classSectionId,
    };
    print("Body @@@@ ${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.getSubjectsLessonsUrl, body);
    print("DATA @@@@ ${data.body}");
    List<SyllabusLesson> d = [];
    for(var i =0;i<data.body.length; i++)
      {
        print("DATA @@@@ ${data.body[i]}");
        d.add(SyllabusLesson.fromJson(data.body[i]));
      }
    syllabusLessonModelObj.value = d;
    print("111111111111111111111 ${syllabusLessonModelObj.value}");
    update();
  }
}
