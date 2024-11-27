import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnladderfaculity/presentation/download_center/Video%20Tutorial/video_tutorial_modal.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../academics/Class Timetable/class_timetable_controller.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../common_widgets/custom_loader.dart';
import 'video_tutorial_controller.dart';

class VideoTutorialView extends GetView<VideoTutorialController> {
  VideoTutorialView({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Content Type List',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            children: [
              Obx(() => controller.commonApiController.isClassLoading.value
                  ? CircularProgressIndicator()
                  : MyCustomSD(
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .commonApiController.classListModelMap.value,
                      valFrom: "className",
                      label: 'Class',
                      labelText: 'Class',
                      initialValue: [
                        {
                          'parameter': 'id',
                          'value':
                              controller.commonApiController.selectedClassId!
                        }
                      ],
                      onChanged: (val) {
                        if (controller.commonApiController.classListModelMap
                                .value.length >
                            0) {
                          print("5555555555555");

                          controller.commonApiController.selectedClassId.value =
                              val['id'].toString();
                          controller.commonApiController.selectedClassName
                              .value = val['className'].toString();
                          controller.selectedClassName.value =
                              val['className'].toString();
                          controller.commonApiController.update();
                          controller.commonApiController.getSectionList();
                        }
                      },
                    )),
              Obx(() => controller.commonApiController.isSectionLoading.value
                  ? CircularProgressIndicator()
                  : MyCustomSD(
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .commonApiController.sectionListModelMap.value,
                      valFrom: "section",
                      label: 'Section',
                      labelText: 'Section',
                      initialValue: [
                        {
                          'parameter': 'id',
                          'value':
                              controller.commonApiController.selectedSectionId!
                        }
                      ],
                      onChanged: (val) {
                        print(val);
                        if (controller.commonApiController.sectionListModelMap
                                .value.length >
                            0) {
                          controller.commonApiController.selectedSectionId
                              .value = val['section_id'].toString();
                          controller.commonApiController.selectedSectionName
                              .value = val['section'].toString();
                          controller.selectedSectionName.value =
                              val['section'].toString();
                          controller.commonApiController.update();
                        }
                      },
                    )),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  controller: controller.SearchByTitleC,
                  hint: "Search By Title",
                  title: 'Search By Title'),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 100,
                  title: 'Search',
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  color: Colors.green.shade100,
                  onPress: () {
                    controller.searchApiData();
                    // Get.back();
                  },
                ),
              ),
              FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  if (controller.filteredContentTypeList.value.data != null &&
                      controller.filteredContentTypeList.value.data!.videoTutorialList!.isNotEmpty) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.filteredContentTypeList.value.data!.videoTutorialList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        VideoTutorialList videoTutorial = controller
                            .filteredContentTypeList.value.data!.videoTutorialList![index];
                        return GestureDetector(
                          onTap: () {
                            // Open YouTube video
                            String videoUrl = videoTutorial.videoLink!;
                            if (videoUrl.isNotEmpty) {
                              launchUrl(Uri.parse(videoUrl));
                            }
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                // Thumbnail Section
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.network(
                                      GlobalData().baseUrlValueFromPref +
                                          videoTutorial.thumbPath! +
                                          videoTutorial.thumbName!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                // Details Section
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Title
                                        Text(
                                          videoTutorial.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Description
                                        Text(
                                          videoTutorial.description!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodySmall!.copyWith(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Class and Section
                                        Row(
                                          children: [
                                            Text(
                                              "Class: ${videoTutorial.className!}",
                                              style: theme.textTheme.bodyMedium!.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "Section: ${videoTutorial.section!}",
                                              style: theme.textTheme.bodyMedium!.copyWith(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Delete Button
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.deleteVideoId(context,videoTutorial.id!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: theme.textTheme.bodyLarge,
                      ),
                    );
                  }
                },
              ),

              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addVideo(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  addVideo(context) {
    showCustomBottomSheet(
        context: context,
        child: Column(
          children: [
            Text(
              "Add Video Tutorial",
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Obx(() => controller.commonApiController.isClassLoading.value
                ? CircularProgressIndicator()
                : MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch:
                        controller.commonApiController.classListModelMap.value,
                    valFrom: "className",
                    label: 'Class',
                    labelText: 'Class',
                    initialValue: [
                      {
                        'parameter': 'id',
                        'value': controller.commonApiController.selectedClassId!
                      }
                    ],
                    onChanged: (val) {
                      if (controller.commonApiController.classListModelMap.value
                              .length >
                          0) {
                        print("5555555555555");

                        controller.commonApiController.selectedClassId.value =
                            val['id'].toString();
                        controller.commonApiController.selectedClassName.value =
                            val['className'].toString();
                        controller.selectedClassName.value =
                            val['className'].toString();
                        controller.commonApiController.update();
                        controller.commonApiController.getSectionList();
                      }
                    },
                  )),
            Obx(() => controller.commonApiController.isSectionLoading.value
                ? CircularProgressIndicator()
                : MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller
                        .commonApiController.sectionListModelMap.value,
                    valFrom: "section",
                    label: 'Section',
                    labelText: 'Section',
                    initialValue: [
                      {
                        'parameter': 'id',
                        'value':
                            controller.commonApiController.selectedSectionId!
                      }
                    ],
                    onChanged: (val) {
                      print(val);
                      if (controller.commonApiController.sectionListModelMap
                              .value.length >
                          0) {
                        controller.commonApiController.selectedSectionId.value =
                            val['section_id'].toString();
                        controller.commonApiController.selectedSectionName
                            .value = val['section'].toString();
                        controller.selectedSectionName.value =
                            val['section'].toString();
                        controller.commonApiController.update();
                      }
                    },
                  )),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.SearchByTitleC,
              hint: "Title",
              title: "Title: ",
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: controller.SearchByTitleC,
              hint: "Video Link",
              title: "Video Link: ",
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              maxLine: 3,
              controller: controller.SearchByTitleC,
              hint: "Description",
              title: "Description: ",
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
                onPress: () {},
              ),
            ),
          ],
        ));
  }
}
