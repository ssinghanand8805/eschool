
import 'package:flutter/material.dart';
import 'package:learnladder/presentation/about_school/controller/about_schoolController.dart';

import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';

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
      body: Padding(
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
                        width: 80.0,//
                       // height: 150.0,
                      ),
                      SizedBox(width: 16.0),
                      Text(
                        'Mount Carmel School',
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
                      Text('Address: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),

                      Text('2 5 Kings Street, CA',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Phone: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      Text('895624233934',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Email: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      Text('mountcarmelmailtest@gmail.com',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('School Code: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600 )),
                      Text('ACT-487438',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Current Session: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      Text('2023-24',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text('Session Start Month: ',style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      Text('April',style: theme.textTheme.titleMedium!),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}