import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';

import 'apply_leave_controller.dart';

class ApplyLeaveView extends GetView< ApplyLeaveController> {
  ApplyLeaveView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Apply Leave',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<ApplyLeaveController>(
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
                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                                    Text('Staff: ${"entry.bookType"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Leave Type : ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                    Text('Leave Date : ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                    Text('Days : ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                    Text('Apply Date : ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),SizedBox(height: 8),
                                    Text('Status : ${"entry.bookTitle"}',
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
          applyLeave(context);
        },
        tooltip: 'Add Item',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

    );
  }

  void applyLeave(BuildContext context) {
    showCustomBottomSheet(context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            // Book Title

            DatePickerTextField(
                controller: controller.applyDate.value,
                title: 'Apply Date',
                onDateSelected: (date) async {
                  controller.applyDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),

            MyCustomSD(
              hideSearch: true,
              borderColor: Colors.grey,
              listToSearch:[],
              valFrom: "className",
              label: 'Available Leave',
              labelText: 'Available Leave',
              onChanged: (val) {
              },
            ),

            DatePickerTextField(
                controller: controller.fromDate.value,
                title: 'From Date',
                onDateSelected: (date) async {
                  controller.fromDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),  DatePickerTextField(
                controller: controller.toDate.value,
                title: 'To Date',
                onDateSelected: (date) async {
                  controller.toDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),

            CustomTextField(
              controller: controller.reasonC,
              hint: 'Reason',
              title: 'Permanent Address',
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