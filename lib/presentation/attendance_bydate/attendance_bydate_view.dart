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
import 'package:share_plus/share_plus.dart';
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

  generatePdf(filteredStudentListModel, dateFor, classFor, isShare) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Attendance class ${classFor} on ${dateFor}',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
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
                                    " ( " +
                                    currentRowData.admissionNo +
                                    ")",
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
                          padding: pw.EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
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

    if (isShare) {
      final xFile = XFile(file.path);
      Share.shareXFiles([xFile], subject: fileName);
    } else {
      await OpenFilex.open(filePath);
    }
  }

  CommonApiController controller3 = Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: theme.textTheme.bodyMedium,
        ),
        backgroundColor: Colors.green.shade100,
        actions: [
          InkWell(
              onTap: () {
                if (controller.filteredStudentListModel.length > 0) {
                  String classFor = controller3.selectedClassName.value +
                      " ( " +
                      controller3.selectedSectionName.value +
                      " )";
                  generatePdf(controller.filteredStudentListModel,
                      controller.attendanceDate.value.text, classFor, false);
                } else {
                  print("No Data to share");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.remove_red_eye,
                  size: 22,
                ),
              )),
          InkWell(
              onTap: () {
                if (controller.filteredStudentListModel.length > 0) {
                  String classFor = controller3.selectedClassName.value +
                      " ( " +
                      controller3.selectedSectionName.value +
                      " )";
                  generatePdf(controller.filteredStudentListModel,
                      controller.attendanceDate.value.text, classFor, true);
                } else {
                  print("No Data to share");
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.share,
                  size: 22,
                ),
              )),
        ],
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return CommonForm(
                widgetFilterSelectedData: Container(
                  width: Get.width * 0.7,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.green.shade200)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Class :  ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                    controller3.selectedClassName.value +
                                        " ( " +
                                        controller3.selectedSectionName.value +
                                        " )",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.green.shade200)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Date :  ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(controller.attendanceDate.value.text,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                widgetFilterData: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Obx(() => MyCustomSD(
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch:
                                    controller3.classListModelMap.value,
                                valFrom: "className",
                                label: 'Class',
                                labelText: 'Class',
                                onChanged: (val) {
                                  if (controller3
                                          .classListModelMap.value.length >
                                      0) {
                                    print("5555555555555");

                                    controller3.selectedClassId.value =
                                        val['id'].toString();
                                    controller3.selectedClassName.value =
                                        val['className'].toString();
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
                          child: Obx(() => MyCustomSD(
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch:
                                    controller3.sectionListModelMap.value,
                                valFrom: "section",
                                label: 'Section',
                                labelText: 'Section',
                                onChanged: (val) {
                                  print(val);
                                  if (controller3
                                          .sectionListModelMap.value.length >
                                      0) {
                                    controller3.selectedSectionId.value =
                                        val['id'].toString();
                                    controller3.selectedSectionName.value =
                                        val['section'].toString();
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
                                  await GlobalData()
                                      .ConvertToSchoolDateTimeFormat(date);
                            }),
                        SizedBox(
                          height: 17,
                        ),
                      ],
                    ),
                  ],
                ),
                widgetformData: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: controller.isLoadingStudentList.isTrue
                            ? CustomLoader()
                            : getTableData())
                  ],
                ),
                onTapAction: filterData);
          }),
    );
  }

  filterData() {
    print("Perform search action here");
    AttendanceByDateController controller =
        Get.put(AttendanceByDateController());
    controller.getFilterData();
  }

  getTableData() {
    // var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
    // final source =  ResultSource(controller.filteredStudentListModel);
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            controller: controller.searchController.value,
            hint: 'Search Student...',
            title: 'Search Student',
          ),
          // controller.filteredStudentListModel.value.length == 0 ?
          // Text("No Data") :
          controller.isLoadingStudentList.isTrue
              ? CustomLoader()
              : Container(
                  child: controller.filteredStudentListModel.length > 0
                      ? ListView.builder(
                          itemCount:
                              controller.filteredStudentListModel.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final currentRowData = controller
                                .filteredStudentListModel.value[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green.shade100,
                                        Colors.green.shade50,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 10, 5),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 4,
                                        decoration: BoxDecoration(
                                            color: Colors.green.shade300,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            currentRowData
                                                                .firstname
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: theme
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Status
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "Status: ",
                                                          style: theme.textTheme
                                                              .titleMedium
                                                              ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey.shade700,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      12.0,
                                                                  vertical:
                                                                      6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: _getStatusColor(
                                                                currentRowData
                                                                    .attType
                                                                    .toString()),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: _getStatusColor(currentRowData
                                                                        .attType
                                                                        .toString())
                                                                    .withOpacity(
                                                                        0.4),
                                                                blurRadius: 5,
                                                                offset: Offset(
                                                                    0, 3),
                                                              ),
                                                            ],
                                                          ),
                                                          child: Text(
                                                            currentRowData
                                                                .attType
                                                                .toString(),
                                                            style: theme
                                                                .textTheme
                                                                .titleSmall
                                                                ?.copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          child:
                              Lottie.asset("assets/images/no_data_found.json"),
                        ),
                )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      default:
        return Colors.orange; // Default for other statuses
    }
  }
}

class ResultSource extends AdvancedDataTableSource<Resultlist> {
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
      return null; // Return null if the index is out of bounds
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
