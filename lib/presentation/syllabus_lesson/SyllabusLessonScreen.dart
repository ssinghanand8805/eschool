import 'package:flutter/cupertino.dart';
import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/daily_assignment/DailyAssignmentScreen.dart';
import 'package:lerno/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:readmore/readmore.dart';
import '../../apiHelper/toastMessage.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/syllabus_lesson_controller.dart';
import 'model/SyllabusStatus.dart';
// import 'controller/notice_board_controller.dart';

class SyllabusLessonScreen extends StatefulWidget {
  @override
  State<SyllabusLessonScreen> createState() => _SyllabusLessonScreenState();
}

class _SyllabusLessonScreenState extends State<SyllabusLessonScreen> {
  SyllabusLessonController controller = Get.put(SyllabusLessonController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Syllabus\nLesson!',
      imageUrl: 'assets/projectImages/assignmentpage.jpg',
      AppbarTitle: 'Syllabus Lesson',
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
              return controller.syllabusLessonModelObj.value!.length > 0
                  ? ListView.builder(
                      itemCount:
                          controller.syllabusLessonModelObj.value?.length ?? 0,
                      itemBuilder: (context, index) {
                        return _buildTimeTableCard(
                            data:
                                controller.syllabusLessonModelObj.value![index],
                            sr: index + 1);
                      },
                    )
                  : Ui.NoDataWidget();
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required SyllabusLesson data, required int sr}) {
    return CommonCardExtended(
        title: data.name!,
        leadingWidget: Text(
          sr.toString(),
          style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
        ),
        subtitle: data.totalComplete! + " Complete",
        style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
        newWidget:
            _buildTopicCard(topics: data.topics!, parentSr: sr.toString()));
  }

  Widget _buildTopicCard(
      {required List<Topics> topics, required String parentSr}) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      physics: ClampingScrollPhysics(),
      itemCount: topics.length ?? 0,
      itemBuilder: (context, index) {

        return topics.length > 0
            ? Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parentSr + "." + (index + 1).toString(),
                      style:
                          theme.textTheme.titleMedium!.copyWith(fontSize: 13),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Expanded(
                    //   child: Text(
                    //     topics[index].name!,
                    //     style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
                    //     maxLines: 30,
                    //     overflow: TextOverflow.visible,
                    //   ),
                    // ),
                    Expanded(
                      child: ReadMoreText(
                        topics[index].name!,
                        trimMode: TrimMode.Line,
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontSize: 13),
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        moreStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),

                    Spacer(),
                    Text(
                      topics[index].completeDate == null
                          ? "Incomplete"
                          : topics[index].completeDate!,
                      style:
                          theme.textTheme.titleMedium!.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              )
            : Container(color: Colors.red,);
      },
    );
  }
}
