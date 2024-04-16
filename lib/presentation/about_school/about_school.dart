import 'package:flutter/material.dart';
import 'package:learnladder/presentation/about_school/controller/about_schoolController.dart';
import 'package:learnladder/presentation/homework/HomeworkScreen.dart';

import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';
import '../common_widgets/custom_loader.dart';

class AboutSchoolScreen extends StatefulWidget {
  @override
  State<AboutSchoolScreen> createState() => _AboutSchoolScreenState();
}

class _AboutSchoolScreenState extends State<AboutSchoolScreen> {
  AboutSchoolController controller = Get.put(AboutSchoolController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About School", style: theme.textTheme.titleLarge!.copyWith(fontSize: 19)),
      ),
      backgroundColor: Colors.grey.shade50,
      body: FutureBuilder(
          future: controller.fetchDataFuture, //controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'https://5.imimg.com/data5/VI/LJ/MY-55827694/school-management-software-desktop-based-500x500.png',
                              width: 80.0, //
                              // height: 150.0,
                            ),
                            SizedBox(width: 16.0),
                            Text(
                                    controller.schoolName.value ?? '',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )

                          ],
                        ),
                        SizedBox(height: 16.0),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Address',
                            value: controller.schoolAddress.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Phone',
                            value: controller.schoolPhone.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Email',
                            value: controller.schoolEmail.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'School Code',
                            value: controller.schoolSchoolCode.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Current Session',
                            value: controller.schoolCurrentSession.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Session Stat Month',
                            value: controller.schoolStartMonth.value!),
                        ElevatedButton(
                          onPressed: () {
                            print('Change School button pressed');
                            controller.changeSchool();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1565C0), // Blue color
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 24),
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
                ],
              );
            }
          }),
    );
  }
}
