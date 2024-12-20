import 'package:device_info_plus/device_info_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/mydocuments/model/MyDocuments.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import '../../apiHelper/GlobalData.dart';
import '../../apiHelper/userData.dart';
import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/mydocuments_controller.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
// import 'controller/notice_board_controller.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
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
              return controller.documentsModelObj.value!.length > 0
                  ? ListView.builder(
                      itemCount:
                          controller.documentsModelObj.value?.length ?? 0,
                      itemBuilder: (context, index) {
                        return _buildTimeTableCard(
                          data: controller.documentsModelObj.value![index],
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
              ;
            }
          },
        );
      },
    );
  }

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  Widget _buildTimeTableCard({required Documents data}) {
    return CommonCardExtended(
        title: data.title!,
        leadingWidget: Image.asset(
          "assets/projectImages/ic_clipboard_filled.png",
          height: 22,
        ),
        subtitle: "",
        newWidget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/projectImages/ic_file.png",
              height: 20,
            ),
            SizedBox(width: 20,),
            Text(
              data.doc!.split("!")[1].toString(),
              style: theme.textTheme.titleMedium!.copyWith(fontSize: 12.5),
            ),
            Spacer(),
            textWithIcon(
              onTap: () async {
                onPressDownload(data.doc!, data.doc!.split("!")[1].toString());
              },
            ),
          ],
        )

        // ListTile(
        //   leading: Image.asset(
        //     "assets/projectImages/ic_file.png",
        //     height: 20,
        //   ),
        //   title: Text(
        //     data.doc!.split("!")[1].toString(),
        //     style: theme.textTheme.titleMedium!.copyWith(fontSize: 12.5),
        //   ),
        //   trailing:
        //   textWithIcon(
        //       onTap: () async {
        //         onPressDownload(data.doc!, data.doc!.split("!")[1].toString());
        //       },
        //       icon: Icons.download,
        //       iconColor: Colors.blue,
        //       text: "Download"),
        // )

        );
  }

  Widget textWithIcon({
    required Future<void> Function() onTap,
  }) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    return SizedBox(
      height: 50,
      width: 50,
      child: RoundedLoadingButton(
        controller: _btnController,
        onPressed: () async {
          try {
            await onTap();

            _btnController.success();
          } catch (error) {
            _btnController.error();

            Future.delayed(Duration(seconds: 2), () {
              _btnController.reset();
            });
          }
        },
        color: Colors.blue, // Background color of the button
        successColor: Colors.green, // Color when success state is achieved
        errorColor: Colors.red,
        height: 50,
        width: 50,
        borderRadius: 30,
        child: Icon(
          Icons.download,
          size: 15,
          color: Colors.white,
        ), // Color when an error occurs
      ),
    );
  }
  static Future<bool> _requestGalleryPermission() async {
    // Check current permission status
    var status = await Permission.photos.status;

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // Request permission
      status = await Permission.photos.request();
      if (status.isGranted) {
        return true;
      }
    } else if (status.isPermanentlyDenied) {
      // Suggest the user to open app settings
      openAppSettings();
    }

    return false;
  }
  onDownloadMethod(path)
  {
    print("PPPPPPP${path}");
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
  }
  Future<void> onPressDownload(String fileUrl,String name) async {
    print("@@@@@@@@@@@@@@@$fileUrl");

    bool permissionStatus;
    if(Platform.isAndroid)
    {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;

      if (deviceInfo.version.sdkInt > 32) {
        permissionStatus = await Permission.photos.request().isGranted;
      } else {
        permissionStatus = await Permission.storage.request().isGranted;
      }
    }
    else
    {
      permissionStatus = true;
    }


    if (permissionStatus) {
      print("STATUS GRANTED ");

      Fluttertoast.showToast(
        msg: "Download started...",
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      if(Platform.isAndroid)
      {
        FileDownloader.downloadFile(
          url: fileUrl,
          name:name,
          onProgress: (String? fileName, double? progress) {
          },
          onDownloadCompleted: (String path) {
            onDownloadMethod(path);
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
      }
      else
      {
        try {
          bool hasPermission = await _requestGalleryPermission();

          if (!hasPermission) {
            Fluttertoast.showToast(
              msg: 'Gallery permission denied',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            return;

          }

          var appDocDir = await getTemporaryDirectory();

          // Extract the file name and extension from the URL
          String fileName = path.basename(fileUrl); // This will give you 'temp.gif'
            String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
            UserData userData = Get.put(UserData());
          String fullUrl = baseUrlFromPref +
              "uploads/student_documents/" +
              userData.getUserStudentId +
              "/" +
              fileUrl;

          // Create the full save path
          String savePath = path.join(appDocDir.path, fileName);
          await Dio().download(fullUrl, savePath);
          final result =
          await ImageGallerySaver.saveFile(savePath, isReturnPathOfIOS: true);
          print(result);
          // print(result);

          onDownloadMethod(savePath);

          return result['isSuccess'] ?? false;
        } catch (e) {
          print('Error saving file: $e');
          Fluttertoast.showToast(
            msg: 'Error saving file: $e',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }

      // Proceed with file download

    } else {
      openAppSettings(); // Open app settings if permission is denied
      print("STATUS DENIED ");
    }
  }

  // Future<void> onPressDownload(String fileUrl, String name) async {
  //   String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
  //   UserData userData = Get.put(UserData());
  //   String fullUrl = baseUrlFromPref +
  //       "uploads/student_documents/" +
  //       userData.getUserStudentId +
  //       "/" +
  //       fileUrl;
  //
  //   print("@@@@@@@@@@@@@@@$fullUrl");
  //
  //   bool permissionStatus;
  //   final deviceInfo = await DeviceInfoPlugin().androidInfo;
  //
  //   if (deviceInfo.version.sdkInt > 32) {
  //     permissionStatus = await Permission.photos.request().isGranted;
  //   } else {
  //     permissionStatus = await Permission.storage.request().isGranted;
  //   }
  //
  //   if (permissionStatus) {
  //     print("STATUS GRANTED ");
  //     Fluttertoast.showToast(
  //       msg: "Download started...",
  //       toastLength: Toast.LENGTH_SHORT,
  //       backgroundColor: Colors.green,
  //       gravity: ToastGravity.BOTTOM,
  //     );
  //
  //     FileDownloader.downloadFile(
  //       url: fullUrl,
  //       name: name,
  //       onProgress: (String? fileName, double? progress) {
  //         print('FILE ${name} HAS PROGRESS $progress');
  //       },
  //       onDownloadCompleted: (String path) {
  //         print('FILE DOWNLOADED TO PATH: $path');
  //         Fluttertoast.showToast(
  //           msg: "Download complete!",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.green,
  //           gravity: ToastGravity.BOTTOM,
  //         );
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20), // Rounded corners
  //               ),
  //               title: Row(
  //                 children: [
  //                   Icon(Icons.download_done, color: Colors.green), // Icon
  //                   SizedBox(width: 10),
  //                   Text(
  //                     'Download Complete',
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               content: Text(
  //                 'Your file has been downloaded. Do you want to open it?',
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: Colors.grey[800],
  //                 ),
  //               ),
  //               actions: [
  //                 TextButton(
  //                   style: TextButton.styleFrom(
  //                     backgroundColor: Colors.red[500],
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                     child: Text(
  //                       'Cancel',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 TextButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: theme.primaryColor,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     OpenFilex.open(path);
  //                     print("bbhbbhbbbhbhhb${path}");
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                     child: Text(
  //                       'Open',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       },
  //       onDownloadError: (String error) {
  //         print('DOWNLOAD ERROR: $error');
  //         Fluttertoast.showToast(
  //           msg: "Download failed: $error",
  //           toastLength: Toast.LENGTH_SHORT,
  //           backgroundColor: Colors.red,
  //           gravity: ToastGravity.BOTTOM,
  //         );
  //       },
  //     );
  //   } else {
  //     openAppSettings();
  //     print("STATUS DENIED ");
  //   }
  // }
}
