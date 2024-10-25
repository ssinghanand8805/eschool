
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiHelper/toastMessage.dart';
import '../../widgets/cutomInputfeild.dart';
import '../../widgets/cutomformbuttom.dart';
import '../../widgets/pageHeder.dart';
import '../../widgets/pageHeding.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
             PageHeader(name: "Login",),
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
                     // key: controller.loginFormKey,
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
                        Obx(() { return CustomFormButton(
                          innerText: 'Login',
                          onPressed: (){
                            _handleLoginUser(context);
                          },
                          isLoading: controller.isLoading.value,
                        );}),
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
    if(controller.idController.value.text.isEmpty || controller.passwordController.value.text.isEmpty){
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Enter Username or password"));
    }else{
      controller.loginApi(context);

    }

    // if (controller.loginFormKey.currentState!.validate()) {
    //   controller.loginApi(context);
    // }
  }
}
