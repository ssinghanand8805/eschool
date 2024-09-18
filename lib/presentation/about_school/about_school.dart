import 'package:flutter/material.dart';
import 'package:lerno/presentation/about_school/controller/about_schoolController.dart';
import 'package:lerno/presentation/homework/HomeworkScreen.dart';

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
        backgroundColor: Colors.green.shade100,
        title: Text('About School',
            style: theme.textTheme.titleMedium!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w500)),

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
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                            title: 'Address',
                            value: controller.schoolAddress.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                            title: 'Phone',
                            value: controller.schoolPhone.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                            title: 'Email',
                            value: controller.schoolEmail.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                            title: 'School Code',
                            value: controller.schoolSchoolCode.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                            title: 'Current Session',
                            value: controller.schoolCurrentSession.value!),
                        InfoRow(
                            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                            title: 'Session Stat Month',
                            value: controller.schoolStartMonth.value!),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: ElevatedButton(
                            onPressed: () {
                              print('Change School button pressed');
                              _showConfirmationDialog(context);
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

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Confirm School Change',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Are you sure you want to change your school?',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'This action will update your profile and may affect your current settings.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.changeSchool();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
