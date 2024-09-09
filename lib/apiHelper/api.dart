import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:lerno/apiHelper/userData.dart';
import 'package:get/get.dart';

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
    _mainHeader= {
      'token': userData.getAccessToken
    };

    super.onInit();
  }


  Future<Response> getData(
    String uri,
  ) async {
    _mainHeader={
      'Client-Service': "smartschool",
      'Auth-Key': "schoolAdmin@",
      //UserData().getUserToken
    };
    try {
     Response response= await get(uri,headers: _mainHeader);
     return response;
    } catch (e) {
      return  Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postDataFormData(uri,body)async{
    _mainHeader={
      'Client-Service': "smartschool",
      'Auth-Key': "schoolAdmin@",
      //UserData().getUserToken
    };

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
    log("Api Url  "+(baseUrl!+uri).toString());
    _mainHeader={
      'Client-Service': "smartschool",
      'Auth-Key': "schoolAdmin@",
      //UserData().getUserToken
    };

    try{
      Response response=await post(uri, body,headers: _mainHeader ,contentType: 'application/json');
      return response;
    }on SocketException{
      return const Response(statusCode: 0,statusText:"No Internet found");
    }
    on TimeoutException{
      return const Response(statusCode: 0,statusText:"Something went wrong ! please try again ");
    }
    catch(e){
      return Response(statusCode: 0,statusText: e.toString());
    }


  }







}
