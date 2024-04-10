

import 'package:anand_s_application1/presentation/login_screen/models/userDataModal.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';



class UserData extends GetxController {
  final userData = GetStorage();

  String get getUserToken => userData.read('userToken') ?? '';
  String get getId => userData.read('id') ?? '';
  String get getRole => userData.read('role') ?? '';
  String get getUsername => userData.read('username') ?? '';


  addToken(String val) {userData.write('userToken', val);}
  addId(String val) {userData.write('id', val);}
  addRole(String val) {userData.write('role', val);}
  addUsername(String val) {userData.write('username', val);}


  saveData<T>(String storageKey,T dataModel){
    userData.write(storageKey,dataModel);
  }

  getData<T>(String storageKey){
   return userData.read(storageKey);
  }


}




