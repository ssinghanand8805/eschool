import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:learnladderfaculity/apiHelper/userData.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/login_screen/models/ChatUser.dart';

import '../presentation/login_screen/models/Faculity.dart';
import '../presentation/login_screen/models/userDataModal.dart';



class chatApiClient extends GetConnect implements GetxService {
  late String? token;
  final String appBaseUrl;

  late  Map<String, String> _mainHeader;

  chatApiClient({required this.appBaseUrl}) {
    baseUrl = "http://13.234.137.77/api/";
    timeout = const Duration(seconds: 60);}
  UserData userData = Get.put(UserData());

  @override
  void onInit() {
    // add your local storage here to load for every request

    UserData usersData = UserData();
    Faculity? f = usersData.getFaculity();
    ChatUser? chatUser = usersData.getChatUser();
    if (chatUser != null)
  {
    token=  chatUser.data!.token;//f!.chatAccessToken;
  }
    else
      {
        token=  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiOTdiNDUzY2UzMGQ4ZjY2NjYzNDBjNzljZTllYjkyODVmYTAyMzZhNGM3OTBkZTZjMTUwZmZjMzhhMDI0Mjk3MmUyYmMxNzVkMDIyY2UzNzkiLCJpYXQiOjE3MzE5MDY3MjUuMjk4MjgsIm5iZiI6MTczMTkwNjcyNS4yOTgyODMsImV4cCI6MTc2MzQ0MjcyNS4yOTM4NjYsInN1YiI6IjIiLCJzY29wZXMiOltdfQ.SxhtLnW3-4PE0v4RjT9sltd_xAXRzGFrUeNtArHzAaPNFkmGBX5vM06GaXL2N-CO2nNBPM_LeOudV2HgVfLT-MEqh8jbDNpUmlXwkrHAXHVCAsYVVcGYJ-V2bCSXpPVBcPXX_cxeZ2HtU4izXWUe8_-Go_WPnl9MLx0kQF4srIwFR0J3XmtDI4EiUdqu1oYyENzOZ6sGPw2F4L7VpZdZey0e_WtoHZfpRgmD4dvUxvDmepj9uoPYG94m_TimnmOz_nHW3v9PPk3Kq-kn4hqOK7BeBvYQNBnNOBHTuC4U3L0HP_FwrtBsnZ9TZH4mTl3Zo26fNO6AJuIQpXe6kA0ZNkHWSaTYD7u_JAarL-XdfAZOjAsqX0fCBmcYeHi_Kxw3rafiVKGGGGGtyLRnjmtZCvsH89JK7zJeCH1IyScG0VS6SnFF8-37Z8SgZGh-aMECdgvMSs2s8f1HbKH04_Lge9VqbWjMMRGCUxk7mrfX5AuW1OMqpCEJMVSY4qNyND0_PPAh_2HXaE4KpvRc6Fek3RQWWLZY5uoW1hCO2o6o4lwzsksLg_ZsKmGnQrRKjBNDVEVhcypXK7mDoGIbHe07dtMG_wZqWaXuuyJhk7JEW19ZeqZe_ThsKaChQywBqclPk3TML5GT4SsHnlBrMm1VCBDHSthD6l229CC_kc0l_eY";//f!.chatAccessToken;
      }

    // _mainHeader['userID'] = f == null ? "2" : f.id.toString();
    _mainHeader= {
      'token': userData.getAccessToken,
      'Client-Service': "smartschool",
      'Auth-Key': "schoolAdmin@",
      'Staff-Id': f != null ? f.id! : "0",
      'Role': f != null ? f.roles!.roleId! : "0",
      'userID': f != null ? f.id! : "0",
      'Authorization': 'Bearer $token',
    };

    super.onInit();
  }
loadHeader() async
{
  UserData usersData = UserData();
  Faculity? f = await usersData.getFaculity();
  _mainHeader['userID'] = f == null ? "2" : f.id.toString();


}

  Future<Response> getData(
    String uri,
  ) async {

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
