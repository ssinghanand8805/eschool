import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:lerno/widgets/custom_elevated_button.dart';
import 'package:lottie/lottie.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

Version latestVersion = Version(0, 0, 0);
Version currentVersion = Version(0, 0, 0);

class Updater {
  static const APP_STORE_URL =
      'https://apps.apple.com/us/app/ct-employee-portal/id1586282555';
  static const PLAY_STORE_URL =
      'https://play.google.com/store/apps/details?id=lerno.info.apps';


  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate()
            .catchError((e) => Fluttertoast.showToast(msg: e.toString()));
      }
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  checkVersion(context) async {
    if (Platform.isAndroid) {
      checkForUpdate();
    } else {
      final newVersion = NewVersionPlus();

      VersionStatus? status = await newVersion.getVersionStatus();
      if (status != null) {
        try {
          currentVersion = Version.parse(status.localVersion.toString());
          latestVersion = Version.parse(status.storeVersion.toString());

          if (latestVersion > currentVersion) {
            showUpdateDialog(
              latestVersion,
              context,
            );
          }
        } catch (e) {
          print(e);
          var retry = await apiDialogue(
              context, 'Alert', 'Internet connection issue, try to reconnect.',
              showCanCelButton: true);
          if (retry) {
            var data = await checkVersion(context);
            return data;
          } else {
            return "Try Again...";
          }
        }
      }
    }
  }


  void showUpdateDialog(latestVersion,context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 150,
                    child: Lottie.asset(
                      'assets/projectImages/update.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'New Version Available!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Version $latestVersion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Looks like you have an older version of the app. '
                        'Please update to get the latest features and improved experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomElevatedButton(
                    buttonTextStyle: TextStyle(color: Colors.white),
                    text:
                      'Update Now',
                    onPressed: () {
                      if (Platform.isAndroid) {
                        _launchURL(PLAY_STORE_URL);
                      } else if (Platform.isIOS) {
                        _launchURL(APP_STORE_URL);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  apiDialogue(context, alert, msg, {bool? showCanCelButton}) {
    var canPressOk = true;
    var retry = false;
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return StatefulBuilder(builder: (context, setState) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: WillPopScope(
                  onWillPop: () {
                    return Future.value(false);
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                            child: Lottie.asset('assets/projectImages/noInterNet.json'),
                          ),
                          Text(
                            msg.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(child: SizedBox()),
                              Visibility(
                                visible: showCanCelButton ?? true,
                                child: Expanded(
                                    flex: 2,
                                    child: CustomElevatedButton(
                                      buttonTextStyle: TextStyle(color: Colors.white),
                                      onPressed: () {
                                        if (canPressOk) {
                                          canPressOk = false;
                                          Navigator.pop(context);
                                          retry = false;
                                        }
                                      },
                                      text:'Cancel',
                                    )),
                              ),
                              Visibility(
                                visible: showCanCelButton ?? true,
                                child: Expanded(child: SizedBox()),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: CustomElevatedButton(
                                      buttonTextStyle: TextStyle(color: Colors.white),
                                      onPressed: () {
                                        if (canPressOk) {
                                          canPressOk = false;
                                          Navigator.pop(context);
                                          retry = true;
                                        }
                                      },
                                      text:'Retry')),
                              Expanded(child: SizedBox()),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }).then((val) {
      canPressOk = false;
      return retry;
    });
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
