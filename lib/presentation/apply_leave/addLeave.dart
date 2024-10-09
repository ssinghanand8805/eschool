import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lerno/presentation/apply_leave/controller/ApplyLeaveController.dart';
import 'package:lerno/presentation/common_widgets/MainBody.dart';

import '../../core/app_export.dart';

class LeaveApplicationPage extends StatefulWidget {
  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  ApplyLeaveController controller = Get.put(ApplyLeaveController());

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      controller.image.value = XFile(pickedFile.path);
    }
    if (pickedFile != null) {
      controller.updateImage(pickedFile);
    }

  }

  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: "Add Leave from\nhere!",
        imageUrl: "assets/projectImages/leavepage.jpg",
        AppbarTitle: "Apply Leave",
        widget: GetBuilder(
            init: controller,
            builder: (context1) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: TextField(
                          controller: controller.applyDateController.value,
                          decoration: InputDecoration(
                            hintText: 'Apply Date',
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                          onTap: () async {
                            final date = await getDate();
                            if (date != null) {
                              controller.applyDateController.value.text =
                                  DateFormat('yyyy-MM-dd').format(date);
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: controller.fromDateController.value,
                                decoration: InputDecoration(
                                  hintText: 'From Date',
                                  border: OutlineInputBorder(),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final date = await getDate();
                                  if (date != null) {
                                    controller.fromDateController.value.text =
                                        DateFormat('yyyy-MM-dd').format(date);
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Container(
                              // height: 50,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'To Date',
                                  border: OutlineInputBorder(),
                                ),
                                readOnly: true,
                                controller: controller.toDateController.value,
                                onTap: () async {
                                  final date = await getDate();
                                  if (date != null) {
                                    controller.toDateController.value.text =
                                        DateFormat('yyyy-MM-dd').format(date);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        height: 55,
                        child: TextField(
                          controller: controller.reasonController.value,
                          decoration: InputDecoration(
                            hintText: 'Reason',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      SizedBox(height: 10),
                      Obx(() {
                        return controller.image.value == null
                            ? Image.asset(
                          'assets/projectImages/upload_file.jpg',
                          height: 200,
                          width: 200,
                        )
                            : Image.file(
                          File(controller.image.value!.path),
                          height: 150,
                        );
                      }), // Replace with your asset
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 25),
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          _showImagePicker(context);
                        },
                        child: Text("Choose File"),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60, vertical: 30),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          backgroundColor: theme.primaryColorDark,
                        ),
                        onPressed: () {
                          controller.saveData();
                        },
                        child: Text("Submit",style: TextStyle(color: Colors.white),),
                      ),
                    ],
                  ),
                ),
              );
            }));
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
