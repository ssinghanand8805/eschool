import 'dart:async';
import 'dart:collection';


import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/datePickerTextField.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../common_widgets/controller/CommonController.dart';
import '../common_widgets/custom_loader.dart';
import '../student_attendence/controller/student_attendance_controller.dart';

import 'controller/school_attendance_bydate_controller.dart';
import 'model/SchoolAttendanceByDate.dart';

class SchoolAttendanceByDateScreen extends StatefulWidget {
  const SchoolAttendanceByDateScreen({Key? key});

  @override
  State<SchoolAttendanceByDateScreen> createState() => _SchoolAttendanceByDateScreenState();
}

class _SchoolAttendanceByDateScreenState extends State<SchoolAttendanceByDateScreen> {
  SchoolAttendanceByDateController controller = Get.put(SchoolAttendanceByDateController());
  int _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }



  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  CommonApiController controller3 =
  Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('Attendance',style: theme.textTheme.titleMedium,),),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return getTableData();
        }
      ),
    );
  }


  getTableData()
  {
    // var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
    // final source =  ResultSource(controller.filteredStudentListModel);
    return Column(
      children: [

        controller.filteredStudentListModel.value.resultlist!.length == 0 ?
        Center(child: Text("No Data")) :
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: controller.filteredStudentListModel.value.resultlist!.length <= 0 ? Text("No data found!") : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.filteredStudentListModel.value.resultlist!.length,
              itemBuilder: (context, index) {
                Resultlist sch = controller.filteredStudentListModel.value.resultlist![index];
              return Center(
                child: StudentCard(
                status:sch.attendanceStatus!,
                classAndSectionName: sch.classSection!,
                totalStudents: sch.totalStudents!,
                totalPresent:int.parse(sch.totalPresent!),
                totalAbsent: int.parse(sch.totalAbsent!),
                totalLeave: int.parse(sch.totalLeave!),
                )
              );
            }
          )



        ),
      ],
    );
  }




}
class StudentCard extends StatelessWidget {
  final int status;
  final String classAndSectionName;
  final int totalStudents;
  final int totalPresent;
  final int totalAbsent;
  final int totalLeave;

  StudentCard({
    required this.status,
    required this.classAndSectionName,
    required this.totalStudents,
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              classAndSectionName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text('Attendance Status: $status'),
            Text('Total Students: $totalStudents'),
            Text('Total Present: $totalPresent'),
            Text('Total Absent: $totalAbsent'),
            Text('Total Leave: $totalLeave'),
          ],
        ),
      ),
    );
  }
}