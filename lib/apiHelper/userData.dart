

import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:learnladderfaculity/apiHelper/popular_product_repo.dart';
import 'package:learnladderfaculity/presentation/login_screen/models/userDataModal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/login_screen/models/ChatUser.dart';
import '../presentation/login_screen/models/ChatUser.dart';
import '../presentation/login_screen/models/Faculity.dart';
import '../presentation/login_screen/models/ChatUser.dart' as ChatUser;
import '../routes/app_routes.dart';
import 'ChatNotificationService.dart';
import 'Constants.dart';
import 'GlobalData.dart';
import 'package:http/http.dart' as http;

import 'SocketService.dart';


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
  Faculity? cachedFaculity;
  ChatUser.ChatUser? cachedChatUser;


  Future<void> initializeFaculity() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString("faculityData");

    if (jsonString != null) {
      cachedFaculity = Faculity.fromJson(json.decode(jsonString));
    }
    final jsonString2 = prefs.getString("chatUserData");

    if (jsonString2 != null) {
      cachedChatUser = ChatUser.ChatUser.fromJson(json.decode(jsonString2));
      print("_--------${cachedChatUser!.data!.token}");
    }
  }
      void saveFaculity(Faculity user) async {

    userData.write('faculityData', user.toJson()); // Saving the user model as JSON
    print("#@#@#");
    log(json.encode(getFaculity()!.toJson()));
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("faculityData", json.encode(user.toJson()));
    await prefs.setBool('isLoggegIn', true);
    initializeFaculity();
  }

  Future<void> saveChatUserDetails(ChatUser.ChatUser user)
  async {
    print("....Saving Chat User Details");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("chatUserData", json.encode(user.toJson()));
    userData.write('chatUserData', user.toJson());
    cachedChatUser = user;
    await prefs.setBool('isChatFound', true);
    ChatUser.ChatUser? chatUser = user;
    if(chatUser != null)
    {
      final EchoService echoService = Get.put(EchoService());
      echoService.initialize(chatUser!.data!.token!);
      final ChatNotificationService notificationService = Get.put(ChatNotificationService(Get.find()));
      notificationService.listenToUserChannel(chatUser!.data!.user!.id!.toString());

    }
  }
  ChatUser.ChatUser? getChatUser() {
    final json = userData.read('chatUserData');
    print("....Getting chat user details$json");
    if (json != null) {

      var d = json;

      print("CCCCCCCCCCCCCCCCCCCCCHHHHHHHHHHHHHHH@1#${d.runtimeType}");
      return ChatUser.ChatUser.fromJson(d); // Reading the user model from JSON
    }
    print("CCCCCCCCCCCCCCCCCCCCCHHHHHHHHHHHHHHH@2${cachedChatUser!.data!.token}");
    return cachedChatUser;
  }
  Faculity? getFaculity() {
    final json = userData.read('faculityData');
    if (json != null) {
      return Faculity.fromJson(json); // Reading the user model from JSON
    }
    return cachedFaculity;
  }
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
    // if(getLastUserId != "" && getLastUserPwd != "")
    //   {
    //     loginApi();
    //   }
    // else
    //   {
    //
    //   }
    loginApi();

  }



  loginApi() async {
    ApiRespository apiRespository = await ApiRespository(apiClient:Get.find());
    final prefs = await SharedPreferences.getInstance();
    var deviceTokenFromPref = await prefs.getString('currentDeviceToken');
    Map<String, dynamic> body = {
      "username": getLastUserId,
      "password": getLastUserPwd,
      "deviceToken": deviceTokenFromPref
    };

    var data = await apiRespository.postApiCallByJsonForLogin(Constants.authUrl, body);

    print("DATA @@@@ ${data.body}");
    if(data.body is bool) {

      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Get.toNamed('/s_screen');

      print('login failed:::::::::');
      return;
    }
    else
      {
        Faculity fac = Faculity.fromJson(data.body);
        getChatDetail(getLastUserId,'12345678');
        // UserData usersData = UserData();
        saveFaculity(fac);
        if(fac.roles!.roleId.toString() == '7')
        {
          //superadmin found no restriction
          //navigate to dashboard
          Get.toNamed(AppRoutes.formScreen);
        }
        else
        {
          Get.toNamed(AppRoutes.formScreen);
          //check permission wise and navigate to dashboard
        }
      }





  }

  getChatDetail(email,pwd)
  async {
    var request = http.MultipartRequest('POST', Uri.parse('http://13.234.137.77/api/login'));
    request.fields.addAll({
      'email': email,
      'password': pwd
    });

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 ) {
      var res = await response.stream.bytesToString();
      var data = jsonDecode(res) as Map<String, dynamic>;
      ChatUser.ChatUser chatUser = ChatUser.ChatUser.fromJson(data);
      saveChatUserDetails(chatUser);
      print(data);
    }
    else {
      print(response.reasonPhrase);
    }
  }
  // loginApi()async{
  //   ApiRespository apiRespository = await ApiRespository(apiClient:Get.find());
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   // Write all data to SharedPreferences
  //   var deviceTokenFromPref = await prefs.getString('currentDeviceToken');
  //   Map<String,dynamic> body = {
  //     "username" : getLastUserId,
  //     "password" : getLastUserPwd,
  //     "deviceToken" : deviceTokenFromPref
  //   };
  //   print("********************${body}");
  //   var data  = await apiRespository.postApiCallByJson(Constants.authUrl, body);
  //
  //
  //   print("DATA @@@##################ss@ ${data.body}");
  //   //UsersData usersData = UsersData.fromJson(data.body);
  //   if(data.body is bool)
  //     {
  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.clear();
  //       Get.toNamed('/s_screen');
  //
  //       print('login failed:::::::::');
  //       return;
  //     }
  //   Map<dynamic, dynamic> jsonData1 = data.body;//json.decode(data.body);
  //   print(jsonData1);
  //   if(jsonData1["id"] != null)
  //   {
  //     UserData usersData = UserData();
  //     usersData.addLastUserId(getLastUserId);
  //     usersData.addLastUserPwd(getLastUserPwd);
  //     usersData.addRole(jsonData1["role"].toString());
  //     usersData.addUserId(jsonData1["id"].toString());
  //     usersData.addAccessToken(jsonData1["token"].toString());
  //
  //     Map<dynamic, dynamic> jsonData = data.body['record'];
  //     String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  //     usersData.addSchoolName(jsonData["sch_name"].toString());
  //     usersData.addCurrency_symbol(jsonData["currency_symbol"].toString());
  //     usersData.addCurrency_short_name(jsonData["currency_short_name"].toString());
  //     usersData.addStart_week(jsonData["startWeek"].toString());
  //     usersData.addStudent_session_id(jsonData["student_session_id"].toString());
  //     String imgUrl = baseUrlFromPref + jsonData["image"].toString();
  //     bool isUserImage = (jsonData["image"].toString() == "null" || jsonData["image"].toString() == "" || jsonData["image"] == null) ? false : true;
  //     print("**********${jsonData["image"].toString()}");
  //     usersData.addIsUserImage(isUserImage);
  //     usersData.addUserImage(imgUrl);
  //     usersData.addUsername(jsonData["username"].toString());
  //     Map<dynamic, dynamic> recordData = jsonData;//json.decode(jsonData["record"]);
  //     if(jsonData1["role"].toString() == "parent")
  //     {
  //       List<dynamic> childArray = recordData['parent_childs'];
  //       if(childArray.length == 1)
  //       {
  //         usersData.addUserIsLoggedIn(true);
  //         usersData.addUserHasMultipleChild(false);
  //         var firstChild = childArray[0];//json.decode(childArray[0]);
  //         usersData.addUserStudentId(firstChild["student_id"]);
  //         usersData.addUserClassSection(firstChild["class"] + " - " + firstChild["section"]);
  //         usersData.addUserStudentName(firstChild["name"]);
  //         ///navigate here to dashboard
  //        return true;
  //         // Navigator.push(
  //         //   context,
  //         //   MaterialPageRoute(builder: (context) => DashboardScreen()),
  //         // );
  //       }
  //       else
  //       {
  //         List<String> childNameList = [];
  //         List<String> childIdList = [];
  //         List<String> childImageList = [];
  //         List<String> childClassList = [];
  //         for (int i = 0; i<childArray.length; i++) {
  //           String name = childArray[i]["name"];
  //           childNameList.add(name);
  //           String id = childArray[i]["student_id"];
  //           childIdList.add(id);
  //           String image = childArray[i]["image"];
  //           childImageList.add(image);
  //           String clss = childArray[i]["className"] + " - " + childArray[i]["section"];
  //           childClassList.add(clss);
  //         }
  //         usersData.addUserHasMultipleChild(true);
  //         print('child name List:::::::::');
  //         print(childNameList);
  //         print('child name List:::::::::');
  //         /// show Child List here
  //         ///
  //         return true;
  //       }
  //
  //     }
  //     else if(jsonData1["role"] == "student")
  //     {
  //       usersData.addUserIsLoggedIn(true);
  //       usersData.addUserStudentId(recordData["student_id"]);
  //       usersData.addUserClassSection(recordData["className"] + " - " + recordData["section"]);
  //       usersData.addUserAdmissionNo(recordData["admission_no"]);
  //       ///checking for profile lock
  //       Map<String,dynamic> body2 = { "student_id" : usersData.getUserStudentId };
  //       var data  = await apiRespository.postApiCallByJson("webservice/lock_student_panel", body2);
  //       print('start profile lock data:::::::::');
  //       print(data);
  //       print('end profile lock data:::::::::');
  //       usersData.saveAllDataToSharedPreferences();
  //     }
  //
  //     update();
  //    return true;
  //
  //   }
  //   else
  //   {
  //
  //       final prefs = await SharedPreferences.getInstance();
  //       prefs.clear();
  //       Get.toNamed('/s_screen');
  //
  //     print('login failed:::::::::');
  //   }
  //
  //   //print("DATA USING DATA MODEL ${usersData.role}");
  //   // userData.saveData("userData", usersData);
  //   //  print("GET USER DATA ${userData.getData("userData",)}");
  //
  //
  //
  //   // Get.to( AppRoutes.teacherLoginScreen);
  //
  //
  // }

}




