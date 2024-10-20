

import 'dart:convert';

import 'package:lerno/apiHelper/popular_product_repo.dart';
import 'package:lerno/presentation/login_screen/models/userDataModal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_routes.dart';
import 'Constants.dart';
import 'GlobalData.dart';



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
  String get getDateFormat => userData.read('date_format') ?? "";
  String get getTimeZone => userData.read('timezone') ?? "";

  String get getStudentClassID => userData.read('student_class_id') ?? "";
  String get getStudentSectionID => userData.read('student_section_id') ?? "";
  String get getStudentParentID => userData.read('student_parent_id') ?? "";


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

  addUserStudentClassId(String val) {userData.write('student_class_id', val);}
  addUserStudentSectionId(String val) {userData.write('student_section_id', val);}
  addUserStudentParentId(String val) {userData.write('student_parent_id', val);}

  addUserClassSection(String val) {userData.write('class_section', val);}
  addUserAdmissionNo(String val) {userData.write('admission_no', val);}
  addUserIsLoggedIn(bool val) {userData.write('isLoggegIn', val);}
  addUserHasMultipleChild(bool val) {userData.write('hasMultipleChild', val);}
  addIsUserImage(bool val) {userData.write('isUserImage', val);}
  addDateFormat(String val) {userData.write('date_format', val);}
  addTimeZone(String val) {userData.write('timezone', val);}


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
    await prefs.setString('date_format', getDateFormat);
    await prefs.setString('timezone', getTimeZone);


    await prefs.setString('student_class_id', getStudentClassID);
    await prefs.setString('student_section_id', getStudentSectionID);
    await prefs.setString('student_parent_id', getStudentParentID);
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
    addDateFormat(prefs.getString('date_format') ?? '');
    addTimeZone(prefs.getString('timezone') ?? '');

    addUserStudentClassId(prefs.getString('student_class_id') ?? '');
    addUserStudentSectionId(prefs.getString('student_section_id') ?? '');
    addUserStudentParentId(prefs.getString('student_parent_id') ?? '');

    // let chek for password change and new device token

    loginApi();

  }

  loginApi()async{
    ApiRespository apiRespository = await ApiRespository(apiClient:Get.find());
    final prefs = await SharedPreferences.getInstance();

    // Write all data to SharedPreferences
    var deviceTokenFromPref = await prefs.getString('currentDeviceToken');
    Map<String,dynamic> body = {
      "username" : getLastUserId,
      "password" : getLastUserPwd,
      "deviceToken" : deviceTokenFromPref
    };
    print("********************${body}");
    var data  = await apiRespository.postApiCallByJson(Constants.authUrl, body);


    print("DATA @@@##################ss@ ${data.body}");
    //UsersData usersData = UsersData.fromJson(data.body);
    Map<dynamic, dynamic> jsonData1 = data.body;//json.decode(data.body);
    if(jsonData1["status"].toString() == "1")
    {
      UserData usersData = UserData();
      usersData.addLastUserId(getLastUserId);
      usersData.addLastUserPwd(getLastUserPwd);
      usersData.addRole(jsonData1["role"].toString());
      usersData.addUserId(jsonData1["id"].toString());
      usersData.addAccessToken(jsonData1["token"].toString());

      Map<dynamic, dynamic> jsonData = data.body['record'];
      String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
      usersData.addSchoolName(jsonData["sch_name"].toString());
      usersData.addCurrency_symbol(jsonData["currency_symbol"].toString());
      usersData.addCurrency_short_name(jsonData["currency_short_name"].toString());
      usersData.addStart_week(jsonData["startWeek"].toString());
      usersData.addStudent_session_id(jsonData["student_session_id"].toString());
      String imgUrl = baseUrlFromPref + jsonData["image"].toString();
      bool isUserImage = (jsonData["image"].toString() == "null" || jsonData["image"].toString() == "" || jsonData["image"] == null) ? false : true;
      print("**********${jsonData["image"].toString()}");
      usersData.addIsUserImage(isUserImage);
      usersData.addUserImage(imgUrl);
      usersData.addUsername(jsonData["username"].toString());
      usersData.addDateFormat(jsonData["date_format"].toString());
      usersData.addTimeZone(jsonData["timezone"].toString());
      Map<dynamic, dynamic> recordData = jsonData;//json.decode(jsonData["record"]);
      if(jsonData1["role"].toString() == "parent")
      {
        List<dynamic> childArray = recordData['parent_childs'];
        if(childArray.length == 1)
        {
          usersData.addUserIsLoggedIn(true);
          usersData.addUserHasMultipleChild(false);
          var firstChild = childArray[0];//json.decode(childArray[0]);
          usersData.addUserStudentId(firstChild["student_id"]);
          usersData.addUserStudentClassId(firstChild["class_id"]); //class_id
          usersData.addUserStudentSectionId(firstChild["section_id"]); //section_id
          usersData.addUserStudentParentId(recordData["id"]); //user_parent_id
          usersData.addStudent_session_id(firstChild["student_session_id"].toString());
          usersData.addUserClassSection(firstChild["class"] + " - " + firstChild["section"]);
          usersData.addUserStudentName(firstChild["name"]);

          usersData.saveAllDataToSharedPreferences();
          ///navigate here to dashboard
         return true;
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DashboardScreen()),
          // );
        }
        else
        {
          usersData.addUserStudentParentId(recordData["id"]);
          List<String> childNameList = [];
          List<String> childIdList = [];
          List<String> childImageList = [];
          List<String> childClassList = [];
          List<bool> childImagefoundList = [];
          List<String> childSessionIDList = [];

          List<String> childClassIdList = [];
          List<String> childSectionIdList = [];
          for (int i = 0; i<childArray.length; i++) {
            String name = childArray[i]["name"];
            childNameList.add(name);
            String id = childArray[i]["student_id"];
            childIdList.add(id);
            String seid = childArray[i]["student_session_id"] ?? "";
            childSessionIDList.add(seid);

            String classId = childArray[i]["class_id"] ?? "";
            String sectionId = childArray[i]["section_id"] ?? "";
            childClassIdList.add(classId);
            childSectionIdList.add(sectionId);
            bool isUserImage =
            childArray[i]["image"].toString() == "null" ? false : true;
            usersData.addIsUserImage(isUserImage);
            String imgUrl = isUserImage
                ? baseUrlFromPref + childArray[i]["image"].toString()
                : "";
            String image = imgUrl;
            childImagefoundList.add(isUserImage);
            childImageList.add(image);
            String clss = childArray[i]["className"] ?? "" + " - " + childArray[i]["section"];
            childClassList.add(clss);
          }
          usersData.addUserHasMultipleChild(true);
          print('child name List:::::::::');
          print(childNameList);
          print('child name List:::::::::');
          /// show Child List here
          ///
          saveArray("childIdList",childIdList);
          saveArray("childNameList",childNameList);
          saveArray("childImageList",childImageList);
          saveArray("childClassList",childClassList);
          saveArray("childImagefoundList",childImagefoundList);
          saveArray("childSessionIDList",childSessionIDList);
          saveArray("childClassIdList",childClassIdList);
          saveArray("childSectionIdList",childSectionIdList);

          usersData.saveAllDataToSharedPreferences();
          return true;
        }

      }
      else if(jsonData1["role"] == "student")
      {
        usersData.addUserIsLoggedIn(true);
        usersData.addUserStudentId(recordData["student_id"]);
        usersData.addUserClassSection(recordData["className"] + " - " + recordData["section"]);
        usersData.addUserAdmissionNo(recordData["admission_no"]);
        usersData.addUserStudentClassId(recordData["class_id"]); //class_id
        usersData.addUserStudentSectionId(recordData["section_id"]); //section_id
        usersData.addUserStudentParentId(""); //user_parent_id
        usersData.addStudent_session_id(recordData["student_session_id"].toString());
        ///checking for profile lock
        Map<String,dynamic> body2 = { "student_id" : usersData.getUserStudentId };
        var data  = await apiRespository.postApiCallByJson("webservice/lock_student_panel", body2);
        print('start profile lock data:::::::::');
        print(data);
        print('end profile lock data:::::::::');
        usersData.saveAllDataToSharedPreferences();
      }

      update();
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
  Future<bool> saveArray(String name,List<dynamic> array) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(array); // Encode your array to a JSON string
    return prefs.setString(name, encodedData); // Save encoded string
  }
}




