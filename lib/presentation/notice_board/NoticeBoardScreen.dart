import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:learnladder/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/notice_board_controller.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  State<NoticeBoardScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<NoticeBoardScreen> {
  NoticeBoardController controller = Get.put(NoticeBoardController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Notice\Board!',
      imageUrl: 'assets/projectImages/noticepage.png',
      AppbarTitle: 'Notice Board',
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
              return ListView.builder(
                itemCount:
                    controller.noticeBoardModelObj.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.noticeBoardModelObj.value.data!.length > 0
                      ? _buildTimeTableCard(
                          data:
                              controller.noticeBoardModelObj.value.data![index],
                        )
                      : Center(
                          child: Image.asset(
                          "assets/projectImages/no_data.png",
                          height: 100,
                        ));
                },
              );
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required Data data}) {
    return CommonCard(
        title: data.title!,
        newWidget: Column(
          children: [
            Html(
              data: data.message!,
              style: {
                "body": Style(
                  fontSize: FontSize(15.0),
                  color: Colors.black,
                ),
              },
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today_outlined,
                size: 18,
              ),
              title: Text(
                "Publish Date",
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                data.publishDate!,
                style: theme.textTheme.titleMedium,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_today,
                size: 18,
              ),
              title: Text(
                "Notice Date",
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                data.date!,
                style: theme.textTheme.titleMedium,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                size: 18,
              ),
              title: Text(
                "Created By",
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                data.createdBy!,
                style: theme.textTheme.titleMedium,
              ),
            )
          ],
        ));
  }
}
