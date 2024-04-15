// import 'package:flutter/material.dart';
// import '../../core/app_export.dart';
// import '../../core/utils/validation_functions.dart';
// import '../../widgets/custom_elevated_button.dart';
// import '../../widgets/custom_floating_text_field.dart';
// import 'controller/login_controller.dart'; // ignore_for_file: must_be_immutable
// // ignore_for_file: must_be_immutable
//
// // ignore_for_file: must_be_immutable
// class LoginScreen extends GetWidget<LoginController> {
//   LoginScreen({Key? key})
//       : super(
//           key: key,
//         );
//
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: theme.colorScheme.onPrimary,
//         body: SizedBox(
//           width: SizeUtils.width,
//           child: SingleChildScrollView(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: Form(
//               key: _formKey,
//               child: SizedBox(
//                 width: double.maxFinite,
//                 child: Column(
//                   children: [
//                     _buildStackvectorone(),
//                     SizedBox(height: 86.v),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: TextFormField(
//                         controller: controller.idController,
//                         validator: (value) {
//                           if (value == null ||
//                               (!isValidPassword(value, isRequired: true))) {
//                             return "err_msg_please_enter_valid_password".tr;
//                           }
//                           return null;
//                         },
//                         autofocus: false,
//                         style: TextStyle(fontSize: 15.0, color: Colors.black),
//                         decoration: InputDecoration(
//                           suffixIconConstraints: BoxConstraints(
//                             maxHeight: 57.v,
//                           ),
//                           labelStyle: CustomTextStyles.bodyMediumBlack900,
//                           labelText: "lbl_username".tr,
//                           border: InputBorder.none,
//                           hintText: "lbl_username".tr,
//                           filled: true,
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.blue)),
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 6.0, top: 8.0),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10.v),
//                     Padding(
//                       padding: EdgeInsets.all(10),
//                       child: TextFormField(
//                         controller: controller.passwordController,
//                         textInputAction: TextInputAction.done,
//                         obscureText: controller.isShowPassword.value,
//                         validator: (value) {
//                           if (value == null ||
//                               (!isValidPassword(value, isRequired: true))) {
//                             return "err_msg_please_enter_valid_password".tr;
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "lbl_password".tr,
//                           labelText: "lbl_password".tr,
//                           labelStyle: CustomTextStyles.bodyMediumBlack900,
//                           suffixIcon: GestureDetector(
//                             onTap: () {
//
//                               controller.isShowPassword.value = !controller.isShowPassword.value;
//
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 18.0),
//                               child: Icon(
//                                 controller.isShowPassword.value
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           suffixIconConstraints: BoxConstraints(
//                             maxHeight: 50.v,
//                           ),
//                           border: InputBorder.none,
//                           filled: true,
//                           contentPadding: const EdgeInsets.only(
//                               left: 14.0, bottom: 6.0, top: 8.0),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.blue)),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(5.0),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 87.v),
//                     CustomElevatedButton(
//                       height: 45.v,
//                       text: "lbl_login".tr,
//                       margin: EdgeInsets.symmetric(horizontal: 80.h),
//                       buttonTextStyle: theme.textTheme.titleLarge!
//                           .copyWith(color: Colors.white),
//                       onPressed: () {
//                         controller.loginApi(context);
//                       },
//                     ),
//                     // SizedBox(height: 15.v),
//                     // CustomElevatedButton(
//                     //   height: 35.v,
//                     //   text: "Change School",
//                     //   margin: EdgeInsets.symmetric(horizontal: 80.h),
//                     //   buttonTextStyle: theme.textTheme.titleMedium!
//                     //       .copyWith(color: Colors.white),
//                     //   onPressed: () {
//                     //     controller.changeSchool();
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// Section Widget
//   Widget _buildStackvectorone() {
//     return SizedBox(
//       height: 273.v,
//       width: double.maxFinite,
//       child: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           CustomImageView(
//             imagePath: ImageConstant.imgVector193x375,
//             height: 193.v,
//             width: 375.h,
//             alignment: Alignment.topCenter,
//           ),
//           Align(
//
//               alignment: Alignment.topRight,
//               child:   Padding(
//                 padding: const EdgeInsets.only(right: 10.0,top: 25),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print('Change School button pressed');
//                     controller.changeSchool();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green, // Blue color
//                     padding: EdgeInsets.symmetric(
//                         vertical: 16, horizontal: 24),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.school,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Change School',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 203.adaptSize,
//               width: 203.adaptSize,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 41.h,
//                 vertical: 29.v,
//               ),
//               decoration: AppDecoration.outlineTeal.copyWith(
//                 borderRadius: BorderRadiusStyle.roundedBorder101,
//               ),
//               child: CustomImageView(
//                 imagePath: ImageConstant.imgRectangle133x108,
//                 height: 133.v,
//                 width: 108.h,
//                 alignment: Alignment.topLeft,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/cutomInputfeild.dart';
import '../../widgets/cutomformbuttom.dart';
import '../../widgets/pageHeder.dart';
import '../../widgets/pageHeding.dart';
import 'controller/login_controller.dart';

class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key})
      : super(
          key: key,
        );


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      children: [
                        const PageHeading(
                          title: 'Log-in',
                        ),
                        CustomInputField(
                            controller: controller.idController,
                            labelText: "lbl_username".tr,
                            hintText: "lbl_username".tr,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Username is required!';
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomInputField(
                          controller: controller.passwordController,
                          hintText: "lbl_password".tr,
                          labelText: "lbl_password".tr,
                          obscureText: true,
                          suffixIcon: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFormButton(
                          innerText: 'Login',
                          onPressed: (){
                            _handleLoginUser(context);
                          },
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                    ElevatedButton(
                  onPressed: () {
                    print('Change School button pressed');
                    controller.changeSchool();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xff233743), // Blue color
                    padding: EdgeInsets.symmetric(
                        vertical: 25, horizontal: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.school,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Change School',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLoginUser(context) {
    if (controller.loginFormKey.currentState!.validate()) {
      controller.loginApi(context);
    }
  }
}
