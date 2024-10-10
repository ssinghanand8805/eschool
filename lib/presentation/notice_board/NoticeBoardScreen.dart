import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/notice_board/model/NoticeBoard.dart';
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
              return controller.noticeBoardModelObj.value.data != null
                  ? ListView.builder(
                      itemCount:
                          controller.noticeBoardModelObj.value.data?.length,
                      itemBuilder: (context, index) {
                        return _buildTimeTableCard(
                          data:
                              controller.noticeBoardModelObj.value.data![index],
                        );
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

  Widget _buildTimeTableCard({required Data data}) {
    return CommonCard(
        title: data.title!,
        newWidget: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8),
          child: Column(
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
              Row(
                children: [
                  Image.asset(
                    "assets/projectImages/ic_nav_attendance.png",
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Publish Date",
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.publishDate!,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/projectImages/ic_calender.png",
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Notice Date",
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.date!,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/projectImages/ic_nav_teachers.png",
                    height: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Created By",
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    data.createdBy!,
                    style: theme.textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
