


import 'dart:developer';

import 'package:get/get.dart';

import 'api.dart';



class ApiRespository extends GetxService {
  final ApiClient apiClient;

  ApiRespository({required this.apiClient});

  Future<Response> getPopularProduct(getApiEndPoint) async{
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