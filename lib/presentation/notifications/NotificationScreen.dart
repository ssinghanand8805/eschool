import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';

import 'package:flutter_html/flutter_html.dart';
import '../../core/utils/common_utilities.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/NotificationController.dart';
import 'model/FCMNotifications.dart';
import 'package:visibility_detector/visibility_detector.dart';

// import 'controller/notice_board_controller.dart';

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Notification\nLists',
      imageUrl: 'assets/projectImages/noticepage.png',
      AppbarTitle: 'Notification Lists',
      actionWidget: [
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: IconButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              icon: Icon(
                Icons.info,
                color: Colors.grey.shade600,
                size: 20,
              )),
        )
      ],
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture, //controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            } else {
              return controller.notificationModelObj.value!.length > 0
                  ? ListView.builder(
                      itemCount:
                          controller.notificationModelObj.value!.length ?? 0,
                      itemBuilder: (context, index) {
                        return _buildTimeTableCard(
                            data: controller.notificationModelObj.value![index],
                            index: index);
                      },
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/projectImages/no_data.png",
                        ),
                        Text("No data found!")
                      ],
                    ));
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard(
      {required FCMNotifications data, required int index}) {
    return VisibilityDetector(
      key: Key('notification-$index'),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.5) {
          // Check if more than 50% of the item is visible
          controller.markNotificationAsRead(index);
        }
      },
      child: CommonCardExtended(
          title: data.title!,
          leadingWidget: SizedBox(),
          subtitle: Utils.formatDateString(data.timestamp!.toString()),
          newWidget: Html(style: {
            "body": Style(
              fontSize: FontSize(13.0),
              color: Colors.black,
            ),
          }, shrinkWrap: true, data: data.body!)),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Notice',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notification data will be saved in device and it will be cleared when logged out.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
