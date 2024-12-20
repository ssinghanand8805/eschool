import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lerno/presentation/common_widgets/MainBody.dart';
import 'package:lerno/presentation/submit_homework/controller/SubmitHomeworkController.dart';

import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';

class UploadHomework extends StatefulWidget {
  final String? homeworkid;

  const UploadHomework({Key? key,  this.homeworkid}) : super(key: key);

  @override
  _UploadHomeworkState createState() => _UploadHomeworkState();
}

class _UploadHomeworkState extends State<UploadHomework> {
  SubmitHomeworkController controller = Get.put(SubmitHomeworkController());
  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      controller.image.value = XFile(pickedFile.path);
    }
    if (pickedFile != null) {
      controller.updateImage(pickedFile);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.homeWorkMessageC.clear();
    controller.image.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: "Upload Homework\nfrom here!",
      imageUrl: "assets/projectImages/homeworkpage.jpg",
      AppbarTitle: "Upload Homework",
      widget: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: controller.homeWorkMessageC,
                  decoration: InputDecoration(
                    hintText: 'Message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),

                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Documents',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Obx(() {
                  return controller.image.value == null
                      ? Image.asset(
                    'assets/projectImages/upload_file.jpg',
                    height: 200,
                    width: 200,
                  )
                      : Image.file(
                    File(controller.image.value!.path),
                    height: 150,
                  );
                }),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.grey.shade400,
                  ),
                  onPressed: () {
                    _showImagePicker(context);
                  },
                  child: Text("Choose File"),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    backgroundColor: Colors.green.shade400,
                  ),
                  onPressed: () {
                    controller.submitHomework(widget.homeworkid!,context);
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
