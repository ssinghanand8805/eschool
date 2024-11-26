import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';

import 'media_manager_controller.dart';

class MediaManagerView extends GetView<MediaManagerController> {
  MediaManagerView({Key? key})
      : super(
          key: key,
        );
  final callback = Get.arguments?['callback'] as Function?;
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
                        padding:
                            const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                        child: MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.listToSearch,
                          valFrom: "value",
                          label: 'Filter By File Type',
                          labelText: 'Filter By File Type',
                          onChanged: (val) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: CustomTextField(
                          controller: controller.searchC,
                          hint: 'Search.... ',
                          title: 'Search',
                          onChanged: (val) {},
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: MyButton(
                              onPress: () {},
                              color: Colors.green,
                              textStyle: theme.textTheme.titleMedium,
                              width: 80,
                              title: "Search"),
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: GetBuilder<MediaManagerController>(
                          builder: (controller) {
                            if (controller.mediaManagerList.value.data ==
                                    null ||
                                controller
                                    .mediaManagerList.value.data!.isEmpty) {
                              return Center(child: CustomLoader());
                            }

                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two items per row
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: controller
                                  .mediaManagerList.value.data!.length,
                              padding: const EdgeInsets.all(20.0),
                              itemBuilder: (BuildContext context, int index) {
                                final media = controller
                                    .mediaManagerList.value.data![index];
                                final imageUrl =
                                    GlobalData().baseUrlValueFromPref +
                                        media.dirPath! +
                                        media.imgName!;

                                return Card(
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
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Image Section
                                        InkWell(
                                          onTap: () {
                                            showResponsiveImageDialog(
                                                context, imageUrl);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                              top: Radius.circular(20.0),
                                            ),
                                            child: Image.network(
                                              imageUrl,
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                height: 100,
                                                width: double.infinity,
                                                color: Colors.grey.shade200,
                                                child: const Center(
                                                  child: Icon(
                                                      Icons.broken_image,
                                                      color: Colors.grey,
                                                      size: 50),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Content Section
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Image Name
                                              Text(
                                                'Title: ${media.image}',
                                                maxLines: 2,
                                                style: theme.textTheme.bodyLarge
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(height: 8),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                              "Confirm Delete",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            content: Text(
                                                              "Are you sure you want to delete this Gallery Image? This action cannot be undone.",
                                                              style: theme
                                                                  .textTheme
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
                                                                  controller
                                                                      .deleteMedia(
                                                                          context,
                                                                          media
                                                                              .id);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child:
                                                                    const Text(
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
                                                  callback != null
                                                      ? Radio<String>(
                                                          value: imageUrl,
                                                          groupValue:
                                                              "", // Current selected value
                                                          onChanged:
                                                              (String? value) {
                                                            if (callback !=
                                                                null) {
                                                              callback!({'image' : value,'id':media.id});
                                                              Get.back();
                                                            }
                                                          },
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addMedia(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addMedia(BuildContext context) {
    String selectedMediaType = "YouTube";

    showCustomBottomSheet(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Media Type Selection
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose Media Type",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: "YouTube",
                            groupValue: selectedMediaType,
                            onChanged: (String? value) {
                              setState(() {
                                selectedMediaType = value!;
                              });
                            },
                          ),
                          const Text("YouTube Link"),
                          Radio<String>(
                            value: "Image/Video",
                            groupValue: selectedMediaType,
                            onChanged: (String? value) {
                              setState(() {
                                selectedMediaType = value!;
                              });
                            },
                          ),
                          const Text("Image"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Conditional Rendering Based on Media Type
                if (selectedMediaType == "YouTube") ...[
                  CustomTextField(
                    controller: controller.titleC,
                    hint: 'Upload YouTube Video Link',
                    title: 'YouTube Video Link',
                  ),
                ] else ...[
                  InkWell(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.upload_file, color: Colors.green),
                          const SizedBox(width: 8),
                          const Text(
                            "Drag and drop a file here or click",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Obx(
                        () => Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: files.map((file) {
                        print("FILE PATH ${file.path}");
                        return Stack(
                          children: [
                            Image.file(
                              file,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.cancel, color: Colors.white),
                                onPressed: () {
                                  files.remove(file);
                                },
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
                const SizedBox(height: 20),

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
                      if (selectedMediaType == "YouTube") {
                        controller.addVideo(context, controller.titleC.text);
                        print("Saving YouTube Link: ${controller.titleC.text}");
                      }
                      else {
                        print("ALL FILES ${files.map((element) => element.path)}");
                        controller.addImage(
                            context,files);
                        print("Saving Image/Video");
                      }
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();
  RxList<File> files = <File>[].obs;

  Future<void> getMultipleImagesFromGallery() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        files.addAll(pickedFiles.map((file) => File(file.path)));
        print("Picked files: ${files.length}");
      } else {
        print("No images selected.");
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Future<void> getSingleImageFromCamera() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        files.add(File(pickedFile.path));
        print("Camera image added.");
      } else {
        print("No image captured.");
      }
    } catch (e) {
      print("Error capturing image: $e");
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
                    title: Text('Pick Multiple from Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getMultipleImagesFromGallery();
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Capture a Single Image'),
                    onTap: () {
                      Navigator.pop(context);
                      getSingleImageFromCamera();
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
