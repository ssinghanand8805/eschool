

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/widgets/backgroundWidget.dart';


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

  final formKey = GlobalKey<FormState>();
  SchoolUrlController controller = Get.put(SchoolUrlController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Backgroundwidget(
        child: Scaffold(
          backgroundColor: Colors.transparent, //
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.15,
                child:  Image.asset('assets/images/LearnoLogo.png') ,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                       //const PageHeading(title: 'School Code',),
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
        
                        const Spacer(),
                        CustomFormButton(innerText: 'Submit', onPressed: _handleSubmit,),
                        SizedBox(height: 30,)
                      ],
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

  void _handleSubmit() {

    if (formKey.currentState!.validate()) {
      controller.getData(context);
    }
  }
}