import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';

import 'staff_controller.dart';

class StaffView extends GetView< StaffController> {
  StaffView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Staff',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<StaffController>(
          init: controller,
          builder: (_) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                      child: Column(
                        children: [
                          MyCustomSD(
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch:[],
                            valFrom: "className",
                            label: 'Class',
                            labelText: 'Class',
                            onChanged: (val) {
                            },
                          ),
                          CustomTextField(
                            controller: controller.searchC,
                            hint: 'Search.... ', title: 'Search',
                            onChanged: (val) {
                              controller.searchContentType(val);
                              controller.update();
                            },
                          ),
                          SizedBox(height: 8),
                          Column(
                            children: controller.filteredContentTypeList.value
                                .data!.map((entry) {
                              return Card(
                                elevation: 1,
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
                                      Text('Staff Id: ${"entry.bookType"}',
                                          style: theme.textTheme.bodySmall),
                                      SizedBox(height: 8),
                                      Text('Name: ${"entry.bookTitle"}',
                                          style: theme.textTheme.bodySmall),
                                      SizedBox(height: 8),
                                      Text('Role: ${"entry.bookTitle"}',
                                          style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                      Text('Department: ${"entry.bookTitle"}',
                                          style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                      Text('Designation: ${"entry.bookTitle"}',
                                          style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                      Text('Mobile No.: ${"entry.bookTitle"}',
                                          style: theme.textTheme.bodySmall),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                                Icons.view_list_outlined, size: 15),
                                            onPressed: () {
                                             // addEditContents(context);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit, size: 15),
                                            onPressed: () {

                                            },
                                          ),
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
                    ),
                  );
                }
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addStaffs(context);
        },
        tooltip: 'Add Staff',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

    );
  }

  void addStaffs(BuildContext context) {
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
                controller: controller.staffIdC,
                hint: 'Staff ID',
                title: 'Staff ID',

              ),
              MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:[],
                valFrom: "className",
                label: 'Role',
                labelText: 'Role',
                onChanged: (val) {
                },
              ),
              MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:[],
                valFrom: "className",
                label: 'Designation',
                labelText: 'Designation',
                onChanged: (val) {
                },
              ),
              MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:[],
                valFrom: "className",
                label: 'Department',
                labelText: 'Department',
                onChanged: (val) {
                },
              ),
              CustomTextField(
                controller: controller.firstNameC,
                hint: 'First Name',
                title: 'First Name',

              ),
              CustomTextField(
                controller: controller.lastNameC,
                hint: 'Last Name',
                title: 'Last Name',
              ),
              CustomTextField(
                controller: controller.fatherNameC,
                hint: 'Father Name',
                title: 'Father Name',
              ),
              CustomTextField(
                controller: controller.motherNameC,
                hint: 'Mother Name',
                title: 'Mother Name',
              ),
              CustomTextField(
                controller: controller.emailC,
                hint: 'Email (Login Username)',
                title: 'Email',

              ),
              CustomTextField(
                controller: controller.dateOfBirthC,
                hint: 'Date of Birth',
                title: 'Date of Birth',

              ),
              CustomTextField(
                controller: controller.dateOfJoiningC,
                hint: 'Date of Joining',
                title: 'Date of Joining',
              ),
              CustomTextField(
                controller: controller.phoneC,
                hint: 'Phone',
                title: 'Phone',
              ),
              CustomTextField(
                controller: controller.emergencyContactC,
                hint: 'Emergency Contact Number',
                title: 'Emergency Contact',
              ),
              CustomTextField(
                controller: controller.qualificationC,
                hint: 'Qualification',
                title: 'Qualification',
              ),
              CustomTextField(
                controller: controller.workExperienceC,
                hint: 'Work Experience',
                title: 'Work Experience',
              ),
              CustomTextField(
                controller: controller.addressC,
                hint: 'Address',
                title: 'Address',
                maxLine: 3,

              ),
              CustomTextField(
                controller: controller.permanentAddressC,
                hint: 'Permanent Address',
                title: 'Permanent Address',
                maxLine: 3,

              ),

              CustomTextField(
                controller: controller.noteC,
                hint: 'Note',
                title: 'Note',
                maxLine: 3,

              ),
              const SizedBox(height: 10),
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

              const SizedBox(height: 24),

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