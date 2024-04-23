import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import 'button.dart';


class AttendanceModule extends StatefulWidget {
  @override
  _AttendanceModuleState createState() => _AttendanceModuleState();
}

class _AttendanceModuleState extends State<AttendanceModule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                CustomImageButton(
                  imagePath: 'assets/projectImages/ic_nav_attendance.png',
                  onPressed: () {
                    Get.toNamed(AppRoutes.studentAttendanceRoute);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>   StudentListPage()),
                    // );
                  },
                  name: 'Attendance',
                ),
                SizedBox(width: 10,),
                CustomImageButton(
                  imagePath: 'assets/projectImages/ic_nav_attendance.png',
                  onPressed: () {
                    Get.toNamed(AppRoutes.approveLeaveRoute);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>   StudentListPage()),
                    // );
                  },
                  name: 'Approve Leave',
                ),  SizedBox(width: 10,), CustomImageButton(
                  imagePath: 'assets/projectImages/ic_nav_attendance.png',
                  onPressed: () {
                    Get.toNamed(AppRoutes.attendanceByDateRoute);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>   StudentListPage()),
                    // );
                  },
                  name: 'Attendance By Date',
                ),
              ],
            ),
            Row(
              children: [
                CustomImageButton(
                  imagePath: 'assets/projectImages/ic_nav_attendance.png',
                  onPressed: () {
                    Get.toNamed(AppRoutes.addHomeworkRoute);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>   StudentListPage()),
                    // );
                  },
                  name: 'Home Work',
                ),SizedBox(width: 10,),CustomImageButton(
                  imagePath: 'assets/projectImages/ic_nav_attendance.png',
                  onPressed: () {
                    Get.toNamed(AppRoutes.teacherDailyAssignmentRoute);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>   StudentListPage()),
                    // );
                  },
                  name: 'Teacher Daily Assignment',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
