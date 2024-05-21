import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customHtmlEditor.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'email_tamplet_controller.dart';

class EmailTemplateView extends GetView<EmailTemplateController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.green.shade100,
       title: Text(
         'Email Template List',
         style: theme.textTheme.titleLarge,
       ),
       actions: [
         Padding(
           padding: const EdgeInsets.only(right: 8.0),
           child: MyButton(
             width: 80,
             prefixIcon: Icon(
               Icons.add,size: 14,
               color: Colors.white,
             ),
             title: 'add',
             textStyle: TextStyle(fontSize: 14, color: Colors.white),
             color: theme.hintColor,
             onPress: () async {
               addTemplate(context);
              // await Get.toNamed(AppRoutes.new_messageRoute);
             },
           ),
         ),
       ],
     ),
     body: Padding(
       padding: const EdgeInsets.only(left: 8.0,right: 8),
       child: Column(
         children: [
           CustomTextField(
               controller: controller.searchC.value,
               hint: "Search...",
               title: ''),
           SizedBox(height: 20,),

           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: DataTable(
               columnSpacing: Get.width*0.2,
               //dataRowHeight: 100,
               columns: const [
                 DataColumn(label: Text('Title')),
                 DataColumn(label: Text('Message')),
                 DataColumn(label: Text('Action')),
               ],
               rows: controller.data.asMap().entries.map((entry) {
                 int index = entry.key;
                 return DataRow(
                   cells: [
                     DataCell(Text(entry.value['class'],
                         style: theme.textTheme.bodySmall!)),
                     DataCell(
                         Text("Games that are played on school sports days can be wide and varied. They can include ")),
                     DataCell(
                         Row(
                           children: [
                             Icon(Icons.edit),
                             SizedBox(width: 15,),
                             Icon(Icons.delete),
                           ],
                         )
                     ),
                   ],
                 );
               }).toList(),
             ),
           ),
         ],
       ),
     ),
   );
  }

  addTemplate(context){
    AlertDialogue().show(context, newWidget: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Add Email Template",
          style: theme.textTheme.bodyMedium,
        ),
        CustomTextField(
          controller: controller.titleC.value,
          hint: "Title",
          title: "",
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
        SizedBox(
          height: 15,
        ),

        CustomHtmlEditor(
          controller: controller.messageC.value,
          height: 200,
          title: 'Message',),



        SizedBox(
          height: 15,
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
      ])
    ]);
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