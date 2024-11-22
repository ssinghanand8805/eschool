import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import 'package:lottie/lottie.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';

import 'balance_fee_controller.dart';

class  BalanceFeeView extends GetView< BalanceFeeController> {
  BalanceFeeView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Balance Fee Reports',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<BalanceFeeController>(
          init: controller,
          builder: (_) {
            return Column(

              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => controller.commonApiController.isClassLoading.value ?  Expanded(child: Material(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text("Class"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )) :
                    Expanded(
                      child: MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch:
                        controller.commonApiController.classListModelMap.value,
                        valFrom: "className",
                        label: 'Class',
                        labelText: 'Class',
                        initialValue: [
                          {
                            'parameter': 'id',
                            'value': controller.commonApiController.selectedClassId!
                          }
                        ],
                        onChanged: (val) {
                          if (controller.commonApiController.classListModelMap.value
                              .length >
                              0) {
                            print("5555555555555");

                            controller.commonApiController.selectedClassId.value =
                                val['id'].toString();
                            controller.commonApiController.selectedClassName.value =
                                val['className'].toString();
                            // controller.selectedClassName.value =
                            //     val['className'].toString();
                            controller.commonApiController.update();
                            controller.commonApiController.getSectionList();
                          }
                        },
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Obx(() => controller.commonApiController.isSectionLoading.value ?
                    Expanded(child: Material(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text("Section"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )):
                    Expanded(
                      child: MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller
                            .commonApiController.sectionListModelMap.value,
                        valFrom: "section",
                        label: 'Section',
                        labelText: 'Section',
                        initialValue: [
                          {
                            'parameter': 'id',
                            'value':
                            controller.commonApiController.selectedSectionId!
                          }
                        ],
                        onChanged: (val) {
                          print(val);
                          if (controller.commonApiController.sectionListModelMap
                              .value.length >
                              0) {
                            controller.commonApiController.selectedSectionId.value =
                                val['section_id'].toString();
                            controller.commonApiController.selectedSectionName
                                .value = val['section'].toString();
                            // controller.selectedSectionName.value =
                            //     val['section'].toString();
                            controller.commonApiController.update();
                          }
                        },
                      ),
                    )),
                  ],
                ),
                Row(children: [
                  Expanded(
                    child: MyCustomSD(
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: [{'id':'all','name':'All'},{'id':'balance','name':'Balance'},{'id':'paid','name':'No Balance'}],
                      valFrom: "name",
                      label: 'Seacrh Type',
                      labelText: 'Seacrh Type',
                      initialValue: [
                        {
                          'parameter': 'id',
                          'value':controller.selectedSearchType.value
                        }
                      ],
                      onChanged: (val) {
                        print(val);
                        controller.selectedSearchType.value = val['id'].toString();
                      },
                    ),
                  ),
                  Expanded(
                    child: MyButton(
                      width: 100,
                      title: 'Search',
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                      color: Colors.green.shade100,
                      onPress: () {
                        controller.initializeData();
                        Get.back();
                      },
                    ),
                  )
                ],),
                FutureBuilder(
                    future: controller.fetchDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return CustomLoader();
                      }
                      if(controller.filteredContentTypeList.value
                          .studentDueFee == null || controller.filteredContentTypeList.value
                          .studentDueFee!.length <= 0)
                        {
                          return Container(
                            child: Lottie.asset(
                                "assets/images/no_data_found.json"),
                          );
                        }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextField(
                                controller: controller.searchC,
                                hint: 'Search.... ', title: '',
                                onChanged: (val) {
                                  controller.searchContentType(val);
                                  controller.update();
                                },
                              ),

                            ),
                            SizedBox(height: 8),
                            Column(
                              children: controller.filteredContentTypeList.value
                                  .studentDueFee!.map((entry) {
                                return Card(
                                  elevation: 1,
                                  margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // Smoother corners
                                  ),
                                  color: Colors.white,
                                  shadowColor: Colors.green,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Name: ${entry.name} ( ${entry.admissionNo} )',
                                                style: theme.textTheme.bodySmall),
                                            SizedBox(width: 8),
                                            Text('Class: ${entry.className} ( ${entry.section} )',
                                                style: theme.textTheme.bodySmall),
                                          ],
                                        ),


                                        Row(

                                          children: [
                                            Text('Total Fees: ${entry.totalfee}',
                                                style: theme.textTheme.bodySmall),
                                            Text('Paid Fees: ${entry.deposit}',
                                                style: theme.textTheme.bodySmall),
                                            Text('Discount: ${entry.discount}',
                                                style: theme.textTheme.bodySmall),
                                            Text('Fine: ${entry.fine}',
                                                style: theme.textTheme.bodySmall),
                                            Text('Balance: ${entry.balance}',
                                                style: theme.textTheme.bodySmall),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )


                          ],
                        ),
                      );
                    }
                ),
              ],
            );
          }
      ),



    );
  }


}