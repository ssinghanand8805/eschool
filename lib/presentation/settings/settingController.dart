import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../apiHelper/Constants.dart';
import '../../apiHelper/popular_product_repo.dart';
import '../../apiHelper/toastMessage.dart';
import '../../apiHelper/userData.dart';
import '../academics/Promote Student/promote_student_modal.dart';
import '../dashboard/controller/dashbord_controller.dart';

class SettingController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<Sessionlist> SessionlistModel = <Sessionlist>[].obs;
  RxString currentActiveSession = "".obs;
  RxString currentActiveSessionName = "".obs;
  late Future<void> fetchDataFuture;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();


    fetchDataFuture =  getAllSession();
  }
  getSettingData() async {
    await getAllSession();
  }
  getAllSession()
  async {
    var body = {};
    var data  = await apiRespository.postApiCallByJson(Constants.getAllSessionListWithStatus,body);
    print("DATA @@@@ getAllSessionList ${data.body}");
    if(data.body != null)
    {
      var sessionData = data.body['sessionData'];
      print("000000000000");
      print(sessionData);
      final prefs = await SharedPreferences.getInstance();

      var activeSessionData = prefs.getString("sessionId");//sessionData['session_id'];
      var sessionList = data.body['sessionList'];
      print(sessionList);
      currentActiveSession.value = activeSessionData.toString();
      print(sessionList);
      try{
        for(var i=0;i<sessionList.length;i++)
        {
          Sessionlist s = Sessionlist.fromJson(sessionList[i]);
          SessionlistModel.value.add(s);
        }
        String name = SessionlistModel.firstWhere((session) => session.id.toString() == activeSessionData.toString())?.session ?? 'Not Found';
        currentActiveSessionName.value = name;
      }
      catch(ex)
    {
      print("EEE${ex}");
    }

// for(var i=0;i<SessionlistModel.length;i++)
//   {
//     Sessionlist sa = SessionlistModel[i];
//     print(sa.isActive);
//     if(sa.active.toString() != sa.id.toString())
//       {
//         currentActiveSession.value = sa.id.toString();
//         break;
//       }
//
//   }
      update();
    }
    else
    {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Session Loading Failed..Try Again"));

      update();
    }
  }
  updateSession()
  async {
    var body = {"popup_session":currentActiveSession.value};
    FormData formBody = FormData({});
    formBody.fields.addAll(body.entries);
    final prefs = await SharedPreferences.getInstance();
   await  prefs.setString("sessionId", currentActiveSession.value);
    var data  = await apiRespository.postApiCallByFormData(Constants.updateSessionUrl,formBody);
    print("DATA @@@@ getAllSessionList ${data.body}");
    if(data.body != null) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Session Updated..Now restarting data.."));
     await getAllSession();
      // var dashboardController = Get.put(DashboardController());
      // dashboardController.getSchoolDetails();
       Get.toNamed('/s_screen');
    }
    else
      {
        Get.showSnackbar(Ui.ErrorSnackBar(message: "Update Session Failed..Try Again"));
      }
    }


}