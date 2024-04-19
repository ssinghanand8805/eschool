import 'package:learnladder/apiHelper/Constants.dart';
import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:learnladder/presentation/mydocuments/model/MyDocuments.dart';
import 'package:learnladder/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../apiHelper/GlobalData.dart';
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
              return controller.documentsModelObj.value!.length > 0?ListView.builder(
                itemCount: controller.documentsModelObj.value?.length ?? 0,
                itemBuilder: (context, index) {
                  return  _buildTimeTableCard(
                          data: controller.documentsModelObj.value![index],
                        );

                },
              ):Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/projectImages/no_data.png",
                      ),
                      Text("No data found!")
                    ],
                  ));
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
        leadingWidget: Image.asset(
          "assets/projectImages/ic_clipboard_filled.png",
          height: 22,
        ),
        subtitle: "",
        newWidget: ListTile(
          leading: Image.asset(
            "assets/projectImages/ic_file.png",
            height: 20,
          ),
          title: Text(
            data.doc!.split("!")[1].toString(),
            style: theme.textTheme.titleMedium!.copyWith(fontSize: 12.5),
          ),
          trailing: textWithIcon(
              onTap: () {
                onPressDownload(data.doc!, data.doc!.split("!")[1].toString());
              },
              icon: Icons.download,
              iconColor: Colors.blue,
              text: "Download"),
          // IconButton(
          //   icon: Icon(
          //     Icons.download,
          //     color: Colors.lightBlue,
          //     size: 16,
          //   ),
          //   onPressed: () {
          //     onPressDownload(data.doc!, data.doc!.split("!")[1].toString());
          //   },
          // )
        )); //onTap: () { onLessionPlanTap(data.subjectGroupSubjectId!,data.classSectionId!) ;}
  }

  Widget textWithIcon({
    required IconData icon,
    required VoidCallback onTap,
    required String text,
    double iconSize = 14.0,
    Color iconColor = Colors.blue,
    TextStyle? textStyle,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          SizedBox(width: 8.0),
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 12.5,
                  color: iconColor,
                ),
          ),
        ],
      ),
    );
  }

  void onPressDownload(String fileUrl, String name) {
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    UserData userData = Get.put(UserData());
    String fullUrl = baseUrlFromPref +
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
