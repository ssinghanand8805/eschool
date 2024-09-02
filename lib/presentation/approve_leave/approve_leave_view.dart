import 'dart:async';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme_helper.dart';

import '../../widgets/button.dart';
import '../../widgets/myCustomsd.dart';
import '../common_filter/CommonFilter.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/approve_leave_controller.dart';
import 'model/ApproveLeave.dart';

class ApproveLeaveScreen extends StatefulWidget {
  const ApproveLeaveScreen({Key? key});

  @override
  State<ApproveLeaveScreen> createState() => _ApproveLeaveScreenState();
}

class _ApproveLeaveScreenState extends State<ApproveLeaveScreen> {
  ApproveLeaveController controller = Get.put(ApproveLeaveController());



  @override
  void initState() {
    super.initState();
  }


  CommonApiController commonApiController =
  Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Approve Leave',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return CommonFilter(onTapAction: controller.filterData, widgetMain: MyTable(),);
          }),
      floatingActionButton: FloatingActionButton(
    onPressed: () {
      print("dd");
      showAddLeave();
    },
          child: Icon(Icons.add),
      backgroundColor: Colors.green.shade400,
      ),
    );
  }


  getMainWidget()
  {
    return MyTable();
  }
  getDate() async {

    var date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }
  void showAddLeave() {
    CommonApiController controller3 =
    Get.put(CommonApiController());
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Edit Leave',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyCustomSD(

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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Student',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students.value.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "firstname",
                    label: 'Student',
                    onChanged: (val) {
                      print(val);
                      // if(val!=null){
                      //   controller.updateDutyFor = val['id'];
                      //
                      // }
                      // else{
                      //   controller.updateDutyFor=0;
                      // }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('Apply Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),

                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          controller: controller.applyLeaveDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.applyLeaveDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('From Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          controller: controller.fromDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.fromDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('To Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: '04/05/2024',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          controller: controller.toDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.toDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
                        child: Text('Reason',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green.shade50,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: 'reason',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          controller: controller.reasonController.value,
                          onTap: () {
                            // Show date picker for apply date
                          },
                        ),
                      ),
                    ],
                  ),
                  Obx( () => Row(
                    children: [
                      Text('Leave Status *', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Pending',
                        groupValue: controller.selectedStatus.value,
                        onChanged: (value) {
                          controller.selectedStatus.value = value.toString();
                          controller.update();
                        },
                      ),
                      Text('Pending', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Disapprove',
                        groupValue:  controller.selectedStatus.value,
                        onChanged: (value) {
                          controller.selectedStatus.value = value.toString();
                          controller.update();
                        },
                      ),
                      Text('Disapprove', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Approve',
                        groupValue:  controller.selectedStatus.value,
                        onChanged: (value) {

                          controller.selectedStatus.value = value.toString();
                          controller.update();

                        },
                      ),
                      Text('Approve', style: theme.textTheme.bodySmall),
                    ],
                  ) ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle form submission
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  ApproveLeaveController controller = Get.put(ApproveLeaveController());
  CommonApiController controller3 =
  Get.put(CommonApiController());


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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: controller.isLoadingStudentList.isTrue ? CustomLoader() :  getTableData()),
      ],
    );

  }



  getTableData()
  {
    // var rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
    // final source =  ResultSource(controller.filteredStudentListModel);
    return Column(
      children: [
        TextField(
          controller: controller.searchController.value,
          decoration: InputDecoration(
            labelText: 'Search Students',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
        ),
        controller.filteredStudentListModel.value.length == 0 ?
        Text("No Data") :
        SingleChildScrollView(
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
              DataColumn(label: Text('Student Name')),
              DataColumn(label: Text('Class')),
              DataColumn(label: Text('Section')),
              DataColumn(label: Text('Apply Date')),
              DataColumn(label: Text('From Date')),
              DataColumn(label: Text('To Date')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Approve Disapprove By')),
              DataColumn(label: Text('Action')),
            ],
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
        Text(currentRowData.className!),
      ),
      DataCell(
        Text(currentRowData.section!),
      ),
      DataCell(
        Text(currentRowData.applyDate!),
      ),
      DataCell(
        Text(currentRowData.fromDate!),
      ),
       DataCell(
        Text(currentRowData.toDate!),
      ),
      DataCell(
        Text(currentRowData.status!),
      ),
      DataCell(
        Text(currentRowData.approveBy == null ? "-" : currentRowData.approveBy!),
      ),
      DataCell(
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, size: 15),
                onPressed: () {
                  showEditLeave(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, size: 15),
                onPressed: () {
                  print("Delete leave");
                },
              ),
            ],
          )
      ),

    ]);
  }
  getDate() async {

    var date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }
  void showEditLeave(int index) {
    CommonApiController controller3 =
    Get.put(CommonApiController());
    ApproveLeaveController controller = Get.put(ApproveLeaveController());
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Edit Leave',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MyCustomSD(

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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
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
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Student',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students.value.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "firstname",
                    label: 'Student',
                    onChanged: (val) {
                      print(val);
                      // if(val!=null){
                      //   controller.updateDutyFor = val['id'];
                      //
                      // }
                      // else{
                      //   controller.updateDutyFor=0;
                      // }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('Apply Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),

                            border: InputBorder.none,
                          ),
                          readOnly: true,
                          controller: controller.applyLeaveDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.applyLeaveDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('From Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          controller: controller.fromDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.fromDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 4.0,
                          bottom: 3,
                        ),
                        child: Text('To Date',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: '04/05/2024',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          controller: controller.toDateController.value,
                          onTap: () async {
                            // Show date picker for apply date
                            final date = await getDate();
                            if (date != null) {
                              controller.toDateController.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                              controller.update();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
                        child: Text('Reason',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green.shade50,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            hintText: 'reason',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          controller: controller.reasonController.value,
                          onTap: () {
                            // Show date picker for apply date
                          },
                        ),
                      ),
                    ],
                  ),
                  Obx( () => Row(
                    children: [
                      Text('Leave Status *', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Pending',
                        groupValue: controller.selectedStatus.value,
                        onChanged: (value) {
                          controller.selectedStatus.value = value.toString();
                          controller.update();
                        },
                      ),
                      Text('Pending', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Disapprove',
                        groupValue:  controller.selectedStatus.value,
                        onChanged: (value) {
                          controller.selectedStatus.value = value.toString();
                          controller.update();
                        },
                      ),
                      Text('Disapprove', style: theme.textTheme.bodySmall),
                      Radio(
                        value: 'Approve',
                        groupValue:  controller.selectedStatus.value,
                        onChanged: (value) {

                          controller.selectedStatus.value = value.toString();
                          controller.update();

                        },
                      ),
                      Text('Approve', style: theme.textTheme.bodySmall),
                    ],
                  ) ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Handle form submission
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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


