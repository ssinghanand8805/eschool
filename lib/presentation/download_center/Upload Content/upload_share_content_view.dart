import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_controller.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_modal.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/CommonUserSelection.dart';
import '../../common_widgets/controller/CommonUserSelectionController.dart';
import 'package:url_launcher/url_launcher.dart';
class UploadShareContentView extends GetView<UploadShareContentController> {
  UploadShareContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    Get.put(CommonUserSelectionController());
    // Add listener for scroll events
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          controller.hasMore.value &&
          !controller.isLoading.value) {
        controller.fetchData(); // Load more data
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Content List', style: theme.textTheme.titleLarge),
        actions: [
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: controller.checkboxStates.values
                      .any((isChecked) => isChecked == true)
                  ? MyButton(
                      width: 120,
                      title: 'Share Content',
                      textStyle: TextStyle(color: Colors.white),
                      color: theme.hintColor,
                      onPress: () async {
                        await controller.getContypeList();
                        shareContent(context);
                      },
                    )
                  : MyButton(
                      width: 120,
                      title: 'Upload Content',
                      textStyle: TextStyle(color: Colors.white),
                      color: theme.hintColor,
                      onPress: () async {
                        await controller.getContypeList();
                        uploadContent(context);
                      },
                    ),
            ),
          ),
        ],
      ),
      body: GetBuilder<UploadShareContentController>(
        init: controller,
        builder: (_) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: controller.searchC,
                  hint: 'Search.... ',
                  title: '',
                  onChanged: (val) {
                    controller.fetchData(
                        isRefresh: true); // Fetch filtered data
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount:
                        controller.dataList.length + 1, // Extra item for loader
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.dataList.length) {
                        return controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : Container(); // Show loader while more data is being fetched
                      }

                      var item = controller.dataList[index];
                      return buildContentItem(item, context);
                    },
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildContentItem(Content item, BuildContext context) {
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    String mediaUrl = baseUrlFromPref + item.thumbPath! + item.thumbName!;
    String imageUrl = baseUrlFromPref + item.dirPath.toString() + item.imgName!;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail Section
                  GestureDetector(

                    onTap: () {
                      if (item.fileType.toString() == "video") {

                        if (item.vidUrl!.isNotEmpty) {
                          openYouTubeVideo(item.vidUrl);
                        }
                      } else {
                        // Show image in a popup dialog
                        showResponsiveImageDialog(context,imageUrl);
                      }
                    },
                    child: Hero(
                      tag: 'content-${item.id}',
                      child: Container(
                        height: 140,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            item.fileType.toString() == "video"
                                ? Image.asset(
                                    "assets/projectImages/youtube_icon.png")
                                : Image.network(
                                    mediaUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Image.asset(
                                            "assets/projectImages/no_data.png"),
                                  ),
                            // File type overlay indicator
                            if (item.fileType != null)
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    item.fileType.toString() == "video"
                                        ? Icons.play_circle_fill
                                        : item.fileType.toString() == "jpg"
                                            ? Icons.image
                                            : Icons.image,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Content Section
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            item.realName.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // const SizedBox(height: 8),

                          // Upload info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.blue[100],
                                child: Text(
                                  item.staffName![0].toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${item.staffName} (${item.employeeId})",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          //  const SizedBox(height: 12),

                          // Action buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(() => Transform.scale(
                                    scale: 0.9,
                                    child: Checkbox(
                                      value:
                                          controller.checkboxStates[item.id] ??
                                              false,
                                      onChanged: (bool? value) {
                                        if (value != null) {
                                          controller.toggleCheckboxState(
                                              item.id!, value);
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  )),
                              // View/Download button
                              // IconButton(
                              //   icon: Icon(
                              //     item.vidUrl!.trim() != ''
                              //         ? Icons.visibility_outlined
                              //         : Icons.download_outlined,
                              //     color: Colors.blue[700],
                              //     size: 20,
                              //   ),
                              //   onPressed: () {
                              //     // Implement view/download functionality
                              //   },
                              // ),

                              // Delete button
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 20,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Delete Content'),
                                      content: const Text(
                                          'Are you sure you want to delete this item?'),
                                      actions: [
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        TextButton(
                                          child: const Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                          onPressed: () {
                                            controller.deletecontenttypebyId(
                                              context,
                                              int.parse(item.id!),
                                            );
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openYouTubeVideo(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  void showResponsiveImageDialog(BuildContext context, String mediaUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16), // Adds padding around the dialog
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate responsive dimensions based on screen size
            double dialogWidth = MediaQuery.of(context).size.width * 0.9;
            double dialogHeight = MediaQuery.of(context).size.height * 0.7;

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
                      backgroundColor: Colors.black.withOpacity(0.7),
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

  // Widget buildContentItem(Content item,context) {
  //   String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  //   String mediaUrl = baseUrlFromPref +  item.thumbPath! + item.thumbName!;
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Row(
  //       children: [
  //         Container(
  //           height: 105,
  //           width: 100,
  //           decoration: BoxDecoration(
  //             border: Border.all(),
  //             borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
  //           ),
  //           child: Image.network(mediaUrl)
  //           // child: item.fileType!.toString() == "video" ?  Icon(Icons.video_collection) : item.fileType!.toString() == "png" ? Icon(Icons.image) : Icon(Icons.picture_as_pdf),
  //         ),
  //         Expanded(
  //           child: Container(
  //             width: Get.width,
  //             decoration: BoxDecoration(
  //               border: Border.all(),
  //               borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(item.realName.toString()), // Display item name
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text("Uploaded by ${item.staffName} (${item.employeeId})",style: TextStyle(fontSize: 10),),
  //                       Column(
  //                         children: [
  //                           Row(
  //                             children: [
  //                               Obx(() {
  //                                 return Checkbox(
  //                                   value: controller.checkboxStates[item.id] ?? false,
  //                                   onChanged: (bool? value) {
  //                                     if (value != null) {
  //                                       controller.toggleCheckboxState(item.id!, value);
  //                                     }
  //                                   },
  //                                 );
  //                               }),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                              item.vidUrl!.trim() != '' ? Icon(Icons.remove_red_eye) : Icon(Icons.download),
  //                               InkWell(child: Icon(Icons.delete, color: Colors.red),onTap: () {
  //
  //                                   // If the user confirms the deletion
  //                                   controller.deletecontenttypebyId(context, int.parse(item.id!));
  //                                  // Navigator.of(context).pop(); // Close the dialog
  //
  //
  //                               },),
  //                             ],
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  getDate() async {
    var date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  void shareContent(context) {
    showCustomBottomSheet(
        context: context,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Text("Share content",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
              CustomTextField(
                controller: controller.shareSelectedTitleC,
                hint: "Title",
                title: "Title: ",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: controller.shareSelectedShareDateController.value,
                  hint: "Share Date",
                  title: "Share Date: ",
                  onTap: () async {
                    // Show date picker for apply date
                    final date = await getDate();
                    if (date != null) {
                      var d = await GlobalData()
                          .ConvertToSchoolDateTimeFormat(date);
                      controller.shareSelectedShareDateController.value.text =
                          d;
                      controller.update();
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller:
                      controller.shareSelectedValidUpToDateController.value,
                  hint: "Valid Upto",
                  title: "Valid Upto: ",
                  onTap: () async {
                    // Show date picker for apply date
                    final date = await getDate();
                    if (date != null) {
                      var d = await GlobalData()
                          .ConvertToSchoolDateTimeFormat(date);
                      controller
                          .shareSelectedValidUpToDateController.value.text = d;
                      controller.update();
                    }
                  }),

              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller.shareSelectedDescriptionC,
                hint: "Description",
                title: "Description: ",
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                "Send To",
                style: theme.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              CommonUserSelection(),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 120,
                  title: 'Share',
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  color: Colors.green.shade100,
                  onPress: () {
                    controller.share(context);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  void uploadContent(context) {
    showCustomBottomSheet(
        context: context,
        child: Column(
          children: [
            Text(
              "Upload content",
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            MyCustomSD(
                borderColor: Colors.grey,
                label: "Content Type",
                listToSearch:
                    controller.filteredContentTypeList.value.data!.map((entry) {
                  return {
                    'id': entry
                        .id, // Assuming the list items have an `id` property
                    'name': entry
                        .name // Assuming the list items have a `name` property
                  };
                }).toList(),
                valFrom: 'name',
                onChanged: (val) {
                  controller.selectedContentTypeId.value = val['id'];
                }),
            SizedBox(
              height: 20,
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
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: 80,
                    decoration: BoxDecoration(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4),
                    child: Text("or"),
                  ),
                  Container(
                    height: 2,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            CustomTextField(
              controller: controller.videoLinkC,
              hint: "Upload Youtube Video Link",
              title: "Upload Youtube Video Link: ",
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {
                  controller.saveContentType(context);
                },
              ),
            ),
          ],
        ));
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final List<XFile>? pickedFiles = await _picker.pickMultipleMedia();

    if (pickedFiles != null) {
      for (var i = 0; i < pickedFiles.length; i++) {
        var f = File(pickedFiles[i].path);
        controller.pickedFile.value.add(f);
      }
      controller.update();

      // controller.image.value = File(pickedFile.path);
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
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.camera_alt,
                  //     color: Theme.of(context).primaryColor,
                  //   ),
                  //   title: Text('Take a Picture'),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     getImage(ImageSource.camera);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
