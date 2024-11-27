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
          style: theme.textTheme.bodyMedium,
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
                  return Column(
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.filteredContentTypeList.value
                              .data?.leaveRequest?.length ??
                              0,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final entry = controller.filteredContentTypeList
                                .value.data!.leaveRequest![index];
                            String status = entry
                                .status!;

                            Color statusColor;
                            switch (status.toLowerCase()) {
                              case 'approved':
                                statusColor = Colors.green;
                                break;
                              case 'pending':
                                statusColor = Colors.orange;
                                break;
                              case 'rejected':
                                statusColor = Colors.red;
                                break;
                              default:
                                statusColor =
                                    Colors.grey;
                            }

                            return Card(
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    16), // Modern rounded corners
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
                                      // Staff Name
                                      Text(
                                        'Staff : ${entry.name.toString().capitalizeFirst ?? "N/A"}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Leave Type
                                      Text(
                                        'Leave Type: ${entry.type ?? "N/A"}',
                                        style:
                                        Theme.of(context).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 8),

                                      // Leave Date
                                      Text(
                                        'Leave Date: ${entry.leaveFrom ?? "N/A"} - ${entry.leaveTo ?? "N/A"}',
                                        style:
                                        Theme.of(context).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 8),

                                      // Days
                                      Text(
                                        'Days: ${entry.date ?? "N/A"}',
                                        style:
                                        Theme.of(context).textTheme.bodySmall,
                                      ),
                                      const SizedBox(height: 8),

                                      // Apply Date
                                      Text(
                                        'Apply Date: ${entry.leaveTo ?? "N/A"}',
                                        style:
                                        Theme.of(context).textTheme.bodySmall,
                                      ),
                                      // const SizedBox(height: 16),

                                      // Leave Status
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: statusColor.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              status.toUpperCase(),
                                              style: theme.textTheme.titleMedium!.copyWith(
                                                color: statusColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          // Actions: Edit and Delete
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text(
                                                          "Confirm Delete",
                                                          style: theme.textTheme
                                                              .bodyLarge,
                                                        ),
                                                        content: Text(
                                                          "Are you sure you want to delete this Gallery Image? This action cannot be undone.",
                                                          style: theme.textTheme
                                                              .bodySmall,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              // controller
                                                              //     .deleteLeave(
                                                              //     context,entry.id,entry.staffId
                                                              // );
                                                              Navigator.of(
                                                                  context)
                                                                  .pop(); // Close the dialog
                                                            },
                                                            child: const Text(
                                                              "Delete",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )


                    ],
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
              hint: 'Reason.....',
              title: 'Reason',
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