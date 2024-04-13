import 'package:learnladder/apiHelper/Constants.dart';
import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:learnladder/presentation/mydocuments/model/MyDocuments.dart';
import 'package:learnladder/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../apiHelper/userData.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/mydocuments_controller.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'controller/notice_board_controller.dart';

class MyDocumentsScreen extends StatefulWidget {
  @override
  State<MyDocumentsScreen> createState() => _SyllabuStatusScreenState();
}

class _SyllabuStatusScreenState extends State<MyDocumentsScreen> {
  MyDocumentsController controller = Get.put(MyDocumentsController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'My Documents',
      imageUrl: 'assets/projectImages/documentpage.jpg',
      AppbarTitle: 'My Documents',
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
                itemCount: controller.documentsModelObj.value?.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.documentsModelObj.value!.length > 0
                      ? _buildTimeTableCard(
                          data: controller.documentsModelObj.value![index],
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

  Widget _buildTimeTableCard({required Documents data}) {
    return CommonCardExtended(
        title: data.title!,
        leadingWidget: Icon(Icons.list_alt_outlined),
        subtitle: "",
        newWidget: ListTile(
            leading: Icon(Icons.file_present),
            title: Text(data.doc!.split("!")[1].toString()),
            trailing: IconButton(
              icon: Icon(
                Icons.download,
                color: Colors.lightBlue,
              ),
              onPressed: () {
                onPressDownload(data.doc!, data.doc!.split("!")[1].toString());
              },
            ))); //onTap: () { onLessionPlanTap(data.subjectGroupSubjectId!,data.classSectionId!) ;}
  }

  void onPressDownload(String fileUrl, String name) {
    UserData userData = Get.put(UserData());
    String fullUrl = Constants.imagesUrl +
        "uploads/student_documents/" +
        userData.getUserStudentId +
        "/" +
        fileUrl;
    print(fullUrl);
    FileDownloader.downloadFile(
        url: fullUrl,
        name: name, //(optional)
        onProgress: (String? fileName, double? progress) {
          print('FILE ${name} HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });
  }
}
