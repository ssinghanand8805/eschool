
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/apiHelper/dependencies.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_button.dart';
import '../approve_leave/approve_leave_view.dart';
import '../common_widgets/controller/CommonApiController.dart';
import 'controller/add_homework_controller.dart';
import 'model/addHomework.dart';

class AddHomeWorkScreen extends StatefulWidget {
  const AddHomeWorkScreen({Key? key});

  @override
  State<AddHomeWorkScreen> createState() => _AddHomeWorkScreenState();
}

class _AddHomeWorkScreenState extends State<AddHomeWorkScreen> {
  AddHomeWorkController controller = Get.put(AddHomeWorkController());
  CommonApiController commonApiController = Get.put(CommonApiController());

  AddHomeWorkModal modal = AddHomeWorkModal();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Add Homework',
          style: theme.textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              // prefixIcon: Icon(
              //   Icons.add,size: 14,
              //   color: Colors.white,
              // ),
              title: 'Add Homework',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                showAddHomeWork();
              },
            ),
          ),
        ],

      ),
      body:
      GetBuilder(
          init: controller,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Class',
                          labelText: 'Class',
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
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Section',
                          labelText: 'Section',
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
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.students,
                        valFrom: "name",
                        label: 'Subject Group',
                        labelText: 'Subject Group',
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
                      ),),
                      SizedBox(
                        width: 5,
                      ),

                      Expanded(child:  MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.students,
                        valFrom: "name",
                        label: 'Subject',
                        labelText: 'Subject',
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
                      ),)
                    ],
                  ),



                  SizedBox(
                    height: 10,
                  ),
                  Button(text: 'Search', onTap: () {}, icon: Icons.search),
                  SizedBox(
                    height: 10,
                  ),
                  // Button(
                  //     text: 'Add',
                  //     onTap: () {
                  //       showAddHomeWork();
                  //     },
                  //     icon: Icons.add),
                  Text(
                    'Homework List',
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

  void showAddHomeWork() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return GetBuilder(
          init: modal.controller,
          builder: (_) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Add Homework',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: MyCustomSD(
                            hideSearch: true,
                            labelText: 'Class',
                            borderColor: Colors.grey,
                            listToSearch: commonApiController.classListModelMap.value,
                            valFrom: "className",
                            label: 'Class',
                            onChanged: (val) {
                              if(commonApiController.classListModelMap.value.length > 0)
                              {
                                print("5555555555555");

                                commonApiController.selectedClassId.value = val['id'].toString();
                                commonApiController.selectedClassName.value = val['className'].toString();
                                commonApiController.update();
                                commonApiController.getSectionList();
                              }
                            },
                          ),),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: Obx((){
                            return MyCustomSD(
                            labelText: 'Section',
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch: commonApiController.sectionListModelMap.value,
                            valFrom: "section",
                            label: 'Section',
                            onChanged: (val) {
                              if(val !=null){
                                if(commonApiController.sectionListModelMap.value.length > 0) {
                                  commonApiController.selectedSectionId.value = val['id'].toString();
                                  commonApiController.selectedSectionName.value = val['section'].toString();
                                  commonApiController.update();
                                  modal.subjectGroup();

                                }
                              }


                            },
                          );}),)
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: MyCustomSD(
                            labelText: 'Subject Group',
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch: controller.getListGroupList.value,
                            valFrom: "name",
                            label: 'Subject Group',
                            onChanged: (val) {
                              if(val !=null){
                                controller.updateSubjectGroupId = val['subject_group_id'];
                                modal.subject();
                              }



                            },
                          ),),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: MyCustomSD(
                            labelText: 'Subject',
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch: controller.getSubjectList.value,
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
                          ),),


                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text("Homework Date",
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
                                  controller: controller.homeWorkDate.value,
                                  onTap: () async {
                                    final date = await controller.getDate(context);
                                    if (date != null) {
                                      controller.homeWorkDate.value.text =
                                          DateFormat('dd/MM/yyyy').format(date);
                                      print("@@@@@@@@ "+controller.homeWorkDate.value.text);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),),
                          SizedBox(width: 5,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text("Submission Date",
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
                                    controller: controller.submissionDate.value,
                                    onTap: () async {
                                      final date = await controller.getDate(context);
                                      if (date != null) {
                                        controller.submissionDate.value.text =
                                            DateFormat('dd/MM/yyyy').format(date);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                 EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
                            child: Text('Max Mark',
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
                              controller: controller.maxMark.value,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 12),
                                hintText: 'reason',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(),
                              ),
                              onTap: () {
                                // Show date picker for apply date
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 150,
                        child: HtmlEditor(
                          htmlToolbarOptions: HtmlToolbarOptions(
                              toolbarItemHeight: 35,
                              toolbarType: ToolbarType.nativeGrid,
                              textStyle: theme.textTheme.titleMedium,
                              defaultToolbarButtons: [
                                const StyleButtons(),
                                const FontButtons(
                                    clearAll: true,
                                    strikethrough: false,
                                    subscript: false,
                                    superscript: false)
                              ]),
                          controller: controller.HtmlController.value, //required
                          htmlEditorOptions: const HtmlEditorOptions(
                            hint: "Please enter ...",
                            shouldEnsureVisible: true,
                            autoAdjustHeight: true,
                            adjustHeightForKeyboard: true,
                          ),
                          otherOptions: const OtherOptions(),
                        ),
                      ),
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
          }
        );
      },
    );
  }
}

// class MyTable extends StatefulWidget {
//   @override
//   _MyTableState createState() => _MyTableState();
// }
//
// class _MyTableState extends State<MyTable> {
//   AddHomeWorkController controller = Get.put(AddHomeWorkController());
//
//   void editHomework(int index) {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.zero,
//       ),
//       builder: (BuildContext context) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Edit Homework',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   MyCustomSD(
//                     hideSearch: true,
//                     labelText: 'Class',
//                     borderColor: Colors.grey,
//                     listToSearch: controller.students,
//                     valFrom: "name",
//                     label: 'Class',
//                     onChanged: (val) {
//                       print(val);
//                       // if(val!=null){
//                       //   controller.updateDutyFor = val['id'];
//                       //
//                       // }
//                       // else{
//                       //   controller.updateDutyFor=0;
//                       // }
//                     },
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   MyCustomSD(
//                     labelText: 'Section',
//                     hideSearch: true,
//                     borderColor: Colors.grey,
//                     listToSearch: controller.students,
//                     valFrom: "name",
//                     label: 'Section',
//                     onChanged: (val) {
//                       print(val);
//                       // if(val!=null){
//                       //   controller.updateDutyFor = val['id'];
//                       //
//                       // }
//                       // else{
//                       //   controller.updateDutyFor=0;
//                       // }
//                     },
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   MyCustomSD(
//                     labelText: 'Subject Group',
//                     hideSearch: true,
//                     borderColor: Colors.grey,
//                     listToSearch: controller.students,
//                     valFrom: "name",
//                     label: 'Subject Group',
//                     onChanged: (val) {
//                       print(val);
//                       // if(val!=null){
//                       //   controller.updateDutyFor = val['id'];
//                       //
//                       // }
//                       // else{
//                       //   controller.updateDutyFor=0;
//                       // }
//                     },
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   MyCustomSD(
//                     labelText: 'Subject',
//                     hideSearch: true,
//                     borderColor: Colors.grey,
//                     listToSearch: controller.students,
//                     valFrom: "name",
//                     label: 'Subject',
//                     onChanged: (val) {
//                       print(val);
//                       // if(val!=null){
//                       //   controller.updateDutyFor = val['id'];
//                       //
//                       // }
//                       // else{
//                       //   controller.updateDutyFor=0;
//                       // }
//                     },
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3.0),
//                         child: Text("Homework Date",
//                             style: theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: 14)),
//                       ),
//                       SizedBox(
//                         height: 3,
//                       ),
//                       Container(
//                         height: 43,
//                         child: TextField(
//                           style: theme.textTheme.bodySmall,
//                           decoration: InputDecoration(
//                             hintText:
//                                 DateFormat('dd/MM/yyyy').format(DateTime.now()),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5))),
//                           ),
//                           readOnly: true,
//                           controller: controller.homeWorkDate.value,
//                           onTap: () async {
//                             final date = await controller.getDate(context);
//                             if (date != null) {
//                               controller.homeWorkDate.value.text =
//                                   DateFormat('dd/MM/yyyy').format(date);
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 3.0),
//                         child: Text("Submission Date",
//                             style: theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: 14)),
//                       ),
//                       SizedBox(
//                         height: 3,
//                       ),
//                       Container(
//                         height: 43,
//                         child: TextField(
//                           style: theme.textTheme.bodySmall,
//                           decoration: InputDecoration(
//                             hintText:
//                                 DateFormat('dd/MM/yyyy').format(DateTime.now()),
//                             border: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(5))),
//                           ),
//                           readOnly: true,
//                           controller: controller.submissionDate.value,
//                           onTap: () async {
//                             final date = await controller.getDate(context);
//                             if (date != null) {
//                               controller.submissionDate.value.text =
//                                   DateFormat('dd/MM/yyyy').format(date);
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding:
//                             const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
//                         child: Text('Max Mark',
//                             style: theme.textTheme.bodySmall!
//                                 .copyWith(fontSize: 14)),
//                       ),
//                       Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.green.shade50,
//                             width: 1.0,
//                           ),
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: TextField(
//                           controller: controller.maxMark.value,
//                           decoration: InputDecoration(
//                             contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 10.0, vertical: 12),
//                             hintText: 'reason',
//                             hintStyle: TextStyle(color: Colors.grey),
//                             border: OutlineInputBorder(),
//                           ),
//                           onTap: () {
//                             // Show date picker for apply date
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 150,
//                     child: HtmlEditor(
//                       htmlToolbarOptions: HtmlToolbarOptions(
//                           toolbarItemHeight: 35,
//                           toolbarType: ToolbarType.nativeGrid,
//                           textStyle: theme.textTheme.titleMedium,
//                           defaultToolbarButtons: [
//                             const StyleButtons(),
//                             const FontButtons(
//                                 clearAll: true,
//                                 strikethrough: false,
//                                 subscript: false,
//                                 superscript: false)
//                           ]),
//                       controller: controller.HtmlController.value, //required
//                       htmlEditorOptions: const HtmlEditorOptions(
//                         hint: "Please enter ...",
//                         shouldEnsureVisible: true,
//                         autoAdjustHeight: true,
//                         adjustHeightForKeyboard: true,
//                       ),
//                       otherOptions: const OtherOptions(),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Handle form submission
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Save'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2, // Number of tabs
//       child: Column(
//         children: [
//           Container(
//             color: Colors.grey[300],
//             child: TabBar(
//               labelColor: Colors.black,
//               indicatorWeight: 2.0,
//               indicatorColor: Colors.green,
//               unselectedLabelColor: Colors.grey.shade600,
//               tabs: [
//                 Tab(
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       'Upcoming Homework',
//                       // style: theme.textTheme.titleSmall
//                     ),
//                   ),
//                 ),
//                 Tab(
//                   child: Container(
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Text(
//                       'Closed Homework',
//                       // style:  theme.textTheme.titleSmall
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 // Tab 1 content
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columnSpacing: 8,
//                     columns: const [
//                       DataColumn(label: Text('Class')),
//                       DataColumn(label: Text('Section')),
//                       DataColumn(label: Text('Subject Group')),
//                       DataColumn(label: Text('Subject')),
//                       DataColumn(label: Text('Homework Date')),
//                       DataColumn(label: Text('Submission Date')),
//                       DataColumn(label: Text('Evaluation Date')),
//                       DataColumn(label: Text('Created By')),
//                       DataColumn(label: Text('Action')),
//                     ],
//                     rows: controller.data.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       return DataRow(
//                         cells: [
//                           DataCell(Text(entry.value['class'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['section'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['subjectGroup'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['subject'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['homeworkDate'].day}/${entry.value['homeworkDate'].month}/${entry.value['homeworkDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['submissionDate'].day}/${entry.value['submissionDate'].month}/${entry.value['submissionDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['evaluationDate'].day}/${entry.value['evaluationDate'].month}/${entry.value['evaluationDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['createdBy'] ?? '',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit, size: 15),
//                                   onPressed: () {
//                                     editHomework(index);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, size: 15),
//                                   onPressed: () {
//                                     print("Delete leave");
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 // Tab 2 content
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columnSpacing: 8,
//                     columns: const [
//                       DataColumn(label: Text('Class')),
//                       DataColumn(label: Text('Section')),
//                       DataColumn(label: Text('Subject Group')),
//                       DataColumn(label: Text('Subject')),
//                       DataColumn(label: Text('Homework Date')),
//                       DataColumn(label: Text('Submission Date')),
//                       DataColumn(label: Text('Evaluation Date')),
//                       DataColumn(label: Text('Created By')),
//                       DataColumn(label: Text('Action')),
//                     ],
//                     rows: controller.data.asMap().entries.map((entry) {
//                       int index = entry.key;
//                       return DataRow(
//                         cells: [
//                           DataCell(Text(entry.value['class'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['section'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['subjectGroup'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['subject'],
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['homeworkDate'].day}/${entry.value['homeworkDate'].month}/${entry.value['homeworkDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['submissionDate'].day}/${entry.value['submissionDate'].month}/${entry.value['submissionDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(
//                               '${entry.value['evaluationDate'].day}/${entry.value['evaluationDate'].month}/${entry.value['evaluationDate'].year}',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(Text(entry.value['createdBy'] ?? '',
//                               style: theme.textTheme.bodySmall!)),
//                           DataCell(
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit, size: 15),
//                                   onPressed: () {
//                                     editHomework(index);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, size: 15),
//                                   onPressed: () {
//                                     print("Delete leave");
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
