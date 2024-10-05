import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_helper.dart';
import 'controller/changePassword_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ChangePasswordController controller = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text('Change Password',
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 17))),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      'Change Your Password',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  controller.buildTextField(
                    controller: controller.oldPasswordController,
                    label: 'Old Password',
                    icon: Icons.lock_outline,
                    isPasswordField: false,
                    isPasswordVisible: controller.oldPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        controller.oldPasswordVisible =
                            !controller.oldPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  controller.buildTextField(
                    controller: controller.newPasswordController,
                    label: 'New Password',
                    icon: Icons.lock_outline,
                    isPasswordField: true,
                    isPasswordVisible: controller.newPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        controller.newPasswordVisible =
                            !controller.newPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  controller.buildTextField(
                    controller: controller.confirmPasswordController,
                    label: 'Confirm New Password',
                    icon: Icons.lock_outline,
                    isPasswordField: true,
                    isPasswordVisible: controller.confirmPasswordVisible,
                    onVisibilityToggle: () {
                      setState(() {
                        controller.confirmPasswordVisible =
                            !controller.confirmPasswordVisible;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: (){
                        controller.submitForm(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 12),
                        child: Text(
                          'Change Password',
                          style: theme.textTheme.titleLarge!
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
