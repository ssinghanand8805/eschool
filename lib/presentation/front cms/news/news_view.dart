import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/presentation/front%20cms/event/event_controller.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import 'package:lottie/lottie.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../common_widgets/custom_loader.dart';

import 'news_controller.dart';

class NewsView extends GetView<NewsController> {
  NewsView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'News',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder<NewsController>(
          init: controller,
          builder: (_) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: CustomTextField(
                          controller: controller.searchC,
                          hint: 'Search.... ',
                          title: '',
                          onChanged: (val) {
                            // controller.searchContentType(val);
                            // controller.update();
                          },
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: GetBuilder<NewsController>(
                          builder: (controller) {
                            if (controller.noticeModalList.value.data == null ||
                                controller.noticeModalList.value.data!
                                    .listResult!.isEmpty) {
                              return Center(child: Lottie.asset(
                                  "assets/images/no_data_found.json"));
                            }

                            return ListView.builder(
                              itemCount: controller.noticeModalList.value.data!
                                  .listResult!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final event = controller.noticeModalList.value
                                    .data!.listResult![index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Card(
                                    elevation: 2.0,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Title: ${event.title}',
                                                style:
                                                    theme.textTheme.bodySmall),
                                            SizedBox(height: 8),
                                            Text('URL: ${event.url}',
                                                style:
                                                    theme.textTheme.bodySmall),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                            "Confirm Delete",
                                                            style: theme
                                                                .textTheme
                                                                .bodyLarge,
                                                          ),
                                                          content: Text(
                                                            "Are you sure you want to delete this Gallery Image? This action cannot be undone.",
                                                            style: theme
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                          actions: [
                                                            IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              icon: Icon(
                                                                Icons.cancel,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed: () {
                                                                controller
                                                                    .deleteEvent(
                                                                        context,
                                                                        event
                                                                            .id); // Perform delete
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNews(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addNews(BuildContext context) {

    controller.featureImage.value = '';
    controller.titleC.clear();
    showCustomBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Book Title
            CustomTextField(
              controller: controller.titleC,
              hint: 'Title',
              title: 'Title',
            ),
            const SizedBox(height: 5),

            DatePickerTextField(
                controller: controller.dateC.value,
                title: 'Date',
                onDateSelected: (date) async {
                  controller.dateC.value.text =
                      await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),
            const SizedBox(height: 12),
            Obx(
               () =>  Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed('/media_manager', arguments: {
                        'callback': (Map<String,dynamic> result) {
                          print('Callback executed with result: $result');
                          controller.featureImage.value = result['image'];
                          controller.update();
                        }
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.green.shade200)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.upload_file, color: Colors.green),
                          Text(
                            "Add Media",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  controller.featureImage.value  != "" ?  Stack(
                    children: [
                       Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(controller.featureImage.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            controller.featureImage.value = "";
                            controller.update();
                          },
                          child: Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ],
                  ) : SizedBox()
                ],
              ),
            ),
            const SizedBox(height: 5),

            SizedBox(
              height: 400,
              child: HtmlEditor(
                htmlToolbarOptions: HtmlToolbarOptions(
                    toolbarItemHeight: 35,
                    toolbarType: ToolbarType.nativeGrid,
                    textStyle: theme.textTheme.titleMedium,
                    defaultToolbarButtons: [
                      const StyleButtons(),
                      const FontButtons(
                          clearAll: true,
                          strikethrough: false,
                          subscript: false,
                          superscript: false)
                    ]),
                controller: controller.HtmlController.value,
                //required
                htmlEditorOptions: const HtmlEditorOptions(
                  hint: "Please enter ...",
                  shouldEnsureVisible: true,
                  autoAdjustHeight: true,
                  adjustHeightForKeyboard: true,
                ),
                otherOptions: const OtherOptions(),
              ),
            ),
            //  const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Implement save functionality
                  controller.addNews(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
