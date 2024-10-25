

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../widgets/cutomInputfeild.dart';
import '../../widgets/cutomformbuttom.dart';
import '../../widgets/pageHeder.dart';
import '../../widgets/pageHeding.dart';
import 'controller/school_url_controller.dart';

class SchoolUrl extends StatefulWidget {
  const SchoolUrl({Key? key}) : super(key: key);

  @override
  State<SchoolUrl> createState() => _SchoolUrlState();
}

class _SchoolUrlState extends State<SchoolUrl> {

  final _forgetPasswordFormKey = GlobalKey<FormState>();
  SchoolUrlController controller = Get.put(SchoolUrlController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: size.height * 0.3,
              child:  Image.asset('assets/projectImages/friendship.png') ,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _forgetPasswordFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'School Code',),
                        CustomInputField(
                          controller: controller.urlController.value,
                          labelText: "lbl_code".tr,
                          hintText: "lbl_code".tr,
                            isDense: true,
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Code is required!';
                              }

                              return null;
                            },
                        ),
                        const SizedBox(height: 30,),
    Obx(() { return CustomFormButton(innerText: 'Submit', onPressed: _handleForgetPassword,isLoading : controller.isLoading.value); }),
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

  void _handleForgetPassword() {

    if (_forgetPasswordFormKey.currentState!.validate()) {
      controller.getData(context);
    }
  }
}