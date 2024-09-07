import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_controller.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';

class UploadShareContentView extends GetView<UploadShareContentController> {
  UploadShareContentView({Key? key}) : super(key: key,);

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
              title:'Upload Content',textStyle: TextStyle(color: Colors.white),
              color:theme.hintColor,
              onPress: () {
                uploadContent(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8),
              child: CustomTextField(
                controller: controller.searchC,
                hint: 'Search.... ', title: '',),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 40,
                itemBuilder: (BuildContext context, int index){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                              width: Get.width,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(5),topRight: Radius.circular(5))
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5,bottom: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Booklist.pdf"),

                                          controller.getIsChecked == false?
                                              InkWell(
                                                onTap:(){

                                                  controller.updateIsChecked = true;
                                                    },
                                                  child: Icon(Icons.check_box_outline_blank))
                                          :
                                          InkWell(
                                            onTap:(){
                                              controller.updateIsChecked = false;
                  },
                                              child: Icon(Icons.check_box))
                                        ],
                                      ),
                                    ),
                                    Text("Joe Black (9000)"),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(DateTime.now().toString()),
                                        Row(
                                          children: [
                                            Icon(Icons.download),
                                            Icon(Icons.delete,color: Colors.red,)
                                          ],
                                        )
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
                  )
                ],
              );
            })
        
          ],
        ),
      ),
    );
  }


  uploadContent(context){
    AlertDialogue().show(context,
      newWidget: [
        Column(
          children: [
            Text("Upload content",style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),),
            MyCustomSD(
                borderColor: Colors.grey,
              label: "Content Type",
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
                onPress: () {

                },
              ),
            ),

          ],
        )
      ],

    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
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
