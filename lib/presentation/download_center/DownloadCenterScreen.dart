import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/download_center/model/videoModal.dart';
import 'package:lerno/presentation/homework/HomeworkScreen.dart';
import 'package:lerno/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../apiHelper/Constants.dart';
import '../../apiHelper/GlobalData.dart';
import '../../apiHelper/userData.dart';
import '../../core/utils/common_utilities.dart';
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
                        color: theme.primaryColor,
                      ),
                      child: TabBar(
                        labelStyle: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 14),
                        tabs: [
                          Tab(text: 'CONTENTS'),
                          Tab(text: 'VIDEO TUTORIAL'),
                        ],
                        indicatorColor: theme.primaryColorDark,
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
        return RefreshIndicator(
          onRefresh: controller.refreshDataImage,
          child: FutureBuilder(
            future: controller.fetchDataFuture, //controller.getData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              } else {
                return controller.downloadModelObj.length > 0
                    ? ListView.builder(
                        itemCount: controller.downloadModelObj.length ?? 0,
                        itemBuilder: (context, index) {
                          print(
                              "##############${controller.downloadModelObj[index]}");
                          return _buildDownloadItem(
                            data: controller.downloadModelObj[index],
                            uploadContents: controller.downloadModelObj.subject
                                .value![index].uploadContents!,
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
          ),
        );
      },
    );
  }

  Widget _buildVideoTab(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return RefreshIndicator(
          onRefresh: controller.refreshDataVideo,
          child: FutureBuilder(
            future: controller.fetchDataFuture, //controller.getData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              } else {
                return controller.videoDataModalObj.value.result!.length > 0
                    ? ListView.builder(
                        itemCount:
                            controller.videoDataModalObj.value.result!.length ??
                                0,
                        itemBuilder: (context, index) {
                          return _buildVideoTutorialTab(
                            data: controller
                                .videoDataModalObj.value.result![index],
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
          ),
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  data.title!,
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Description: ",
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                  ),
                  Flexible(
                    child: Text(
                      data.description.toString(),
                      style: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: InkWell(
                      onTap: () {
                        _launchInBrowser(Uri.parse(data.videoLink.toString()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(7), // Rounded corners
                          border: Border.all(
                            color: Colors.blue, // Border color
                            width: 1, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal:
                                  12.0), // Padding for a button-like look
                          child: Text(
                            "View video",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              // Bold text
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InfoRow(
                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                  style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                  title: "createdBy",
                  value: "${data.name} ${data!.surname}(${data.employeeId})"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadItem(
      {required DownloadCenter data,
      required List<UploadContents> uploadContents}) {
    DateTime dateTime = DateTime.parse(data.createdAt.toString());
    String formattedTime = DateFormat.jm().format(dateTime);
    return CommonCardExtended(
      title: data.title.toString().capitalize!,
      leadingWidget: SizedBox(),
      subtitle: '',
      newWidget: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoRow(
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                title: "Share Date",
                value: "${Utils.formatDateString(data.shareDate!.toString())}"),
            InfoRow(
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                title: "Valid Upto",
                value: data.validUpto != null
                    ? Utils.formatDateString("${data.validUpto!}")
                    : ""),
            InfoRow(
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                title: "Shared By",
                value: "${data.name} ${data!.surname}(${data.employeeId})"),
            InfoRow(
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                title: "Upload Date",
                value: Utils.formatDateString("${data.createdAt!}") +
                    " ${formattedTime}"),
            customDownloadButton(
              onPressed: () {
                showDynamicBottomSheet(context, data: uploadContents!);
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
      {required List<UploadContents> data}) {

    final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Rounded top corners for the bottom sheet
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: data.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes the shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                              size: 20.0,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                data[index].realName.toString(),
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundedLoadingButton(
                            controller: _btnController,
                            onPressed: () async {
                              await onPressDownload(
                                "${baseUrlFromPref + data[index].dirPath! + data[index].imgName!}",
                              );
                              _btnController.success();
                            },
                            color: Colors.blue,
                            successColor: theme.primaryColorDark,
                            width: 60,
                            height: 60,
                            borderRadius: 30,
                            child: Icon(
                              Icons.download,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),

                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/projectImages/no_data.png",
                          height: 150, // Adjust size based on the asset
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          "No data found!",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<void> onPressDownload(String fileUrl) async {
    print("@@@@@@@@@@@@@@@$fileUrl");

    bool permissionStatus;
    final deviceInfo = await DeviceInfoPlugin().androidInfo;

    if (deviceInfo.version.sdkInt > 32) {
      permissionStatus = await Permission.photos.request().isGranted;
    } else {
      permissionStatus = await Permission.storage.request().isGranted;
    }

    if (permissionStatus) {
      print("STATUS GRANTED ");

      Fluttertoast.showToast(
        msg: "Download started...",
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      // Proceed with file download
      FileDownloader.downloadFile(
        url: fileUrl,
        onProgress: (String? fileName, double? progress) {
        },
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: $path');
          Fluttertoast.showToast(
            msg: "Download complete!",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            gravity: ToastGravity.BOTTOM,
          );
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                title: Row(
                  children: [
                    Icon(Icons.download_done, color: theme.primaryColor), // Icon
                    SizedBox(width: 10),
                    Text(
                      'Download Complete',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                content: Text(
                  'Your file has been downloaded. Do you want to open it?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800], // Custom content color
                  ),
                ),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red[500], // Custom button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColorDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      OpenFilex.open(path);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Open',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');

          // Show toast if there's an error
          Fluttertoast.showToast(
            msg: "Download failed: $error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        },
      );
    } else {
      openAppSettings(); // Open app settings if permission is denied
      print("STATUS DENIED ");
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
        backgroundColor: theme.primaryColorDark,
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
          Text("Download",
              style: theme.textTheme.titleSmall!
                  .copyWith(fontSize: 12, color: Colors.white)),
        ],
      ),
    );
  }
}
