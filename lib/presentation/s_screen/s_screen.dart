import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/widgets/CheckForUpdate.dart';
import 'package:lottie/lottie.dart';

import 'controller/s_controller.dart';

class SScreen extends StatefulWidget {
  const SScreen({Key? key}) : super(key: key);

  @override
  _SScreenState createState() => _SScreenState();
}

class _SScreenState extends State<SScreen> {
  final SController controller = Get.put(SController());

  @override
  void initState() {
    super.initState();

    Updater().checkVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade50,
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Obx(() {
                    print("dWWWWWWW${controller.splashScreenImage.value}");

                    return controller.isSplashAsset.isTrue
                        ? Container(
                            height: 350,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    controller.splashScreenImage.value),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Container(
                            height: 350,
                            child: Image.file(
                                File(controller.splashScreenImage.value)),
                          );
                  }),
                ),
                Lottie.asset(
                  "assets/images/loading.json",
                  width: 150,
                  height: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
