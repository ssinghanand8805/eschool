
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/about_school/controller/about_schoolController.dart';

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
     title: Text("About School",style: theme.textTheme.titleMedium!),
      ),
     backgroundColor: Colors.grey.shade50,
      body: FutureBuilder(
    future: controller.fetchDataFuture, //controller.getData(context),
    builder: (context, snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return CustomLoader(); // CustomLoader();
      }
      else {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
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
                          controller.schoolName.value!,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Text('Address: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),

                        Text(controller.schoolAddress.value!,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Phone: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(controller.schoolPhone.value,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Email: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(controller.schoolEmail.value,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('School Code: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(controller.schoolSchoolCode.value,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Current Session: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(controller.schoolCurrentSession.value,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('Session Start Month: ',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(controller.schoolStartMonth.value,
                            style: theme.textTheme.titleMedium!),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Action to perform when the button is pressed
                        print('Change School button pressed');
                        controller.changeSchool();
                      },
                      child: Text('Change School',
                        style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }),
    );
  }
}