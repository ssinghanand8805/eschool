import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import 'controller/school_url_controller.dart';

class SchoolUrl extends StatefulWidget {
  const SchoolUrl({Key? key}) : super(key: key);

  @override
  State<SchoolUrl> createState() => _SchoolUrlState();
}

class _SchoolUrlState extends State<SchoolUrl> {
  SchoolUrlController controller = Get.put(SchoolUrlController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onPrimary,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller.urlController.value,
                decoration: InputDecoration(
                  labelText: 'Enter School Url Here', // Label text
                  border: OutlineInputBorder(), // Adds border around the TextField
                  hintText: 'Type something...', // Placeholder text
                ),
                textAlign:
                    TextAlign.center, // Centers the text inside the TextField
              ),
              SizedBox(height: 20),  // Adds space between the TextField and the button
              ElevatedButton(
                onPressed: () {
                  // Action to perform when the button is pressed
                  print('Next button pressed${controller.urlController.value.text}');
                  controller.getData();
                },
                child: Text('Next',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
