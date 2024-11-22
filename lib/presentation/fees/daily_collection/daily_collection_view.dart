import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/presentation/fees/daily_collection/daily_collection_modal.dart';
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

import 'daily_collection_controller.dart';

class  DailyCollectionView extends GetView< DailyCollectionController> {
  DailyCollectionView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Daily Collection Reports',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<DailyCollectionController>(
          init: controller,
          builder: (_) {
            return SingleChildScrollView(
              child: Column(
              
                children: [
              
                  Row(children: [
                    Expanded(
                      child: DatePickerTextField(
                          controller: controller.fromDate.value,
                          title: 'From date',
                          onDateSelected: (date) async {
                            controller.fromDate.value.text =
                            await GlobalData().ConvertToSchoolDateTimeFormat(
                                date);
                          }),
                    ),
                    Expanded(
                      child: DatePickerTextField(
                          controller: controller.toDate.value,
                          title: 'To date',
                          onDateSelected: (date) async {
                            controller.toDate.value.text =
                            await GlobalData().ConvertToSchoolDateTimeFormat(
                                date);
                          }),
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
                          //Get.back();
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
                            .feesData == null || controller.filteredContentTypeList.value
                            .feesData!.length <= 0)
                          {
                            return Container(
                              child: Lottie.asset(
                                  "assets/images/no_data_found.json"),
                            );
                          }
                        return Column(
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
                           ListView.builder(
                  shrinkWrap: true,
                  itemCount:  controller.filteredContentTypeList.value
                      .feesData!.length,
                  itemBuilder: (context, index) {
                    FeesData entry = controller.filteredContentTypeList.value
                        .feesData![index];
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
                    Text('Date: ${entry.txn!.date!}',
                        style: theme.textTheme.bodySmall),
                    SizedBox(width: 8),
                    Text('Total Transaction : ${entry.txn!.count.toString()}',
                        style: theme.textTheme.bodySmall),
                    SizedBox(width: 8),
                    Text('Amount : ${entry.txn!.amt.toString()}',
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              
              
              
              ],
                        ),
                      ),
                    );
              
                        }),

              
                          ],
                        );
                      }
                  ),

                ],
              ),
            );
          }
      ),



    );
  }


}