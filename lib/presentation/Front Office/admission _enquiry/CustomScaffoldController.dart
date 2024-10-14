import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../widgets/alert_dialogue.dart';
import 'enquiry_data_modal.dart';

class CustomScaffoldController extends GetxController {



  late Map<String, RxString> chipData;


  @override
  void onInit()  {
    super.onInit();


  }
  void watchRxStringVariables(Map<String, RxString> rxStringMap) {

    rxStringMap.forEach((key, rxString) {
      ever(rxString, (value) {
        updateChipDataListC = {key:  value.toString()};
        print('$key changed to: $value');
      });
    });
  }
 Map<String, RxString> get getChipDataList => chipData;
  set updateChipDataList( val){
    chipData = val;
    print(chipData);
    update();
  }

  set updateChipDataListC(Map<String, String> newData) {
    bool keyExists = false;

    // Loop through the list to check if the key exists

      if (chipData.containsKey(newData.keys.first)) {
        // If key exists, update its value
        chipData[newData.keys.first]!.value = newData.values.first;
        keyExists = true;
      }


    // If key doesn't exist, add the new key-value pair to the list
    if (!keyExists) {
    //  chipData.add(newData);
    }

    // Print chipData for debugging purposes
    print(chipData);

    // Trigger UI update
    update();
  }

}
