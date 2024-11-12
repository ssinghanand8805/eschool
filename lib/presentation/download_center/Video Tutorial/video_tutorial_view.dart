import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Video%20Tutorial/video_tutorial_modal.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../common_widgets/custom_loader.dart';
import 'video_tutorial_controller.dart';

class VideoTutorialView extends GetView<VideoTutorialController> {
  VideoTutorialView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Content Type List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              title:'Add Video',textStyle: TextStyle(color: Colors.white),
              color:theme.hintColor,
              onPress: () {
                addVideo(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8),
          child: Column(
            children: [
              Obx(() => controller.commonApiController.isClassLoading.value ?   CircularProgressIndicator() : MyCustomSD(
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

              Obx(() => controller.commonApiController.isSectionLoading.value ? CircularProgressIndicator(): MyCustomSD(
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
              SizedBox(height: 10,),
        
              CustomTextField(
                  controller: controller.SearchByTitleC,
                  hint: "Search By Title",
                  title: 'Search By Title'),
              SizedBox(height: 10,),
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
                builder: (context,snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return controller.filteredContentTypeList.value.data != null && controller.filteredContentTypeList.value.data!.videoTutorialList!.length > 0 ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.filteredContentTypeList.value.data!.videoTutorialList!.length,
                      itemBuilder: (BuildContext context, int index){
                        VideoTutorialList videoTutorial = controller.filteredContentTypeList.value.data!.videoTutorialList![index];
                    return   Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 105,width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5))
                            ),
                            child: Image.network(GlobalData().baseUrlValueFromPref + videoTutorial.thumbPath! + videoTutorial.thumbName!),
                          ),
                          Expanded(
                            child: Container(
                                height: 105,
                                width: Get.width,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5,right: 5,top: 5,),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(videoTutorial.title!),
                                          Icon(Icons.delete,color: Colors.red,)
                                        ],
                                      ),
                                      Text(videoTutorial.description!),

                                      SizedBox(height: 15,),
                                      Row(
                                        children: [
                                          Text(videoTutorial.className!),
                                          SizedBox(width: 10,),
                                          Text(videoTutorial.section!,style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),)
                                        ],
                                      ),
                                      SizedBox(height: 5,),

                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    );
                  }) : Text("No Data found");
                }
              ),
        SizedBox(height: 10,)
        
        
            ],
          ),
        ),
      ),
    );
  }


  addVideo(context){
    showCustomBottomSheet(context:context,
        child: Column(
          children: [
            Text("Add Video Tutorial",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
            MyCustomSD(
                borderColor: Colors.grey,
                labelText: "Class: ",
                label: "Class",
                listToSearch: [
                  {
                    'name':"Faheem"
                  },
                  {
                    'name':"Faheem"
                  },
                  {
                    'name':"Faheem"
                  },
                ],
                valFrom: 'name',
                onChanged: (val){

                }),
            SizedBox(height: 20,),
            CustomTextField(
              controller: controller.SearchByTitleC,
              hint: "Section",
              title: "Section: ",),
            SizedBox(height: 10,),
            CustomTextField(
              controller: controller.SearchByTitleC,
              hint: "Title",
              title: "Title: ",),
            SizedBox(height: 10,),
            CustomTextField(
              controller: controller.SearchByTitleC,
              hint: "Video Link",
              title: "Video Link: ",),
            SizedBox(height: 10,),
            CustomTextField(
              maxLine: 3,
              controller: controller.SearchByTitleC,
              hint: "Description",
              title: "Description: ",),
            SizedBox(height: 20,),

            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title:'Save',textStyle: TextStyle(color: Colors.black,),
                color:Colors.green.shade100,
                onPress: () {

                },
              ),
            ),

          ],
        )


    );
  }


}