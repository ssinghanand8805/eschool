import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/custom_loader.dart';

import 'gallery_controller.dart';

class GalleryView extends GetView<GalleryController> {
  GalleryView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Gallery',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder<GalleryController>(
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
                          hint: 'Search.... ',
                          title: '',
                          onChanged: (val) {},
                        ),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: GetBuilder<GalleryController>(
                          builder: (controller) {
                            if (controller.galleryList.value.data == null ||
                                controller.galleryList.value.data!.listResult!
                                    .isEmpty) {
                              return Center(child: CustomLoader());
                            }

                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two items per row
                                crossAxisSpacing: 10.0, // Space between columns
                                mainAxisSpacing: 10.0, // Space between rows
                                childAspectRatio:
                                    0.8, // Adjust height-to-width ratio
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              itemCount: controller
                                  .galleryList.value.data!.listResult!.length,
                              itemBuilder: (BuildContext context, int index) {
                                final gallery = controller
                                    .galleryList.value.data!.listResult![index];
                                return Card(
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Displaying image with rounded corners
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(16.0)),
                                          child: Image.network(
                                            gallery.featureImage ?? '',
                                            fit: BoxFit.cover,
                                            height: 120, // Adjust height
                                            width:
                                                double.infinity, // Full width
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                height: 120,
                                                width: double.infinity,
                                                color: Colors.grey.shade300,
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                  color: Colors.grey,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            gallery.title
                                                    .toString()
                                                    .capitalizeFirst ??
                                                'No Title',
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                                              controller
                                                                  .deleteGallery(
                                                                      context,
                                                                      gallery
                                                                          .slug);
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
          addImages(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addImages(BuildContext context) {
    showCustomBottomSheet(
      context: context,
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
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Get.toNamed('/media_manager', arguments: {
                  'callback': (Map<String,dynamic> result) {
                    print('Callback executed with result: $result');
                    controller.HtmlController.value.insertNetworkImage(result['image']);
                  }
                });

//controller.HtmlController.value.insertNetworkImage("http://172.16.19.96/school3/uploads/gallery/media/1732515064-744706031674414f85deb1!download.jpg");
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.shade200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.drive_folder_upload_rounded,
                        color: Colors.green),
                    Text(
                      "Add Media",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 350,
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
                          superscript: false),
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
            SizedBox(height: 24),
            InkWell(
              onTap: () {
                Get.toNamed('/media_manager', arguments: {

                  'callback': (Map<String,dynamic> result) {
                    print('Callback executed with result: $result');
                    controller.addImage(result);
                  }
                });
                },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.shade200)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.drive_folder_upload_rounded,
                        color: Colors.green),
                    Text(
                      "Add Images",
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
              const SizedBox(height: 24),
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.imageList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of images per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade200),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(controller.imageList[index]['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            controller.imageList.removeAt(index); // Remove the image
                          },
                          child: Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
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

                  controller.addGallery(context, controller.titleC.value.text,
                      controller.HtmlController.value);
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
}
