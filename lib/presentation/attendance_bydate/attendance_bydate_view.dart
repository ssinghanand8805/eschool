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
import '../student_attendence/model/Student_Attendance.dart';
import 'controller/attendance_bydate_controller.dart';

class AttendanceByDateScreen extends StatefulWidget {
  const AttendanceByDateScreen({Key? key});

  @override
  State<AttendanceByDateScreen> createState() => _ApproveLeaveScreenState();
}

class _ApproveLeaveScreenState extends State<AttendanceByDateScreen> {
  AttendanceByDateController controller = Get.put(AttendanceByDateController());
  int _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  late ResultSource _source;

  @override
  void initState() {
    super.initState();
    _source = ResultSource(controller.filteredStudentListModel);
  }

  @override
  void dispose() {
    _source.dispose();
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
          return CommonForm(
              widgetFilterSelectedData: Row(
                children: [
                  Text("Class :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                  Text(controller3.selectedClassName.value + " ( " + controller3.selectedSectionName.value + " )",
                      style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                  SizedBox(width: 20),
                  Text("Date :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                  Text(controller.attendanceDate.value.text,style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                ],
              ),
              widgetFilterData: Column(
                children: [
                  Obx( () => MyCustomSD(

                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller3.classListModelMap.value,
                    valFrom: "className",
                    label: 'Class',
                    labelText: 'Class',
                    onChanged: (val) {
                      if(controller3.classListModelMap.value.length > 0)
                      {
                        print("5555555555555");

                        controller3.selectedClassId.value = val['id'].toString();
                        controller3.selectedClassName.value = val['className'].toString();
                        controller3.update();
                        controller3.getSectionList();
                      }

                    },
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Obx( () => MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller3.sectionListModelMap.value,
                    valFrom: "section",
                    label: 'Section',
                    labelText: 'Section',
                    onChanged: (val) {
                      print(val);
                      if(controller3.sectionListModelMap.value.length > 0)
                      {


                        controller3.selectedSectionId.value = val['id'].toString();
                        controller3.selectedSectionName.value = val['section'].toString();
                        controller3.update();

                      }

                    },
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text("Attendance Date",
                            style: theme.textTheme.bodySmall!.copyWith(fontSize: 14)),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      DatePickerTextField(
                          controller: controller.attendanceDate.value,
                          title: 'Attendace date',
                          onDateSelected: (date) async {
                            controller.attendanceDate.value.text =
                            await GlobalData().ConvertToSchoolDateTimeFormat(date);
                          }),
                      SizedBox(
                        height: 17,
                      ),

                    ],
                  ),
                ],
              ),
              widgetformData: Column(
                children:[
                  SizedBox(height: 10,),
                  Expanded(child: controller.isLoadingStudentList.isTrue ? CustomLoader() :  getTableData())
                ]
                ,),
              onTapAction: filterData);
        }
      ),
    );
  }
  filterData() {
    print("Perform search action here");
    AttendanceByDateController controller =
    Get.put(AttendanceByDateController());
    controller.getFilterData();

  }

  getTableData()
  {
    // var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
    // final source =  ResultSource(controller.filteredStudentListModel);
    return Column(
      children: [
        CustomTextField(
          controller: controller.searchController.value, hint: 'Search Student', title: 'Search Student',

        ),
        controller.filteredStudentListModel.value.length == 0 ?
        Text("No Data") :
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: AdvancedPaginatedDataTable(
              addEmptyRows: false,
              source: _source,
              showFirstLastButtons: true,
              rowsPerPage: _rowsPerPage,
              availableRowsPerPage: [1, 5, 10, 50],
              onRowsPerPageChanged: (newRowsPerPage) {
                if (newRowsPerPage != null) {
                  setState(() {
                    _rowsPerPage = newRowsPerPage;
                  });
                }
              },
              columns: [
                DataColumn(label: Text('Student')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Remark'))
              ],
            ),
          ),
        ),
      ],
    );
  }




}
class ResultSource extends AdvancedDataTableSource<Resultlist>{
  final RxList<Resultlist> filteredStudentListModel;
  late final StreamSubscription _subscription;

  ResultSource(this.filteredStudentListModel) {
    _subscription = filteredStudentListModel.listen((_) {
      print("Data Change${filteredStudentListModel.value.length}");
      setNextView();
      notifyListeners();
    });
  }




  @override
  DataRow? getRow(int index) {
    // Check if the index is within the bounds of the list
    if (index < 0 || index >= filteredStudentListModel.value.length) {
      return null;  // Return null if the index is out of bounds
    }
    final currentRowData = filteredStudentListModel.value[index];
    return DataRow(cells: [
      DataCell(
        Text(currentRowData.firstname.toString()),
      ),
      DataCell(
        Text(currentRowData.attType == null ? "-" : currentRowData.attType!),
      ),
      DataCell(
        Text(currentRowData.remark == null ? "-" : currentRowData.remark!),
      )
    ]);
  }

  @override
  int get selectedRowCount => 0;

  @override
  Future<RemoteDataSourceDetails<Resultlist>> getNextPage(
      NextPageRequest pageRequest) async {
    return RemoteDataSourceDetails(
      filteredStudentListModel.value.length,
      filteredStudentListModel.value
          .skip(pageRequest.offset)
          .take(pageRequest.pageSize)
          .toList(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}


