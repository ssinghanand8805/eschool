import 'dart:io';

import 'package:flutter/cupertino.dart';
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

class DailyCollectionView extends GetView<DailyCollectionController> {
  DailyCollectionView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Daily Collection Reports',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder<DailyCollectionController>(
          init: controller,
          builder: (_) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DatePickerTextField(
                              controller: controller.fromDate.value,
                              title: 'From date',
                              onDateSelected: (date) async {
                                controller.fromDate.value.text =
                                    await GlobalData()
                                        .ConvertToSchoolDateTimeFormat(date);
                              }),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DatePickerTextField(
                              controller: controller.toDate.value,
                              title: 'To date',
                              onDateSelected: (date) async {
                                controller.toDate.value.text =
                                    await GlobalData()
                                        .ConvertToSchoolDateTimeFormat(date);
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: MyButton(
                        width: 100,
                        title: 'Search',

                        color: Colors.green,
                        onPress: () {
                          controller.initializeData();
                          //Get.back();
                        },
                      ),
                    ),
                    FutureBuilder(
                        future: controller.fetchDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return CustomLoader();
                          }
                          if (controller
                                      .filteredContentTypeList.value.feesData ==
                                  null ||
                              controller.filteredContentTypeList.value.feesData!
                                      .length <=
                                  0) {
                            return Container(
                              child: Lottie.asset(
                                  "assets/images/no_data_found.json"),
                            );
                          }
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: CustomTextField(
                                  controller: controller.searchC,
                                  hint: 'Search.... ',
                                  title: '',
                                  onChanged: (val) {
                                    controller.searchContentType(val);
                                    controller.update();
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              ListView.builder(
                                 shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.filteredContentTypeList
                                      .value.feesData!.length,
                                  itemBuilder: (context, index) {
                                    FeesData entry = controller
                                        .filteredContentTypeList
                                        .value
                                        .feesData![index];
                                    return Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      shadowColor: Colors.grey.shade300,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.green.shade100,
                                              Colors.green.shade50,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade200,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Header Row: Date and Transaction Info
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Date:',
                                                  style: theme.textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                Text(
                                                  '${entry.txn?.date ?? 'N/A'}',
                                                  style: theme.textTheme.bodySmall?.copyWith(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            Divider(color: Colors.grey.shade300, thickness: 1),

                                            // Details Row
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                _buildTransactionDetail(
                                                  'Transactions',
                                                  '${entry.txn?.count ?? '0'}',
                                                  Colors.blue,
                                                ),
                                                _buildTransactionDetail(
                                                  'Amount',
                                                  '\$${entry.txn?.amt ?? '0.00'}',
                                                  Colors.green,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                  }),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }
  Widget _buildTransactionDetail(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

}
