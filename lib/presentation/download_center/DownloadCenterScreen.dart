import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';
import 'package:learnladder/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/download_center_controller.dart';

// import 'controller/notice_board_controller.dart';


class  DownloadCenterScreen extends StatefulWidget {
  @override
  State< DownloadCenterScreen> createState() => _DownloadCenterScreenState();
}

class _DownloadCenterScreenState extends State< DownloadCenterScreen> {
  DownloadCenterController controller = Get.put(DownloadCenterController());



  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Download \nCenter is here!',
      imageUrl: 'assets/projectImages/downloadpage.jpg',
      AppbarTitle: 'Download Center',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(
                        3.0,
                        5.0,
                      ),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                        color: Colors.green.shade100,
                      ),
                      child: TabBar(

                        labelStyle:theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600,fontSize: 14),
                        tabs: [
                          Tab(text: 'CONTENTS'),
                          Tab(text: 'VIDEO TUTORIAL'),
                        ],
                        indicatorColor: Colors.orange,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(

                        children: [
                          _buildContentsTab(context),
                          _buildVideoTutorialTab(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return GetBuilder(
    //   init: controller,
    //   builder: (_) {
    //     return FutureBuilder(
    //       future:  controller.fetchDataFuture,//controller.getData(context),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState != ConnectionState.done) {
    //           return CustomLoader(); // CustomLoader();
    //         }
    //         else {
    //           return  ListView.builder(
    //             itemCount: controller.syllabusStatusModelObj.value.subjects?.length ?? 0,
    //             itemBuilder: (context, index) {
    //               return controller.syllabusStatusModelObj.value.subjects!.length > 0 ? _buildTimeTableCard(
    //                 data: controller.syllabusStatusModelObj.value.subjects![index],
    //               ): Center(child: Image.asset("assets/projectImages/no_data.png",height: 100,));
    //             },
    //           );;
    //
    //         }
    //       },
    //     );
    //   },
    // );
  }

  // Widget _buildTimeTableCard({required Subjects data}) {
  //   return CommonCardExtended(
  //       title: data.subjectName! + " ( ${data.subjectCode!} )",
  //       leadingWidget: Icon(Icons.bookmark_added_outlined),
  //       subtitle: data.totalComplete! + "Complete",
  //       newWidget:  ListTile(leading: Icon(Icons.drag_handle_rounded),title: Text("Lession Plan"),onTap: () { onLessionPlanTap(data.subjectGroupSubjectId!,data.classSectionId!) ;},));//IconButton(onPressed: onPressed, icon: Icon(Icons.drag_handle_rounded)))  ;
  // }
  void _onLessionPlanTap(String s1, String sw2)
  {
    print(s1);
    print(sw2);
    Get.toNamed("/syllabus_lesson",arguments: {
      "subjectGroupSubjectId": s1,
      "classSectionId": sw2,
    } );
  }


  Widget _buildContentsTab(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDownloadItem(
                    title: 'MATHEMATICAL REASONING',
                    shareDate: '04/18/2023',
                    validUpto: '04/26/2023',
                    sharedBy: 'Joe Black (9000)',
                    description:
                    'Mathematical reasoning or the principle of mathematical reasoning is a part of mathematics where we determine the truth values of the given statements.',
                    uploadDate: '04/01/2023',
                    attachment:
                    'MATHEMATICAL REASONING in 1 Shot | From Zero to Hero | JEE Main & Advanced',
                  ),
                  SizedBox(height: 16.0),
                  _buildDownloadItem(
                    title: 'English Assignment',
                    shareDate: '04/12/2023',
                    validUpto: '04/22/2023',
                    sharedBy: 'Joe Black (9000)',
                    description: 'English Assignment',
                    uploadDate: '04/01/2023',
                    attachment: 'CBSE Class 5 Englis Activities (1).pdf',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVideoTutorialTab() {
    return Center(
      child: Text(
        'Video Tutorial Content',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildDownloadItem({
    required String title,
    required String shareDate,
    required String validUpto,
    required String sharedBy,
    required String description,
    required String uploadDate,
    required String attachment,
  }) {
    return CommonCardExtended(
      title:title,
      leadingWidget: SizedBox(),
      subtitle: '',
      newWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(title: "Share Date", value: shareDate),
            InfoRow(title: "Valid Upto", value: validUpto),
            InfoRow(title: "Shared By", value: sharedBy),
            InfoRow(title: "Upload Date", value: uploadDate),

            if (attachment.isNotEmpty) ...[
              SizedBox(height: 8.0),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      attachment,
                        style: theme.textTheme.titleMedium!.copyWith(color: Colors.blue)
                    ),
                  ),

                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.download,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "Download",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
