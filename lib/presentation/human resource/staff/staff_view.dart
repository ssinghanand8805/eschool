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
          style: theme.textTheme.bodyMedium,
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
                  return Padding(
                    padding: const  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    child: Column(
                      children: [
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
                        CustomTextField(
                          controller: controller.searchC,
                          hint: 'Search.... ', title: 'Search',
                          onChanged: (val) {
                            controller.searchContentType(val);
                            controller.update();
                          },
                        ),
                        SizedBox(height: 8),
                        Expanded(
                          child: GetBuilder<StaffController>(
                            builder: (controller) {
                              if (controller.filteredContentTypeList.value.data == null ||
                                  controller.filteredContentTypeList.value.data!.resultlist!.isEmpty) {
                                return Center(child: CustomLoader());
                              }

                              return ListView.builder(
                                itemCount:
                                controller.filteredContentTypeList.value.data!.resultlist!.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  final staff = controller
                                      .filteredContentTypeList.value.data!.resultlist![index];
                                  return    Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10),
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
                                              Text('Staff Id: ${staff.id}',
                                                  style: theme.textTheme.bodySmall),
                                              SizedBox(height: 8),
                                              Text('Name: ${staff.name}',
                                                  style: theme.textTheme.bodySmall),
                                              SizedBox(height: 8),
                                              Text('Role: ${staff.roleId}',
                                                  style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                              Text('Department: ${staff.department}',
                                                  style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                              Text('Designation: ${staff.designation}',
                                                  style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                              Text('Mobile No.: ${staff.contactNo}',
                                                  style: theme.textTheme.bodySmall),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.list, color: Colors.blue ),
                                                    onPressed: () {
                                                      addStaffs(context);
                                                    },
                                                  ), IconButton(
                                                    icon: Icon(
                                                        Icons.edit, color: Colors.green ),
                                                    onPressed: () {
                                                      addStaffs(context);
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