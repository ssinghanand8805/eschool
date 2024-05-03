import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/download_center/Upload%20Content/upload_share_content_controller.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';

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
                //addContent(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: CustomTextField(
              controller: controller.searchC,
              hint: 'Search.... ', title: '',),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all()
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 100,width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Icon(Icons.picture_as_pdf),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("dsds"),
                        Text("data")
                      ],
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
