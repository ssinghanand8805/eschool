import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_controller.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_modal.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';

class UploadShareContentView extends GetView<UploadShareContentController> {
  UploadShareContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    // Add listener for scroll events
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
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
          Obx(() =>  Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: controller.checkboxStates.values.any((isChecked) => isChecked == true) ?
              MyButton(
                width: 120,
                title: 'Share Content',
                textStyle: TextStyle(color: Colors.white),
                color: theme.hintColor,
                onPress: () async {
                  await controller.getContypeList();
                  uploadContent(context);
            
                },
              ) :MyButton(
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
                    controller.fetchData(isRefresh: true); // Fetch filtered data
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.dataList.length + 1, // Extra item for loader
                    itemBuilder: (BuildContext context, int index) {
                      if (index == controller.dataList.length) {
                        return controller.isLoading.value
                            ? Center(child: CircularProgressIndicator())
                            : Container(); // Show loader while more data is being fetched
                      }

                      var item = controller.dataList[index];
                      return buildContentItem(item,context);
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

  Widget buildContentItem(Content item,context) {
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    String mediaUrl = baseUrlFromPref +  item.thumbPath! + item.thumbName!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 105,
            width: 100,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            ),
            child: Image.network(mediaUrl)
            // child: item.fileType!.toString() == "video" ?  Icon(Icons.video_collection) : item.fileType!.toString() == "png" ? Icon(Icons.image) : Icon(Icons.picture_as_pdf),
          ),
          Expanded(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.realName.toString()), // Display item name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Uploaded by ${item.staffName} (${item.employeeId})",style: TextStyle(fontSize: 10),),
                        Column(
                          children: [
                            Row(
                              children: [
                                Obx(() {
                                  return Checkbox(
                                    value: controller.checkboxStates[item.id] ?? false,
                                    onChanged: (bool? value) {
                                      if (value != null) {
                                        controller.toggleCheckboxState(item.id!, value);
                                      }
                                    },
                                  );
                                }),
                              ],
                            ),
                            Row(
                              children: [
                               item.vidUrl!.trim() != '' ? Icon(Icons.remove_red_eye) : Icon(Icons.download),
                                InkWell(child: Icon(Icons.delete, color: Colors.red),onTap: () {

                                    // If the user confirms the deletion
                                    controller.deletecontenttypebyId(context, int.parse(item.id!));
                                   // Navigator.of(context).pop(); // Close the dialog


                                },),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void uploadContent(context){
    showCustomBottomSheet(context:context,
      child: Column(
          children: [
            Text("Upload content",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
            MyCustomSD(
                borderColor: Colors.grey,
                label: "Content Type",
                listToSearch:  controller.filteredContentTypeList.value.data!.map((entry) {
                  return {
                    'id': entry.id,  // Assuming the list items have an `id` property
                    'name': entry.name  // Assuming the list items have a `name` property
                  };
                }).toList(),

                valFrom: 'name',
                onChanged: (val){
                  controller.selectedContentTypeId.value = val['id'];
                }),
            SizedBox(height: 20,),

            InkWell(
              onTap: (){
                _showImagePicker(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all()
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file),
                    Text("Drag and drop a file here or click"),
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
                    height: 2,width: 80,
                    decoration: BoxDecoration(
                        color: Colors.black
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0,right: 4),
                    child: Text("or"),
                  ),
                  Container(
                    height: 2,width: 80,
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
              title: "Upload Youtube Video Link: ",),
            SizedBox(height: 20,),

            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title:'Save',textStyle: TextStyle(color: Colors.black,),
                color:Colors.green.shade100,
                onPress: ()  {
                  controller.saveContentType(context);
                },
              ),
            ),

          ],
        )


    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final List<XFile>? pickedFiles = await _picker.pickMultipleMedia();

    if (pickedFiles != null) {

      for(var i = 0; i<pickedFiles.length;i++ )
        {
          var f =  File(pickedFiles[i].path);
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
