
import 'package:get/get.dart';

import '../../../../apiHelper/popular_product_repo.dart';

import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/userData.dart';

import '../../student_attendence/model/Student_Attendance.dart';
import '../model/SchoolAttendanceByDate.dart';



class SchoolAttendanceByDateController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient:Get.find());

  Rx<SchoolAttendance> filteredStudentListModel = SchoolAttendance().obs;
  @override
  void onClose() {
    super.onClose();

  }

  final Rx<DateTime> applyDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async
  {
    Map<String, dynamic> body = {

    };

    var data = await apiRespository.postApiCallByJson(Constants.dailyattendancereport, body);
    if(data.body != null)
      {
        filteredStudentListModel.value = SchoolAttendance.fromJson(data.body);
        update();
      }

    // filteredStudentListModel =  students
    //     .map((student) => SchoolAttendance.fromJson(student))
    //     .toList()
    //     .obs;
    // update();
  }



}
