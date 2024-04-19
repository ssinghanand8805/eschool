import 'package:learnladderfaculity/core/app_export.dart';
import 'package:flutter/material.dart';


import 'package:flutter_html/flutter_html.dart';
import '../../core/utils/common_utilities.dart';

import '../presentation/common_widgets/CommonCardExtended.dart';
import '../presentation/common_widgets/MainBody.dart';
import '../presentation/common_widgets/custom_loader.dart';
import 'controller/NotificationController.dart';
import 'model/FCMNotifications.dart';
import 'package:visibility_detector/visibility_detector.dart';


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
      imageUrl: 'assets/projectImages/noticepage.png',
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
              return controller.notificationModelObj.value!.length > 0 ?  ListView.builder(
                itemCount: controller.notificationModelObj.value!.length ?? 0,
                itemBuilder: (context, index) {
                  return  _buildTimeTableCard(
                    data:controller.notificationModelObj.value![index],index:  index
                  );
                },
              ) : Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/projectImages/no_data.png",),
                  Text("No data found!")
                ],
              ));

            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required FCMNotifications data, required int index}) {
    return VisibilityDetector(
      key: Key('notification-$index'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.5) { // Check if more than 50% of the item is visible
          controller.markNotificationAsRead(index);
        }
      },
      child: CommonCardExtended(
          title: data.title!,
          leadingWidget: SizedBox(),
          subtitle: Utils.formatDateString(data.timestamp!.toString()),
          newWidget:  Html(
              style: {
                "body": Style(
                  fontSize: FontSize(15.0),
                  color: Colors.black,
                ),
              },
              shrinkWrap: true,
              data:data.body!)),
    );
  }


}
