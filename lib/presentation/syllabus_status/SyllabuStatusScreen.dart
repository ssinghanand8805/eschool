import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/syllabus_status_controller.dart';
import 'model/SyllabusStatus.dart';
// import 'controller/notice_board_controller.dart';

class SyllabuStatusScreen extends StatefulWidget {
  @override
  State<SyllabuStatusScreen> createState() => _SyllabuStatusScreenState();
}

class _SyllabuStatusScreenState extends State<SyllabuStatusScreen> {
  SyllabusStatusController controller = Get.put(SyllabusStatusController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Syllabus\nStatus!',
      imageUrl: 'assets/projectImages/assignmentpage.jpg',
      AppbarTitle: 'Syllabus Status',
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
                    controller.syllabusStatusModelObj.value.subjects?.length ??
                        0,
                itemBuilder: (context, index) {
                  return controller
                              .syllabusStatusModelObj.value.subjects!.length >
                          0
                      ? _buildTimeTableCard(
                          data: controller
                              .syllabusStatusModelObj.value.subjects![index],
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

  Widget _buildTimeTableCard({required Subjects data}) {
    return CommonCardExtended(
        title: data.subjectName! + " ( ${data.subjectCode!} )",
        leadingWidget: Icon(Icons.bookmark_added_outlined),
        subtitle: data.totalComplete! + " Complete",
        style: theme.textTheme.titleMedium,
        newWidget: ListTile(
          leading: Icon(Icons.drag_handle_rounded,size: 18,),
          title: Text("Lession Plan",style: theme.textTheme.titleMedium,),
          onTap: () {
            onLessionPlanTap(data.subjectGroupSubjectId!, data.classSectionId!);
          },
        )); //IconButton(onPressed: onPressed, icon: Icon(Icons.drag_handle_rounded)))  ;
  }

  void onLessionPlanTap(String s1, String sw2) {
    print(s1);
    print(sw2);
    Get.toNamed("/syllabus_lesson", arguments: {
      "subjectGroupSubjectId": s1,
      "classSectionId": sw2,
    });
  }
}
