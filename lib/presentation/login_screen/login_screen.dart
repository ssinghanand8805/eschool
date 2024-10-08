
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/widgets/backgroundWidget.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Backgroundwidget(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
               PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
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
                            height: 30,
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
                    SizedBox(height: 50,),
                      Obx(() => Text(
                        controller.schoolName.value,
                        style: TextStyle(
                         color:Color(0xff233743),
                          //color:Colors.cyanAccent,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black54,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                      )),


                      ],
                      ),
                    ),
                  ),
                ),
              ),
        
            ],
          ),
        ),
      ),
    );
  }

  void _handleLoginUser(context) {
    if (_formKey.currentState!.validate()) {
      controller.loginApi(context);
    }
  }
}
