import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/choose_your_option_controller.dart'; // ignore_for_file: must_be_immutable

class ChooseYourOptionScreen extends GetWidget<ChooseYourOptionController> {
  const ChooseYourOptionScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildStackvectorone(),
              SizedBox(height: 52.v),
              Text(
                "msg_choose_your_option".tr,
                style: CustomTextStyles.titleSmallPrimary,
              ),
              SizedBox(height: 48.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTeacher(
                      tuitionOne: ImageConstant.imgStudentMale,
                      teacher: "lbl_student".tr,
                    ),
                    _buildTeacher(
                      tuitionOne: ImageConstant.imgTuition,
                      teacher: "lbl_teacher".tr,
                    )
                  ],
                ),
              ),
              SizedBox(height: 50.v),
              Container(
                height: 100.adaptSize,
                width: 100.adaptSize,
                padding: EdgeInsets.all(20.h),
                decoration: AppDecoration.fillPrimary.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder12,
                ),
                child: CustomImageView(
                  imagePath: ImageConstant.imgPerson,
                  height: 60.adaptSize,
                  width: 60.adaptSize,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 10.v),
              Text(
                "lbl_guest".tr,
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackvectorone() {
    return SizedBox(
      height: 271.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 191.v,
            width: 375.h,
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 203.adaptSize,
              width: 203.adaptSize,
              padding: EdgeInsets.symmetric(
                horizontal: 41.h,
                vertical: 29.v,
              ),
              decoration: AppDecoration.outlineTeal.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder101,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgRectangle133x108,
                height: 133.v,
                width: 108.h,
                alignment: Alignment.topLeft,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildTeacher({
    required String tuitionOne,
    required String teacher,
  }) {
    return Column(
      children: [
        Container(
          height: 100.adaptSize,
          width: 100.adaptSize,
          padding: EdgeInsets.symmetric(
            horizontal: 18.h,
            vertical: 20.v,
          ),
          decoration: AppDecoration.fillPrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: CustomImageView(
            imagePath: tuitionOne,
            height: 60.adaptSize,
            width: 60.adaptSize,
            alignment: Alignment.centerRight,
          ),
        ),
        SizedBox(height: 9.v),
        Text(
          teacher,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: appTheme.black900,
          ),
        )
      ],
    );
  }
}
