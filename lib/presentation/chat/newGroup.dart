import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import 'controller/GroupController.dart';



class NewGroupPage extends GetView<GroupController> {

  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage(context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // rounded corners
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Choose Image Source',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    'Take a Photo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {

                      controller.imageFile.value = File(pickedFile.path);
                      controller.update();
                    }
                  },
                ),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      controller.imageFile.value = File(pickedFile.path);
                      controller.update();
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'New Group',
          style: theme.textTheme.bodyMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: controller.txtGrpName.value,
                hint: 'Group Name',
                title: 'Group Name',
              ),
              SizedBox(height: 20),

              // Group Icon
              Text(
                'Group Icon:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:  controller.imageFile.value != null
                        ? FileImage(controller.imageFile.value!)
                        : AssetImage('assets/images/img.png') as ImageProvider,
                    backgroundColor: Colors.grey[200],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () { _pickImage(context) ; },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'Choose your file',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Group Type
              Text(
                'Group Type:*',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Open',
                      groupValue: controller.groupType.value,
                      onChanged: (value) {
                        controller.groupType.value = value.toString();
                        controller.update();
                      },
                      title: Row(
                        children: [
                          Text('Open'),
                          SizedBox(width: 4),
                          Icon(Icons.info_outline, size: 14),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Close',
                      groupValue: controller.groupType.value,
                      onChanged: (value) {
                        controller.groupType.value = value.toString();
                        controller.update();
                      },
                      title: Row(
                        children: [
                          Text('Close'),
                          SizedBox(width: 4),
                          Icon(Icons.info_outline, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Privacy
              Text(
                'Privacy:*',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Public',
                      groupValue: controller.privacy.value,
                      onChanged: (value) {
                        controller.privacy.value = value.toString();
                        controller.update();
                      },
                      title: Row(
                        children: [
                          Text('Public'),
                          SizedBox(width: 4),
                          Icon(Icons.info_outline, size: 14),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Private',
                      groupValue: controller.privacy.value,
                      onChanged: (value) {
                        controller.privacy.value = value.toString();
                        controller.update();
                      },
                      title: Row(
                        children: [
                          Text('Private'),
                          SizedBox(width: 4),
                          Icon(Icons.info_outline, size: 14),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(3),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () async {
                      await controller.createGroup();
                      Navigator.pop(context);
                      },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
