import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../controller/teacher_login_controller.dart';
import '../models/teacher_login_item_model.dart'; // ignore: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class TeacherLoginItemWidget extends StatelessWidget {
  TeacherLoginItemWidget(this.teacherLoginItemModelObj, {Key? key})
      : super(
          key: key,
        );

  TeacherLoginItemModel teacherLoginItemModelObj;

  var controller = Get.find<TeacherLoginController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.adaptSize,
          width: 100.adaptSize,
          padding: EdgeInsets.all(20.h),
          decoration: AppDecoration.fillTeal.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder12,
          ),
          child: Obx(
            () => CustomImageView(
              imagePath: teacherLoginItemModelObj.attendanceone!.value,
              height: 60.adaptSize,
              width: 60.adaptSize,
              alignment: Alignment.center,
            ),
          ),
        ),
        SizedBox(height: 9.v),
        Obx(
          () => Text(
            teacherLoginItemModelObj.attendancetwo!.value,
            style: theme.textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
