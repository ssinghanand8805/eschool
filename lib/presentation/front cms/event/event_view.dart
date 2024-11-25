import 'dart:io';

import 'package:flutter/material.dart';
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
                              .data!.map((entry) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10),
                              child: Card(
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
                                        Text('Title: ${"entry.bookType"}',
                                            style: theme.textTheme.bodySmall),
                                        SizedBox(height: 8),
                                        Text('Date: ${"entry.bookTitle"}',
                                            style: theme.textTheme.bodySmall),
                                        SizedBox(height: 8),
                                        Text('Venue: ${"entry.description"}',
                                            style: theme.textTheme.bodySmall),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                  Icons.edit, size: 15),
                                              onPressed: () {
                                               // addEditContents(context);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.close, size: 15),
                                              onPressed: () {

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
                          }).toList(),
                        )


                      ],
                    ),
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
      child: Container(
        height: Get.height-150,
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
                  _showImagePicker(context);
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
                      Text("Drag and drop a file here or click",style: TextStyle(color: Colors.green),),
                    ],
                  ),

                ),
              ),
              const SizedBox(height: 5),

              SizedBox(
                height: 150,
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
      ),
    );
  }


  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      controller.pickedFile.value = File(pickedFile.path);
      controller.update();
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Pick from Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Take a Picture'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}