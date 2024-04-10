

import 'package:anand_s_application1/presentation/login_screen/models/userDataModal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



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
  String get getUserStudentName => userData.read('student_name') ?? '';
  String get getUserAdmissionNo => userData.read('admission_no') ?? '';
  bool get getUserIsLoggedIn => userData.read('isLoggegIn') ?? false;
  bool get getUserHasMultipleChild => userData.read('hasMultipleChild') ?? false;


  addAccessToken(String val) {userData.write('accessToken', val);}
  addUserId(String val) {userData.write('userId', val);}
  addRole(String val) {userData.write('role', val);}
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


  saveData<T>(String storageKey,T dataModel){
    userData.write(storageKey,dataModel);
  }

  getData<T>(String storageKey){
   return userData.read(storageKey);
  }


}




