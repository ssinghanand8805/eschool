import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../core/app_export.dart';
import 'controller/s_controller.dart'; // ignore_for_file: must_be_immutable

class SScreen extends GetWidget<SController> {
  const SScreen({Key? key})
      : super(
          key: key,
        );


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
                    return controller.isSplashAsset.isTrue ? Container(
                    height: 350,
                    decoration:  BoxDecoration(
                        image: DecorationImage(
                            image:  AssetImage(controller.splashScreenImage.value) ,
                            fit: BoxFit.contain
                        )
                    ) ,
                  ): Container(
                        height: 350,
                        child: Image.file(File(controller.splashScreenImage.value)));}),
                ),
                Lottie.asset("assets/images/loading.json",width: 150,height: 150),

              ],
            ),
          ],
        ),
      ),
    );
  }


}
