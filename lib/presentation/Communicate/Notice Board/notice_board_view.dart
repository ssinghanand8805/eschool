
import'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_button.dart';
import '../../common_widgets/custom_loader.dart';
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
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchDataFuture,
            builder: (context,snapshot) {

              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              }
              return controller.nodeiceBoardModel.value.data == null ? Container(child: Text("no data found"),) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:  controller.nodeiceBoardModel.value.data!.length,
                  itemBuilder: (context, index) {
                    var notice = controller.nodeiceBoardModel.value.data![index];
                    String visibleTo = "";
                    if(notice.visibleStaff != null && notice.visibleStaff == 'Yes')
                    {
                      visibleTo = visibleTo + "Staff ,";
                    }
                    if(notice.visibleParent != null && notice.visibleParent == 'Yes')
                    {
                      visibleTo = visibleTo + "Parents ,";
                    }

                    if(notice.visibleStudent != null && notice.visibleStudent == 'Yes')
                    {
                      visibleTo = visibleTo + "Student ,";
                    }
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
                            child: Text(notice.title!),
                          )),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(notice.createdAt!),
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
              );
            }
          );
        }
      ),
    );
  }

}