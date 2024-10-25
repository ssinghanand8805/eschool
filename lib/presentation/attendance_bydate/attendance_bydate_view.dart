import 'dart:async';
import 'dart:collection';
import 'dart:io';


import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../widgets/alert_dialogue.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/datePickerTextField.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../common_widgets/controller/CommonController.dart';
import '../common_widgets/custom_loader.dart';
import '../student_attendence/controller/student_attendance_controller.dart';
import '../student_attendence/model/Student_Attendance.dart';
import 'controller/attendance_bydate_controller.dart';
import 'package:pdf/widgets.dart' as pw;
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
generatePdf(filteredStudentListModel,dateFor,classFor)
async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Text('Attendance class ${classFor} on ${dateFor}', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            // Create a list for students
            pw.ListView.builder(
              itemCount: filteredStudentListModel.length,
              itemBuilder: (context, index) {
                final currentRowData = filteredStudentListModel[index];

                return pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  margin: pw.EdgeInsets.symmetric(vertical: 5),
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [

                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              currentRowData.firstname +
                                  // + " " + currentRowData.middlename == null ? "" : currentRowData.middlename + " " + currentRowData.lastname == null ? "" : currentRowData.lastname  +
                                  " ( " + currentRowData.admissionNo + ")",
                              style: pw.TextStyle(fontSize: 16),
                            ),
                            pw.SizedBox(height: 10),
                          ],
                        ),
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          color: currentRowData.attType == "Present"
                              ? PdfColors.green
                              : currentRowData.attType == "Absent"
                              ? PdfColors.red
                              : PdfColors.orange,
                          borderRadius: pw.BorderRadius.circular(20),
                        ),
                        padding: pw.EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: pw.Text(
                          currentRowData.attType,
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    ),
  );

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String fileName = '$formattedDate.pdf';

  // Get the temporary directory
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/$fileName';

  // Save the PDF to the temp directory
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());
  print(filePath);
  await OpenFilex.open(filePath);
}
  CommonApiController controller3 =
  Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Attendance',style: theme.textTheme.titleLarge,),
        backgroundColor: Colors.green.shade100,
        actions: [
          InkWell(
            onTap: (){
              if(controller.filteredStudentListModel.length > 0 )
                {
                  String classFor = controller3.selectedClassName.value + " ( " + controller3.selectedSectionName.value + " )";
                  generatePdf(controller.filteredStudentListModel,controller.attendanceDate.value.text,classFor);
                }
              else
                {
                  print("No Data to share");
                }

            },
              child: Icon(Icons.share,size: 22,))
        ],
      ),
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
                  Row(
                    children: [
                      Expanded(
                          child: Obx( () => MyCustomSD(

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
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Obx( () => MyCustomSD(
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
                      )
                    ],
                  ),



                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 3.0),
                      //   child: Text("Attendance Date",
                      //       style: theme.textTheme.bodySmall!.copyWith(fontSize: 14)),
                      // ),
                      // SizedBox(
                      //   height: 3,
                      // ),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            controller: controller.searchController.value,
            hint: 'Search Student',
            title: 'Search Student',
      
          ),
          // controller.filteredStudentListModel.value.length == 0 ?
          // Text("No Data") :
          controller.isLoadingStudentList.isTrue ? CustomLoader() : Container(child: controller.filteredStudentListModel.length > 0 ?

              ListView.builder(
                itemCount: controller.filteredStudentListModel.value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final currentRowData = controller.filteredStudentListModel.value[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(1, 4), // Shadow position
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 25,
                            width: 4,
                            decoration: BoxDecoration(
                                color: Colors.green.shade300,
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "Student: ",
                                          //   style: theme.textTheme.titleSmall,),
                                          Text(
                                            currentRowData.firstname.toString(),
                                            style: theme.textTheme.titleSmall,),
                                        ],
                                      ),


                                      Row(
                                        children: [
                                          Text("Status.: ",
                                            style: theme.textTheme.titleSmall,),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: currentRowData.attType.toString()=="Present"?Colors.green:currentRowData.attType.toString()=="Absent"?Colors.red:Colors.orange,
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(color: currentRowData.attType.toString()=="Present"?Colors.green:currentRowData.attType.toString()=="Absent"?Colors.red:Colors.orange)
                                            ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 4),
                                                child: Text(currentRowData.attType.toString(), style: theme.textTheme.titleSmall!.copyWith(color: Colors.white))
                                                //Text(currentRowData.attType.toString(), style: currentRowData.attType.toString()=="Present"?theme.textTheme.bodySmall!.copyWith(color: Colors.green):currentRowData.attType.toString()=="Absent"?theme.textTheme.bodySmall!.copyWith(color: Colors.red):theme.textTheme.bodySmall!.copyWith(color: Colors.orange),),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),



                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },)




          // SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 8.0),
          //     child: AdvancedPaginatedDataTable(
          //       addEmptyRows: false,
          //       source: _source,
          //       showFirstLastButtons: true,
          //       rowsPerPage: _rowsPerPage,
          //       availableRowsPerPage: [1, 5, 10, 50],
          //       onRowsPerPageChanged: (newRowsPerPage) {
          //         if (newRowsPerPage != null) {
          //           setState(() {
          //             _rowsPerPage = newRowsPerPage;
          //           });
          //         }
          //       },
          //       columns: [
          //         DataColumn(label: Text('Student')),
          //         DataColumn(label: Text('Status')),
          //         DataColumn(label: Text('Remark'))
          //       ],
          //     ),
          //   ),
          // )
              :Container(child: Lottie.asset("assets/images/no_data_found.json"),),)
        ],
      ),
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


