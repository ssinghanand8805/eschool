import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/myCustomsd.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import 'controller/daily_assignment_controller.dart';

class TeacherDailyAssignmentScreen extends StatefulWidget {
  const TeacherDailyAssignmentScreen({Key? key});

  @override
  State<TeacherDailyAssignmentScreen> createState() =>
      _TeacherDailyAssignmentScreenState();
}

class _TeacherDailyAssignmentScreenState extends State<TeacherDailyAssignmentScreen> {
  TeacherDailyAssignmentController controller =
  Get.put(TeacherDailyAssignmentController());

  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Daily Assignment List',
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomSD(
                    labelText: 'Class',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Class',
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
                  MyCustomSD(
                    labelText: 'Section',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Section',
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
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Subject Group',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Subject Group',
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
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Subject',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.students,
                    valFrom: "name",
                    label: 'Subject',
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
                        padding: const EdgeInsets.only(left: 3.0),
                        child: Text("Date",
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 14)),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: 43,
                        child: TextField(
                          style: theme.textTheme.bodySmall,
                          decoration: InputDecoration(
                            hintText:
                            DateFormat('dd/MM/yyyy').format(DateTime.now()),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5))),
                          ),
                          readOnly: true,
                          controller: controller.dateC.value,
                          onTap: () async {
                            final date = await getDate();
                            if (date != null) {
                              controller.dateC.value.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Button(text: 'Search', onTap: () {}, icon: Icons.search),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Daily Assignment List',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: MyTable())
                ],
              ),
            );
          }),
    );
  }

}


class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {

  TeacherDailyAssignmentController controller =
  Get.put(TeacherDailyAssignmentController());

  // void showEditLeave(int index) {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.zero,
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: MediaQuery.of(context).viewInsets,
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Text(
  //                     'Edit Leave',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 MyCustomSD(
  //                   hideSearch: true,
  //                   labelText: 'Class',
  //                   borderColor: Colors.grey,
  //                   listToSearch: controller.students,
  //                   valFrom: "name",
  //                   label: 'Class',
  //                   onChanged: (val) {
  //                     print(val);
  //                     // if(val!=null){
  //                     //   controller.updateDutyFor = val['id'];
  //                     //
  //                     // }
  //                     // else{
  //                     //   controller.updateDutyFor=0;
  //                     // }
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 MyCustomSD(
  //                   labelText: 'Section',
  //                   hideSearch: true,
  //                   borderColor: Colors.grey,
  //                   listToSearch:  controller.students,
  //                   valFrom: "name",
  //                   label: 'Section',
  //                   onChanged: (val) {
  //                     print(val);
  //                     // if(val!=null){
  //                     //   controller.updateDutyFor = val['id'];
  //                     //
  //                     // }
  //                     // else{
  //                     //   controller.updateDutyFor=0;
  //                     // }
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 MyCustomSD(
  //                   labelText: 'Student',
  //                   hideSearch: true,
  //                   borderColor: Colors.grey,
  //                   listToSearch: controller.students,
  //                   valFrom: "name",
  //                   label: 'Student',
  //                   onChanged: (val) {
  //                     print(val);
  //                     // if(val!=null){
  //                     //   controller.updateDutyFor = val['id'];
  //                     //
  //                     // }
  //                     // else{
  //                     //   controller.updateDutyFor=0;
  //                     // }
  //                   },
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(
  //                         left: 4.0,
  //                         bottom: 3,
  //                       ),
  //                       child: Text('Apply Date',
  //                           style: theme.textTheme.bodySmall!
  //                               .copyWith(fontSize: 14)),
  //                     ),
  //                     Container(
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.grey,
  //                           width: 1.0,
  //                         ),
  //                         borderRadius: BorderRadius.circular(5.0),
  //                       ),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 10.0, vertical: 12),
  //                           hintText: '04/05/2024',
  //                           hintStyle: TextStyle(color: Colors.grey),
  //                           border: InputBorder.none,
  //                         ),
  //                         readOnly: true,
  //                         onTap: () {
  //                           // Show date picker for apply date
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(
  //                         left: 4.0,
  //                         bottom: 3,
  //                       ),
  //                       child: Text('From Date',
  //                           style: theme.textTheme.bodySmall!
  //                               .copyWith(fontSize: 14)),
  //                     ),
  //                     Container(
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.grey,
  //                           width: 1.0,
  //                         ),
  //                         borderRadius: BorderRadius.circular(5.0),
  //                       ),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 10.0, vertical: 12),
  //                           hintText: '04/05/2024',
  //                           hintStyle: TextStyle(color: Colors.grey),
  //                           border: InputBorder.none,
  //                         ),
  //                         readOnly: true,
  //                         onTap: () {
  //                           // Show date picker for apply date
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.only(
  //                         left: 4.0,
  //                         bottom: 3,
  //                       ),
  //                       child: Text('To Date',
  //                           style: theme.textTheme.bodySmall!
  //                               .copyWith(fontSize: 14)),
  //                     ),
  //                     Container(
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.grey,
  //                           width: 1.0,
  //                         ),
  //                         borderRadius: BorderRadius.circular(5.0),
  //                       ),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 10.0, vertical: 12),
  //                           hintText: '04/05/2024',
  //                           hintStyle: TextStyle(color: Colors.grey),
  //                           border: InputBorder.none,
  //                         ),
  //                         readOnly: true,
  //                         onTap: () {
  //                           // Show date picker for apply date
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Padding(
  //                       padding:
  //                       const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
  //                       child: Text('Reason',
  //                           style: theme.textTheme.bodySmall!
  //                               .copyWith(fontSize: 14)),
  //                     ),
  //                     Container(
  //                       height: 40,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: Colors.green.shade50,
  //                           width: 1.0,
  //                         ),
  //                         borderRadius: BorderRadius.circular(5.0),
  //                       ),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           contentPadding: EdgeInsets.symmetric(
  //                               horizontal: 10.0, vertical: 12),
  //                           hintText: 'reason',
  //                           hintStyle: TextStyle(color: Colors.grey),
  //                           border: OutlineInputBorder(),
  //                         ),
  //                         onTap: () {
  //                           // Show date picker for apply date
  //                         },
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Text('Leave Status *', style: theme.textTheme.bodySmall),
  //                     Radio(
  //                       value: 'Pending',
  //                       groupValue: 'Approve',
  //                       onChanged: (value) {},
  //                     ),
  //                     Text('Pending', style: theme.textTheme.bodySmall),
  //                     Radio(
  //                       value: 'Disapprove',
  //                       groupValue: 'Approve',
  //                       onChanged: (value) {},
  //                     ),
  //                     Text('Disapprove', style: theme.textTheme.bodySmall),
  //                     Radio(
  //                       value: 'Approve',
  //                       groupValue: 'Approve',
  //                       onChanged: (value) {},
  //                     ),
  //                     Text('Approve', style: theme.textTheme.bodySmall),
  //                   ],
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     TextButton(
  //                       onPressed: () {
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Text('Cancel'),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         // Handle form submission
  //                         Navigator.of(context).pop();
  //                       },
  //                       child: Text('Save'),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 8,
        columns: const [
          DataColumn(label: Text('Student Name')),
          DataColumn(label: Text('Class')),
          DataColumn(label: Text('Section')),
          DataColumn(label: Text('Subject')),
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Submission Date')),
          DataColumn(label: Text('Evaluation Date')),
          DataColumn(label: Text('Evaluated By')),
          DataColumn(label: Text('Action')),
        ],
        rows: controller.data.asMap().entries.map((entry) {
          int index = entry.key;
          return DataRow(
            cells: [
              DataCell(Text(entry.value['studentName'],
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(entry.value['class'],
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(entry.value['section'],
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(
                  '${entry.value['applyDate'].day}/${entry.value['applyDate'].month}/${entry.value['applyDate'].year}',
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(
                  '${entry.value['fromDate'].day}/${entry.value['fromDate'].month}/${entry.value['fromDate'].year}',
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(
                  '${entry.value['toDate'].day}/${entry.value['toDate'].month}/${entry.value['toDate'].year}',
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(entry.value['status'],
                  style: theme.textTheme.bodySmall!)),
              DataCell(Text(entry.value['approvedBy'] ?? '',
                  style: theme.textTheme.bodySmall!)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, size: 15),
                      onPressed: () {
                        // showEditLeave(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, size: 15),
                      onPressed: () {
                        print("Delete leave");
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
