import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../common_widgets/custom_loader.dart';

import 'event_controller.dart';

class  EventView extends GetView< EventController> {
  EventView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Event',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder<EventController>(
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
                          hint: 'Search.... ', title: '',
                          onChanged: (val) {
                            // controller.searchContentType(val);
                            // controller.update();
                          },
                        ),

                      ),
                      SizedBox(height: 8),

                      Expanded(
                        child: GetBuilder<EventController>(
                          builder: (controller) {
                            if (controller.eventModalList.value.data == null ||
                                controller.eventModalList.value.data!.listResult!.isEmpty) {
                              return Center(child: CustomLoader());
                            }

                            return GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two items per row
                                crossAxisSpacing: 10.0, // Space between columns
                                mainAxisSpacing: 10.0, // Space between rows
                                childAspectRatio: 0.75, // Adjust height-to-width ratio
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              itemCount: controller.eventModalList.value.data!.listResult!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final event = controller
                                    .eventModalList.value.data!.listResult![index];
                                return   Card(
                                  elevation: 2.0,
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Title: ${event.title}',
                                              style: theme.textTheme.bodySmall),
                                          SizedBox(height: 8),
                                          Text('Date: ${event.date}',
                                              style: theme.textTheme.bodySmall),
                                          // SizedBox(height: 8),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Html(data: 'Venue: ${event.description}',
                                              style: {
                                                "html": Style(
                                                  fontSize: FontSize.small,
                                                  //color: Colors.black54,
                                                  maxLines: 2,
                                                  textOverflow: TextOverflow.ellipsis,
                                                ),
                                              },
                                                ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                    Icons.edit, color: Colors.green,),
                                                onPressed: () {
                                                  // addEditContents(context);
                                                },
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete,color: Colors.red,),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          "Confirm Delete",
                                                          style: theme.textTheme.bodyLarge,
                                                        ),
                                                        content: Text(
                                                          "Are you sure you want to delete this subject? This action cannot be undone.",
                                                          style: theme.textTheme.bodySmall,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: Text("Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              controller.deleteEvent(context,
                                                                  event.id); // Perform delete
                                                              Navigator.of(context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: Text(
                                                              "Delete",
                                                              style:
                                                              TextStyle(color: Colors.red),
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
                                );
                              },
                            );
                          },
                        ),
                      ),



                    ],
                  );
                }
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEvents(context);
        },
        tooltip: 'Add Item',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

    );
  }

  void addEvents(BuildContext context) {
    showCustomBottomSheet(context: context,
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

            CustomTextField(
              controller: controller.venueC,
              hint: 'Venue',
              title: 'Venue',
            ),
            const SizedBox(height: 5),
            DatePickerTextField(
                controller: controller.eventStartDate.value,
                title: 'Event Start',
                onDateSelected: (date) async {
                  controller.eventStartDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),
            const SizedBox(height: 5),
            DatePickerTextField(
                controller: controller.eventEndDate.value,
                title: 'Event End',
                onDateSelected: (date) async {
                  controller.eventEndDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),
            const SizedBox(height: 12),
            InkWell(
              onTap: (){
                Get.toNamed('/media_manager', arguments: {
                  'callback': (String result) {
                    print('Callback executed with result: $result');
                    controller.HtmlController.value.insertNetworkImage(result);
                  }
                });
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.green.shade200
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file,color: Colors.green),
                    Text("Add Media",style: TextStyle(color: Colors.green),),
                  ],
                ),

              ),
            ),
            const SizedBox(height: 5),

            SizedBox(
              height: 300,
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