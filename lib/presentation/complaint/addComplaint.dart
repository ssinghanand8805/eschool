import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lerno/presentation/apply_leave/controller/ApplyLeaveController.dart';
import 'package:lerno/presentation/common_widgets/MainBody.dart';

import '../../core/app_export.dart';
import '../../widgets/customSD.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/complaintController.dart';
import 'model/teacherComplaint.dart';

class AddComplaintPage extends StatefulWidget {
  @override
  _AddComplaintPageState createState() => _AddComplaintPageState();
}

class _AddComplaintPageState extends State<AddComplaintPage> {
  ComplaintController controller = Get.put(ComplaintController());

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
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: "Apply Complaint\nhere!",
        imageUrl: "assets/projectImages/leavepage.jpg",
        AppbarTitle: "Apply Complaint",
        widget: GetBuilder(
            init: controller,
            builder: (context1) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (controller.complaintModelObj.isEmpty) {
                          return Text("No complaints available");
                        }

                        if (!controller.complaintModelObj.contains(controller.selectedComplaint.value)) {
                          controller.selectedComplaint.value = null; // Reset the selected value
                        }
                        return InputDecorator(
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                            ),
                            hintText: "Select a Complaint Type",
                          ),
                          child: DropdownButtonHideUnderline(
                            child: controller.complaintModelObj.value.length > 0 ? DropdownButton<ComplaintType>(
                              value: controller.selectedComplaint.value,
                              items:
                                  controller.complaintModelObj.map((complaint) {
                                return DropdownMenuItem<ComplaintType>(
                                  value: complaint,
                                  child:
                                      Text(complaint.complaintType.toString()),
                                );
                              }).toList(),
                              onChanged: (ComplaintType? newValue) {
                                controller.selectedComplaint.value = newValue;
                              },
                              hint: Text("Select a Complaint Type"),
                            ) : CustomLoader(),
                          ),
                        );
                      }),

                      SizedBox(height: 16.0),
                      Container(
                        height: 55,
                        child: TextField(
                          controller: controller.reasonController.value,
                          decoration: InputDecoration(
                            hintText: 'Complaint Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
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
                      }),
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
                          backgroundColor: Colors.green.shade400,
                        ),
                        onPressed: () {
                          controller.saveData(context);
                        },
                        child: Text("Submit"),
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
