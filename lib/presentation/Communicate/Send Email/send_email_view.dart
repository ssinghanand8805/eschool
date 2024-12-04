import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/Communicate/Send%20Email/send_email_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customHtmlEditor.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../common_widgets/CommonUserSelection.dart';
import '../../common_widgets/controller/CommonUserSelectionController.dart';

class SendEmailView extends GetView<SendEmailController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CommonUserSelectionController());

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Send Email',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 5
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => MyCustomSD(
                  listToSearch: controller.bookList.value,
                  borderColor: Colors.grey,
                  valFrom: 'title',
                  labelText: "Select Email Template",
                  label: "Select Email Template",
                  onChanged: (val) {

                    controller.selectedSmsTemplate.value = val;
                    controller.titleC.value.text = val['title'];
                    controller.messageC.value.text = val['message'];
                  })),
              CustomTextField(
                  controller: controller.titleC.value,
                  hint: "Title",
                  title: 'Title'),
              SizedBox(
                height: 15,
              ),
              Text(
                "Attachment",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  _showImagePicker(context);
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
                        "Drag and drop a file here or click",
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add spacing
              Obx(() {
                return controller.selectedImageName.value != null
                    ? Stack(
                        children: [
                          Container(
                            height: 100,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade200),
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(
                                    controller.selectedImageName.value!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                controller
                                    .clearImage(); // Clear the image using a controller method
                              },
                              child: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                        ],
                      )
                    : SizedBox();
              }),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: controller.messageC.value,
                maxLine: 5,
                title: 'Message',
                hint: 'Message......',
              ),
              SizedBox(
                height: 10,
              ),
              CommonUserSelection(),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MyButton(
                    width: 100,
                    title: 'Send Email',
                    textStyle: TextStyle(fontSize: 14, color: Colors.white),
                    color: Colors.green,
                    onPress: () {

                      controller.sendEmail();

                    },
                  ),
                ),
              ),
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
      controller.selectedImageName.value = File(pickedFile.path);
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
