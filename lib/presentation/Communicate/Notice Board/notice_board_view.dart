
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_button.dart';
import 'notice_board_controller.dart';

class NoticeBoardView extends GetView<NoticeBoardController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Notice Board',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 160,
              prefixIcon: Icon(
                Icons.add,size: 14,
                color: Colors.white,
              ),
              title: 'Post New Message',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () async {
                await Get.toNamed(AppRoutes.new_messageRoute);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 100,
          itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.email_outlined),
                  ),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text("Fees Reminder "),
                  )),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0,top: 8.0),
                    child: Icon(Icons.edit),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.delete),
                  ),
                ],
              ),
              Divider()
            ],
          );
        },),
      ),
    );
  }

}