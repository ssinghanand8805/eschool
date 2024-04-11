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
      imageUrl: 'assets/projectImages/assignmentpage.jpg',
      AppbarTitle: 'Notice Board',
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
                itemCount: controller.noticeBoardModelObj.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.noticeBoardModelObj.value.data!.length > 0 ? _buildTimeTableCard(
                    data: controller.noticeBoardModelObj.value.data![index],
                  ): Center(child: Image.asset("assets/projectImages/no_data.png",height: 100,));
                },
              );;

            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required Data data}) {
    return CommonCard(
        title: data.title!,
        newWidget:  Column(
          children: [
            Html( data : data.message!),
            ListTile(leading: Icon(Icons.calendar_today_outlined),title: Text("Publish Date"),subtitle: Text(data.publishDate!),),
            ListTile(leading: Icon(Icons.calendar_today),title: Text("Notice Date"),subtitle: Text(data.date!),),
            ListTile(leading: Icon(Icons.person),title: Text("Created By"),subtitle: Text(data.createdBy!),)

          ],
        ))  ;
  }
}
