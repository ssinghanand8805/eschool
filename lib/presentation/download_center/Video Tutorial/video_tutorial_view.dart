import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';
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
              MyCustomSD(
                borderColor: Colors.grey,
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
        
              }
              ),
        
              MyCustomSD(
                  borderColor: Colors.grey,
                  label: "Section",
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
        
                  }
              ),
              SizedBox(height: 10,),
        
              CustomTextField(
                  controller: controller.SearchByTitleC,
                  hint: "Search By Title",
                  title: 'Search By Title'),
        
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                  itemBuilder: (BuildContext context, int index){
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
                        child: Icon(Icons.picture_as_pdf),
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
                                      Text("Human body"),
                                      Icon(Icons.delete,color: Colors.red,)
                                    ],
                                  ),
                                  Text("Class 4"),
        
                                  SizedBox(height: 15,),
                                  Row(
                                    children: [
                                      Text("Section: "),
                                      Text("A,B,C",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),)
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
              }),
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