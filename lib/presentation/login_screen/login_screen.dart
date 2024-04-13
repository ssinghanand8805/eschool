import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import 'controller/login_controller.dart'; // ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.colorScheme.onPrimary,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    _buildStackvectorone(),
                    SizedBox(height: 86.v),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: controller.idController,
                        validator: (value) {
                          if (value == null ||
                              (!isValidPassword(value, isRequired: true))) {
                            return "err_msg_please_enter_valid_password".tr;
                          }
                          return null;
                        },
                        autofocus: false,
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                        decoration: InputDecoration(
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: 57.v,
                          ),
                          labelStyle: CustomTextStyles.bodyMediumBlack900,
                          labelText:  "lbl_username".tr,
                          border: InputBorder.none,
                          hintText: "lbl_username".tr,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue)),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 6.0, top: 8.0),

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: controller.passwordController,


                        textInputAction: TextInputAction.done,

                        obscureText: controller.isShowPassword.value,


                        validator: (value) {
                          if (value == null ||
                              (!isValidPassword(value, isRequired: true))) {
                            return "err_msg_please_enter_valid_password".tr;
                          }
                          return null;
                        },
                        decoration: InputDecoration(

                          hintText: "lbl_password".tr,
                          labelText: "lbl_password".tr,
                          labelStyle:
                          CustomTextStyles.bodyMediumBlack900,
                          suffixIconConstraints: BoxConstraints(
                            maxHeight: 57.v,
                          ),
                          border: InputBorder.none,
                          filled: true,

                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 6.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.blue)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 87.v),
                    CustomElevatedButton(
                      height: 51.v,
                      text: "lbl_login".tr,
                      margin: EdgeInsets.symmetric(horizontal: 34.h),
                      buttonTextStyle: theme.textTheme.titleLarge!,
                      onPressed: (){
                        controller.loginApi(context);
                      },
                    ),
                    SizedBox(height: 24.v),
                    Opacity(
                      opacity: 0.3,
                      child: Text(
                        "msg_forgot_password".tr,
                        style: CustomTextStyles.bodyMediumBlack900,
                      ),
                    ),
                    SizedBox(height: 5.v),
                    CustomElevatedButton(
                      height: 25.v,
                      text: "Change School",
                      margin: EdgeInsets.symmetric(horizontal: 34.h),
                      buttonTextStyle: theme.textTheme.titleLarge!,
                      onPressed: (){
                        controller.changeSchool();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackvectorone() {
    return SizedBox(
      height: 273.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgVector193x375,
            height: 193.v,
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

  /// Section Widget
  Widget _buildUsername() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 34.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_username".tr,
            style: theme.textTheme.bodyMedium,
          ),
          SizedBox(height: 5.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.3,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    "lbl_prajesh_shakya".tr,
                    style: CustomTextStyles.bodyMediumBlack900_1,
                  ),
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.imgEye,
                height: 18.v,
                width: 14.h,
                margin: EdgeInsets.only(bottom: 7.v),
              )
            ],
          ),
          SizedBox(height: 10.v),
          Divider(
            color: appTheme.gray40001,
          )
        ],
      ),
    );
  }
}
