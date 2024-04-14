import 'dart:io';

import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:learnladder/presentation/download_center/model/videoModal.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';
import 'package:learnladder/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apiHelper/Constants.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/download_center_controller.dart';
import 'model/DownloadCenter.dart';
import 'package:http/http.dart' as http;
// import 'controller/notice_board_controller.dart';

class DownloadCenterScreen extends StatefulWidget {
  @override
  State<DownloadCenterScreen> createState() => _DownloadCenterScreenState();
}

class _DownloadCenterScreenState extends State<DownloadCenterScreen> {
  DownloadCenterController controller = Get.put(DownloadCenterController());

  @override
  void initState() {
    // TODO: implement initState
  }

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
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8)),
                        color: Colors.green.shade100,
                      ),
                      child: TabBar(
                        labelStyle: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14),
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
                          _buildVideoTab(context),
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
  }

  Widget _buildContentsTab(BuildContext context) {
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
                itemCount: controller.downloadModelObj.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.downloadModelObj.length > 0
                      ? _buildDownloadItem(
                          data: controller.downloadModelObj[index],
                          uploadContents: controller.downloadModelObj.subject
                              .value![index].uploadContents![index],
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

  Widget _buildVideoTab(BuildContext context) {
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
                    controller.videoDataModalObj.value.result!.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.videoDataModalObj.value.result!.length > 0
                      ? _buildVideoTutorialTab(
                          data:
                              controller.videoDataModalObj.value.result![index],
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

  Future<void> _launchInBrowser(Uri url) async {
    if (await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildVideoTutorialTab({required Result data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          _launchInBrowser(Uri.parse(data.videoLink.toString()));
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(
                0.3,
                3.0,
              ),
              blurRadius: 4.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    Constants.imagesUrl + data.dirPath! + data.imgName!,
                    fit: BoxFit.cover),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    data.title.toString(),
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description: ",
                      style: theme.textTheme.titleMedium!,
                    ),
                    Flexible(
                      child: Text(
                        data.description.toString(),
                        style: theme.textTheme.titleMedium!,
                      ),
                    ),
                  ],
                ),
                InfoRow(
                    title: "createdBy",
                    value: "${data.name} ${data!.surname}(${data.employeeId})"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadItem(
      {required DownloadCenter data, required UploadContents uploadContents}) {
    return CommonCardExtended(
      title: data.title.toString(),
      leadingWidget: SizedBox(),
      subtitle: '',
      newWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(title: "Share Date", value: data.shareDate.toString()),
            InfoRow(title: "Valid Upto", value: data.validUpto.toString()),
            InfoRow(
                title: "Shared By",
                value: "${data.name} ${data!.surname}(${data.employeeId})"),
            InfoRow(title: "Upload Date", value: data.createdAt.toString()),
            customDownloadButton(
              onPressed: () {
                showDynamicBottomSheet(context,
                    title: uploadContents.realName.toString(),
                    fileName: uploadContents.realName.toString(),
                    fileUrl:
                        "${Constants.imagesUrl + uploadContents.dirPath! + uploadContents.imgName!}");
              },
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              iconColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  void showDynamicBottomSheet(BuildContext context,
      {String? title, String? fileUrl, String? fileName}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero,
          ),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.drive_file_move_sharp,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Attachment',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: controller.downloadModelObj.subject.value!.length > 0
                    ? ListView.builder(
                        itemCount:
                            controller.downloadModelObj.subject.value!.length ??
                                0,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(title.toString()),
                            trailing: IconButton(
                              onPressed: () {
                                downloadFileFromAPI(fileUrl!, fileName!);
                              },
                              icon: Icon(
                                Icons.download,
                                size: 15,
                                color: Colors.blue,
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Image.asset(
                        "assets/projectImages/no_data.png",
                        height: 100,
                      )),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> downloadFileFromAPI(String fileUrl, String fileName) async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$fileName';
      final response = await http.get(Uri.parse(fileUrl));
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded: $filePath');
      await OpenFile.open(filePath);

    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  Widget customDownloadButton({
    required VoidCallback onPressed,
    Color? backgroundColor = Colors.blue,
    Color? textColor = Colors.white,
    Color? iconColor = Colors.white,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.download,
            color: iconColor,
            size: 15,
          ),
          SizedBox(width: 8),
          Text(
            "Download",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
