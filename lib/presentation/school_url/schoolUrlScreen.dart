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
      child:LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final isSmallScreen = screenWidth < 600;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.green.shade100,
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 32.0,
                  vertical: isSmallScreen ? 16.0 : 32.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: controller.urlController.value,
                      decoration: InputDecoration(
                        labelText: 'Enter School Url Here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        hintText: 'Type something...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 16.0 : 24.0,
                          vertical: isSmallScreen ? 12.0 : 16.0,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16.0 : 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: isSmallScreen ? 16.0 : 24.0),
                    ElevatedButton(
                      onPressed: () {
                        print('Next button pressed ${controller.urlController.value.text}');
                        controller.getData();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal:  35.0,
                          vertical: 24.0
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isSmallScreen ? 16.0 : 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Image.asset("assets/projectImages/bottom_img.png")
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
