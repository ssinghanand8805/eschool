import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';

import 'package:flutter_html/flutter_html.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/NotificationController.dart';
import 'model/Notification.dart';


// import 'controller/notice_board_controller.dart';


class  NotificationScreen extends StatefulWidget {
  @override
  State< NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State< NotificationScreen> {
  NotificationController controller = Get.put(NotificationController());



  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Notification\nLists',
      imageUrl: 'assets/projectImages/ic_notification.png',
      AppbarTitle: 'Notification Lists',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future:  controller.fetchDataFuture,//controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            }
            else {
              return  ListView.builder(
                itemCount: controller.notificationModelObj.value!.data!.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.notificationModelObj.value!.data!.length > 0 ? _buildTimeTableCard(
                    data:controller.notificationModelObj.value!.data![index],
                  ): Center(child: Image.asset("assets/projectImages/no_data.png",height: 100,));
                },
              );

            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required Data data}) {
    return CommonCardExtended(
        title: data.title!,
        leadingWidget: SizedBox(),
        subtitle: data.date!,
        newWidget:  Html(
            style: {
              "body": Style(
                fontSize: FontSize(15.0),
                color: Colors.black,
              ),
            },
            shrinkWrap: true,
            data:data.message!));
  }


}
