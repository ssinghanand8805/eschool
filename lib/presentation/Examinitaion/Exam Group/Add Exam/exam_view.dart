import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/alert_dialogue.dart';
import '../../../../widgets/customTextField.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/myCustomsd.dart';
import 'exam_controller.dart';

class AddExamView extends GetView<AddExamController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MyButton(
                  width: 80,
                  title: 'New Exam',
                  textStyle: TextStyle(fontSize: 11, color: Colors.white),
                  color: theme.hintColor,
                  onPress: () {
                    newExamWidget(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: MyButton(
                  width: 80,
                  title: 'Link Exam',
                  textStyle: TextStyle(fontSize: 11, color: Colors.white),
                  color: theme.hintColor,
                  onPress: () {
                    linkExamWidget(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exam Group",
                        style: theme.textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text("Class 4 (Pass / Fail)",
                        style: theme.textTheme.labelMedium),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exam Type",
                        style: theme.textTheme.labelMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text("General Purpose (Pass/Fail)",
                        style: theme.textTheme.labelMedium),
                  ],
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Session')),
                  DataColumn(label: Text('Subjects Included')),
                  DataColumn(label: Text('Publish Exam')),
                  DataColumn(label: Text('Publish Result')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Icon(Icons.check_box_outlined)),
                      DataCell(Icon(Icons.check_box_outlined)),
                      DataCell(Text("A")),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              tooltip: "Assign/View Student",
                              icon: Icon(Icons.tag, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes
                                    .add_exam_assign_view_studentRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Subjects",
                              icon: Icon(Icons.book, size: 15),
                              onPressed: () async {
                                await Get.toNamed(
                                    AppRoutes.add_exam_exam_subjectRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Exam Marks",
                              icon: Icon(Icons.branding_watermark_sharp,
                                  size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.add_exam_markRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Teacher Remark",
                              icon: Icon(Icons.chat_bubble_outline, size: 15),
                              onPressed: () async {
                                await Get.toNamed(
                                    AppRoutes.add_exam_teacher_remarksRoute);
                              },
                            ),
                            IconButton(
                              tooltip: "Generate Rank",
                              icon: Icon(Icons.chrome_reader_mode, size: 15),
                              onPressed: () {
                                //editHomework(index);
                              },
                            ),
                            IconButton(
                              tooltip: "Edit",
                              icon: Icon(Icons.edit, size: 15),
                              onPressed: () {
                                print("Edit leave");
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
            ),
          ],
        ),
      ),
    );
  }

  newExamWidget(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exam",
              style: theme.textTheme.bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.examC.value,
                    hint: "Exam",
                    title: "",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyCustomSD(
                      listToSearch: controller.demo,
                      borderColor: Colors.grey,
                      valFrom: "name",
                      label: "Select Exam Type",
                      onChanged: (val) {}),
                ),
              ],
            ),
            Row(
              children: [
                Obx(() {
                  return Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value!;
                            print(value);
                          }),
                      Text("Faheem")
                    ],
                  );
                }),
                Obx(() {
                  return Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value!;
                            print(value);
                          }),
                      Text("Faheem")
                    ],
                  );
                })
              ],
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return Row(
                      children: [
                        Checkbox(
                            shape: CircleBorder(),
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value!;
                              print(value);
                            }),
                        Text("Faheem")
                      ],
                    );
                  });
                },
              ),
            ),
            CustomTextField(
              controller: controller.descriptionC.value,
              hint: "Description",
              maxLine: 3,
              title: "",
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {},
              ),
            ),
          ],
        )
      ],
    );
  }

  linkExamWidget(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        GetBuilder(
          init: controller,
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Link Exam",style: theme.textTheme.labelMedium!
                    .copyWith(fontWeight: FontWeight.bold,)),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: Get.width * 0.2,
                    dataRowHeight: 100,
                    columns: const [
                      DataColumn(label: Row(
                        children: [
                          Icon(Icons.check_box_outlined),
                          SizedBox(width: 25,),
                          Text("Exam")
                        ],
                      )),
                      DataColumn(label: Text('Weightage')),
                    ],
                    rows: controller.data.asMap().entries.map((entry) {
                      int index = entry.key;
                      return DataRow(
                        cells: [
                          DataCell(
                              Obx(() {
                                return Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                                        value: controller.isChecked.value,
                                        onChanged: (value) {
                                          controller.isChecked.value = value!;
                                          print(value);

                                        }),

                                    Text("Faheem")
                                  ],
                                );
                              })
                          ),
                          DataCell(
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all()
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none, // Make border invisible
                                              borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                            ),
                                            contentPadding: EdgeInsets.only(bottom: 5,left: 10)
                                        ),
                                        controller: controller.weightageC.value,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          controller.weightageCounter = double.tryParse(value) ?? 0.0;
                                        },
                                      ),
                                    ),

                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap:(){
                                              controller.weightageCounter++;
                                              controller.weightageC.value.text = '${controller.weightageCounter}';
                                            },
                                            child: Icon(Icons.arrow_drop_up)),

                                        InkWell(
                                            onTap:(){
                                              controller.weightageCounter--;
                                              controller.weightageC.value.text = '${controller.weightageCounter}';
                                            },
                                            child: Icon(Icons.arrow_drop_down)),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );







            // return Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(
            //       "Add Marks Grade",
            //       style: theme.textTheme.bodyMedium,
            //     ),
            //     SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: DataTable(
            //         dataRowHeight: 50,
            //         columns: [
            //           DataColumn(label: Text('Exam')),
            //           DataColumn(label: Text('Weightage')),
            //         ],
            //         rows: controller.exams.map((exam) {
            //           return DataRow(
            //             cells: [
            //               DataCell(
            //                 Row(
            //                   children: [
            //                     Checkbox(
            //                       value: exam.isChecked,
            //                       onChanged: (bool? value) {
            //                         exam.isChecked = value!;
            //                       },
            //                     ),
            //                     Expanded(child: Text(exam.name)),
            //                   ],
            //                 ),
            //               ),
            //               DataCell(
            //                   Container(
            //                     decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(10),
            //                         border: Border.all()
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         Container(
            //                           width: 150,
            //                           child: TextField(
            //                             decoration: InputDecoration(
            //                                 border: OutlineInputBorder(
            //                                   borderSide:
            //                                   BorderSide.none, // Make border invisible
            //                                   borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
            //                                 ),
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 10)
            //                             ),
            //                             controller: controller.weightageC.value,
            //                             keyboardType: TextInputType.number,
            //                             onChanged: (value) {
            //                               controller.weightageCounter++;
            //                               controller.weightageC.value.text = '${controller.weightageCounter}';
            //                             },
            //                           ),
            //                         ),
            //
            //                         Column(
            //                           children: [
            //                             InkWell(
            //                                 onTap:(){
            //                                   exam.weightage++;
            //                                   print(exam.weightage);
            //                                 },
            //                                 child: Icon(Icons.arrow_drop_up)),
            //
            //                             InkWell(
            //                                 onTap:(){
            //                                   exam.weightage--;
            //                                   controller.weightageC.value.text = '${controller.weightageCounter}';
            //                                 },
            //                                 child: Icon(Icons.arrow_drop_down)),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //               ),
            //             ],
            //           );
            //         }).toList(),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.bottomRight,
            //       child: MyButton(
            //         width: 120,
            //         title: 'Save',
            //         textStyle: TextStyle(
            //           color: Colors.black,
            //         ),
            //         color: Colors.green.shade100,
            //         onPress: () {},
            //       ),
            //     ),
            //   ],
            // );
          }
        )
      ],
    );
  }
}
