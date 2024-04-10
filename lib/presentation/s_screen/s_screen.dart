import 'package:flutter/material.dart';
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
        body: SizedBox(
          height: SizeUtils.height,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgGroup,
                height: 812.v,
                width: 375.h,
                alignment: Alignment.center,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 97.h,
                      right: 104.h,
                      bottom: 45.v,
                    ),
                    decoration: AppDecoration.outlineBlack,
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle,
                          height: 212.v,
                          width: 173.h,
                        ),
                        SizedBox(height: 305.v),
                        Text(
                          "msg_powered_by_xyz_com".tr,
                          style: CustomTextStyles.bodySmallLatoOnPrimary,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
