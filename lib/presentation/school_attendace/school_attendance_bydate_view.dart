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
  State<SchoolAttendanceByDateScreen> createState() =>
      _SchoolAttendanceByDateScreenState();
}

class _SchoolAttendanceByDateScreenState
    extends State<SchoolAttendanceByDateScreen> {
  SchoolAttendanceByDateController controller =
      Get.put(SchoolAttendanceByDateController());
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

  CommonApiController controller3 = Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Attendance',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder(
            init: controller,
            builder: (context) {
              return getTableData();
            }),
      ),
    );
  }

  getTableData() {
    // var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
    // final source =  ResultSource(controller.filteredStudentListModel);
    return Column(
      children: [
        controller.filteredStudentListModel.value.resultlist == null ||
                controller.filteredStudentListModel.value.resultlist!.length ==
                    0
            ? Center(child: CustomLoader())
            : Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: controller.filteredStudentListModel.value.resultlist!
                            .length <=
                        0
                    ? Text("No data found!")
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller
                            .filteredStudentListModel.value.resultlist!.length,
                        itemBuilder: (context, index) {
                          Resultlist sch = controller.filteredStudentListModel
                              .value.resultlist![index];
                          return Center(
                              child: StudentCard(
                            status: sch.attendanceStatus!,
                            classAndSectionName: sch.classSection!,
                            totalStudents: sch.totalStudents ?? 0,
                            totalPresent: int.parse(sch.totalPresent!),
                            totalAbsent: int.parse(sch.totalAbsent!),
                            totalLeave: int.parse(sch.totalLeave!),
                          ));
                        })),
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
    final Color statusColor = status == 1
        ? Colors.green
        : status == 2
            ? Colors.orange
            : Colors.red;

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade400, Colors.green.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Icon or Image Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.school,
                  size: 32.0,
                  color: statusColor,
                ),
              ),
              SizedBox(width: 10.0),

              // Text and Details Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classAndSectionName.capitalizeFirst!,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(height: 8.0),
                    Text(
                      'Attendance Status: ${_getStatusText(status)}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    // SizedBox(height: 8.0),
                    // Chips wrapped in a Wrap widget
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatChip(
                            'Students', totalStudents, Colors.white70),
                        _buildStatChip(
                            'Present', totalPresent, Colors.greenAccent),
                        _buildStatChip('Absent', totalAbsent, Colors.redAccent),
                      ],
                    ),

                    _buildStatChip('Leave', totalLeave, Colors.orangeAccent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Chip(
      label: Text(
        '$label: $count',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
      ),
      backgroundColor: color.withOpacity(0.3),
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Good';
      case 2:
        return 'Moderate';
      case 3:
        return 'Poor';
      default:
        return 'Not found';
    }
  }
}
