import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'controller/teacher_login_controller.dart';
import 'models/teacher_login_item_model.dart';
import 'widgets/teacher_login_item_widget.dart'; // ignore_for_file: must_be_immutable

class TeacherLoginScreen extends GetWidget<TeacherLoginController> {
  const TeacherLoginScreen({Key? key})
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgComponent2,
                  height: 223.v,
                  width: 375.h,
                ),
                SizedBox(height: 18.v),
                _buildColumnwelcomeme(),
                SizedBox(height: 58.v),
                _buildTeacherlogin(),
                SizedBox(height: 28.v)
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnwelcomeme() {
    return Container(
      width: 338.h,
      margin: EdgeInsets.symmetric(horizontal: 18.h),
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 7.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 2.v),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_welcome_message".tr,
                style: CustomTextStyles.titleSmallSemiBold,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowLeft,
                height: 13.v,
                width: 15.h,
                margin: EdgeInsets.only(
                  left: 9.h,
                  top: 2.v,
                  bottom: 5.v,
                ),
              )
            ],
          ),
          SizedBox(height: 8.v),
          Container(
            width: 284.h,
            margin: EdgeInsets.only(right: 23.h),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "msg_the_standard_lorem2".tr,
                    style: CustomTextStyles.bodySmallOnPrimary,
                  ),
                  TextSpan(
                    text: "msg_lorem_ipsum_dolor".tr,
                    style: CustomTextStyles.bodySmallOnPrimaryLight,
                  )
                ],
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTeacherlogin() {
    return Padding(
      padding: EdgeInsets.only(
        left: 17.h,
        right: 14.h,
      ),
      child: Obx(
        () => GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 131.v,
            crossAxisCount: 3,
            mainAxisSpacing: 18.h,
            crossAxisSpacing: 18.h,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.teacherLoginModelObj.value.teacherLoginItemList.value.length,
          itemBuilder: (context, index) {
            TeacherLoginItemModel model = controller
                .teacherLoginModelObj.value.teacherLoginItemList.value[index];
            return TeacherLoginItemWidget(
              model,
            );
          },
        ),
      ),
    );
  }
}
