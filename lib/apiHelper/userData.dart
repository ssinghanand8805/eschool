

import 'package:learnladder/apiHelper/popular_product_repo.dart';
import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';
import 'Constants.dart';



class UserData extends GetxController {
  final userData = GetStorage();

  String get getAccessToken => userData.read('accessToken') ?? '';
  String get getUserId => userData.read('userId') ?? '';
  String get getRole => userData.read('role') ?? '';
  String get getUsername => userData.read('username') ?? '';
  String get getSchoolName => userData.read('schoolName') ?? '';
  String get getCurrency_symbol => userData.read('currency_symbol') ?? '';
  String get getCurrency_short_name => userData.read('currency_short_name') ?? '';
  String get getStart_week => userData.read('start_week') ?? '';
  String get getStudent_session_id => userData.read('student_session_id') ?? '';
  String get getUserImage => userData.read('imagesUrl') ?? '';
  String get getUserStudentId => userData.read('student_id') ?? '';
  String get getUserClassSection => userData.read('class_section') ?? '';
  String get getUserFCMDeviceToken => userData.read('fcm_tocken') ?? '';
  String get getUserStudentName => userData.read('student_name') ?? '';
  String get getUserAdmissionNo => userData.read('admission_no') ?? '';
  bool get getUserIsLoggedIn => userData.read('isLoggegIn') ?? false;
  bool get getUserHasMultipleChild => userData.read('hasMultipleChild') ?? false;
  bool get getIsUserImage => userData.read('isUserImage') ?? false;
  String get getLastUserId => userData.read('lastUserId') ?? "";
  String get getLastUserPwd => userData.read('lastUserPwd') ?? "";


  addAccessToken(String val) {userData.write('accessToken', val);}
  addUserFCMDeviceToken(String val) {userData.write('fcm_tocken', val);}
  addUserId(String val) {userData.write('userId', val);}
  addRole(String val) {userData.write('role', val);}
  addLastUserId(String val) {userData.write('lastUserId', val);}
  addLastUserPwd(String val) {userData.write('lastUserPwd', val);}
  addUsername(String val) {userData.write('username', val);}
  addUserImage(String val) {userData.write('imagesUrl', val);}
  addSchoolName(String val) {userData.write('schoolName', val);}
  addCurrency_symbol(String val) {userData.write('currency_symbol', val);}
  addCurrency_short_name(String val) {userData.write('currency_short_name', val);}
  addStart_week(String val) {userData.write('start_week', val);}
  addStudent_session_id(String val) {userData.write('student_session_id', val);}
  addUserStudentId(String val) {userData.write('student_id', val);}
  addUserStudentName(String val) {userData.write('student_name', val);}
  addUserClassSection(String val) {userData.write('class_section', val);}
  addUserAdmissionNo(String val) {userData.write('admission_no', val);}
  addUserIsLoggedIn(bool val) {userData.write('isLoggegIn', val);}
  addUserHasMultipleChild(bool val) {userData.write('hasMultipleChild', val);}
  addIsUserImage(bool val) {userData.write('isUserImage', val);}


  saveData<T>(String storageKey,T dataModel){
    userData.write(storageKey,dataModel);
  }

  getData<T>(String storageKey){
   return userData.read(storageKey);
  }
  Future<void> saveAllDataToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    // Write all data to SharedPreferences
    await prefs.setString('accessToken', getAccessToken);
    await prefs.setString('userId', getUserId);
    await prefs.setString('role', getRole);
    await prefs.setString('username', getUsername);
    await prefs.setString('schoolName', getSchoolName);
    await prefs.setString('currency_symbol', getCurrency_symbol);
    await prefs.setString('currency_short_name', getCurrency_short_name);
    await prefs.setString('start_week', getStart_week);
    await prefs.setString('student_session_id', getStudent_session_id);
    await prefs.setString('imagesUrl', getUserImage);
    await prefs.setString('student_id', getUserStudentId);
    await prefs.setString('class_section', getUserClassSection);
    await prefs.setString('fcm_tocken', getUserFCMDeviceToken);
    await prefs.setString('student_name', getUserStudentName);
    await prefs.setString('admission_no', getUserAdmissionNo);
    await prefs.setBool('isLoggegIn', getUserIsLoggedIn);
    await prefs.setBool('hasMultipleChild', getUserHasMultipleChild);
    await prefs.setBool('isUserImage', getIsUserImage);
  }
  Future<void> loadDataFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    addAccessToken(prefs.getString('accessToken') ?? '');
    addUserId(prefs.getString('userId') ?? '');
        addRole(prefs.getString('role') ?? '');
    addUsername(prefs.getString('username') ?? '');
    addSchoolName(prefs.getString('schoolName') ?? '');
    addCurrency_symbol(prefs.getString('currency_symbol') ?? '');
    addCurrency_short_name(prefs.getString('currency_short_name') ?? '');
    addStart_week(prefs.getString('start_week') ?? '');
    addUserStudentId( prefs.getString('student_session_id') ?? '');
    addUserImage(prefs.getString('imagesUrl') ?? '');
    addUserStudentId(prefs.getString('student_id') ?? '');
    addUserClassSection(prefs.getString('class_section') ?? '');
    addUserFCMDeviceToken(prefs.getString('fcm_tocken') ?? '');
    addUserStudentName(prefs.getString('student_name') ?? '');
    addUserAdmissionNo(prefs.getString('admission_no') ?? '');
    addUserIsLoggedIn(prefs.getBool('isLoggegIn') ?? false);
    addUserHasMultipleChild(prefs.getBool('hasMultipleChild') ?? false);
    addIsUserImage(prefs.getBool('isUserImage') ?? false);


    // let chek for password change and new device token

    loginApi();

  }

  loginApi()async{
    ApiRespository apiRespository = await ApiRespository(apiClient:Get.find());
    Map<String,dynamic> body = {
      "username" : getLastUserId,
      "password" : getLastUserPwd,
      "deviceToken" : getUserFCMDeviceToken
    };

    var data  = await apiRespository.postApiCallByJson("auth/login", body);


    print("DATA @@@@ ${data.body}");
    //UsersData usersData = UsersData.fromJson(data.body);
    Map<dynamic, dynamic> jsonData = data.body;//json.decode(data.body);
    if(jsonData["status"].toString() == "1")
    {
      UserData usersData = UserData();
      usersData.addLastUserId(getLastUserId);
      usersData.addLastUserPwd(getLastUserPwd);
      usersData.addRole(jsonData["role"].toString());
      usersData.addUserId(jsonData["id"].toString());
      usersData.addAccessToken(jsonData["token"].toString());
      usersData.addSchoolName(jsonData["sch_name"].toString());
      usersData.addCurrency_symbol(jsonData["currency_symbol"].toString());
      usersData.addCurrency_short_name(jsonData["currency_short_name"].toString());
      usersData.addStart_week(jsonData["startWeek"].toString());
      usersData.addStudent_session_id(jsonData["student_session_id"].toString());
      String imgUrl = Constants.imagesUrl + jsonData["image"].toString();
      bool isUserImage = jsonData["image"].toString() == "null" ? false : true;
      usersData.addIsUserImage(isUserImage);
      usersData.addUserImage(imgUrl);
      usersData.addUsername(jsonData["username"].toString());
      Map<String, dynamic> recordData = jsonData["record"];//json.decode(jsonData["record"]);
     return true;

    }
    else
    {

        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Get.toNamed('/s_screen');

      print('login failed:::::::::');
    }

    //print("DATA USING DATA MODEL ${usersData.role}");
    // userData.saveData("userData", usersData);
    //  print("GET USER DATA ${userData.getData("userData",)}");



    // Get.to( AppRoutes.teacherLoginScreen);


  }

}




