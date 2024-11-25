import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../common_widgets/custom_loader.dart';

import 'media_manager_controller.dart';

class  MediaManagerView extends GetView< MediaManagerController> {
  MediaManagerView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Media Manager',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder<MediaManagerController>(
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
                        child: GetBuilder<MediaManagerController>(
                          builder: (controller) {
                            if (controller.mediaManagerList.value.data == null ||
                                controller.mediaManagerList.value.data!.isEmpty) {
                              return Center(child: CustomLoader());
                            }

                            return ListView.builder(
                              itemCount:
                              controller.mediaManagerList.value.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final media = controller
                                    .mediaManagerList.value.data![index];
                                final imageUrl = GlobalData().baseUrlValueFromPref+media.dirPath! + media.imgName!;
                                return   Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  child: Card(
                                    elevation: 4.0,
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
                                        borderRadius: BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 10,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Image Section
                                          InkWell(
                                            onTap: (){

                                              showResponsiveImageDialog(context,imageUrl);
                                            }
                                            ,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                                              child: Image.network(
                                               imageUrl,
                                                height: 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) => Container(
                                                  height: 200,
                                                  width: double.infinity,
                                                  color: Colors.grey.shade200,
                                                  child: Center(
                                                    child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Content Section
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Image Name
                                                Text(
                                                  'Title: ${media.imgName}',
                                                  style: theme.textTheme.bodyLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),

                                                // Action Buttons
                                                // Row(
                                                //   mainAxisAlignment: MainAxisAlignment.end,
                                                //   children: [
                                                //     IconButton(
                                                //       icon: Icon(
                                                //         Icons.edit,
                                                //         color: Colors.blueAccent,
                                                //       ),
                                                //       onPressed: () {
                                                //         // Handle edit action
                                                //       },
                                                //     ),
                                                //     IconButton(
                                                //       icon: Icon(
                                                //         Icons.delete,
                                                //         color: Colors.redAccent,
                                                //       ),
                                                //       onPressed: () {
                                                //         // Delete confirmation dialog
                                                //         showDialog(
                                                //           context: context,
                                                //           builder: (BuildContext context) {
                                                //             return AlertDialog(
                                                //               shape: RoundedRectangleBorder(
                                                //                 borderRadius: BorderRadius.circular(15),
                                                //               ),
                                                //               title: Text(
                                                //                 "Confirm Delete",
                                                //                 style: theme.textTheme.titleMedium,
                                                //               ),
                                                //               content: Text(
                                                //                 "Are you sure you want to delete this subject? This action cannot be undone.",
                                                //                 style: theme.textTheme.bodyMedium,
                                                //               ),
                                                //               actions: [
                                                //                 TextButton(
                                                //                   onPressed: () {
                                                //                     Navigator.of(context).pop(); // Close dialog
                                                //                   },
                                                //                   child: Text(
                                                //                     "Cancel",
                                                //                     style: TextStyle(color: Colors.black54),
                                                //                   ),
                                                //                 ),
                                                //                 TextButton(
                                                //                   onPressed: () {
                                                //                     controller.deleteEvent(context, media.id);
                                                //                     Navigator.of(context).pop(); // Close dialog
                                                //                   },
                                                //                   child: Text(
                                                //                     "Delete",
                                                //                     style: TextStyle(color: Colors.red),
                                                //                   ),
                                                //                 ),
                                                //               ],
                                                //             );
                                                //           },
                                                //         );
                                                //       },
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
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
  void showResponsiveImageDialog(BuildContext context, String mediaUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16), // Adds padding around the dialog
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate responsive dimensions based on screen size
            double dialogWidth = MediaQuery.of(context).size.width * 0.8;
            double dialogHeight = MediaQuery.of(context).size.height * 0.6;

            return Stack(
              children: [
                // The main image container
                Container(
                  width: dialogWidth,
                  height: dialogHeight,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      mediaUrl,
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/projectImages/no_data.png"),
                    ),
                  ),
                ),
                // Close button positioned at the top right corner
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 16,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}