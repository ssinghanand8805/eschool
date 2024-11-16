
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/datePickerTextField.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/alert_dialogue.dart';
import '../../../../widgets/customHtmlEditor.dart';
import '../../../../widgets/customTextField.dart';
import '../../../../widgets/custom_button.dart';
import 'new_message_controller.dart';

class NewMessageView extends GetView<NewMessageController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Compose New Message',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 100,
              title: 'Message To',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                messageTo(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("Compose New Message",style: theme.textTheme.bodyMedium,),
            CustomTextField(
              controller: controller.titleC.value,
              title: "",
              hint: 'Title',
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.noticeDateC.value,
                    title: "Notice Date",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.publishOnC.value,
                    title: "Publish On",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),

            Text("Attachment",style: theme.textTheme.titleMedium,),
            SizedBox(height: 5,),
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

            SizedBox(height: 10,),
            CustomHtmlEditor(
              controller: controller.messageC.value,
              height: 200,
              title: 'Message',)
          ],
        ),
      ),
    );
  }

  messageTo(context){
    showCustomBottomSheet(context:context,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Message To",style: theme.textTheme.bodyMedium,),

    ListView.builder(
      shrinkWrap: true,
    itemCount: controller.roles.length,
        itemBuilder: (context, index) {
          return Obx(() =>
              CheckboxListTile(
                title: Text(controller.roles[index]),
                value: controller.checkboxStates[index],
                onChanged: (bool? value) {
                  if (value != null) {
                    controller.toggleCheckbox(index, value);
                  }
                },
              ));
        }
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
        )

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