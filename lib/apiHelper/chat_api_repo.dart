


import 'dart:developer';

import 'package:get/get.dart';

import 'api.dart';
import 'chatApi.dart';



class ChatApiRespository extends GetxService {
  final chatApiClient apiClient;

  ChatApiRespository({required this.apiClient});

  Future<Response> getApiCallByJson(getApiEndPoint) async{

    return await apiClient.getData(getApiEndPoint);
  }
 Future<Response> postApiCallByJson(endPoint , body) async{
    log("Api Url  "+(endPoint).toString());
    return await apiClient.postDatabyJson( endPoint, body );
  }
  Future<Response> postApiCallByFormData(endPoint , body) async{
    return await apiClient.postDataFormData( endPoint, body );
  }


}