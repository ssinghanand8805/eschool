import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:get/get.dart';

import '../presentation/login_screen/models/Faculity.dart';
import '../presentation/login_screen/models/userDataModal.dart';



class ApiClient extends GetConnect implements GetxService {
  late String? token;
  final String appBaseUrl;

  late  Map<String, String> _mainHeader;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 60);}
  UserData userData = Get.put(UserData());

  @override
  void onInit() {
    // add your local storage here to load for every request
    token=  userData.getAccessToken;
    UserData usersData = UserData();
    Faculity? f =  usersData.getFaculity();
   // loadHeader();
    // print("**********${f!.toJson()}");
    // _mainHeader['userID'] = f == null ? "2" : f.id.toString();
    _mainHeader= {
      'token': userData.getAccessToken,
      'Client-Service': "smartschool",
      'Auth-Key': "schoolAdmin@",
      'Staff-Id': f != null ? f.id! : "0",
      'Role': f != null ? f.roles!.roleId! : "0",
      'userID': f != null ? f.id! : "0",
    };

    super.onInit();
  }
loadHeader() async
{
  UserData usersData = UserData();
  print("*************************************");
  Faculity? f = await usersData.getFaculity();
  log(json.encode(f!.toJson()));
  _mainHeader['userID'] = f == null ? "2" : f.id.toString();
  _mainHeader['Staff-Id'] = f == null ? "0" : f.id.toString();
  _mainHeader['Role'] = f != null ? f.roles!.roleId! : "0";
  _mainHeader['userID'] = f != null ? f.id! : "0";



}

  Future<Response> getData(
    String uri,
  ) async {
    await loadHeader();
    print("Api Url  $baseUrl$uri");
    print("Request header $_mainHeader");
    try {
     Response response= await get(uri,headers: _mainHeader);
     return response;
    } catch (e) {
      return  Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postDataFormData(uri,body)async{

    await loadHeader();
    try{
      print("Api Url  $baseUrl$uri");
      print("Request body $body");
      print("token "+ UserData().getAccessToken);

      Response response=await post(uri, body,headers: _mainHeader,contentType: "application/x-www-form-urlencoded");
      print("Response body ${response.body}");
      print("Response body ${response.statusCode}");
      print("Response body ${response.statusText}");
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postDatabyJson(uri,body)async{
    await loadHeader();
    log("Api Url  "+(baseUrl!+uri).toString());
    log("header  ${_mainHeader}");
    log("body  ${body}");


    try{
      Response response=await post(uri, body,headers: _mainHeader ,contentType: 'application/json');
      print("eEEEEEEEEEEEEEEEEEEEEE${response.body}");
      return response;
    }on SocketException{
      return const Response(statusCode: -1,statusText:"No Internet found");
    }
    on TimeoutException{
      return const Response(statusCode: -2,statusText:"Something went wrong ! please try again ");
    }
    catch(e){
      return Response(statusCode: 0,statusText: e.toString());
    }


  }

  Future<Response> postDatabyJsonForLogin(uri,body)async{
   // await loadHeader();
    log("Api Url  "+(baseUrl!+uri).toString());
    log("header  ${_mainHeader}");
    log("body  ${body}");


    try{
      Response response=await post(uri, body,headers: _mainHeader ,contentType: 'application/json');
      print("eEEEEEEEEEEEEEEEEEEEEE${response.body}");
      return response;
    }on SocketException{
      return const Response(statusCode: -1,statusText:"No Internet found");
    }
    on TimeoutException{
      return const Response(statusCode: -2,statusText:"Something went wrong ! please try again ");
    }
    catch(e){
      return Response(statusCode: 0,statusText: e.toString());
    }


  }







}
