import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';

import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/datePickerTextField.dart';
// import '../add_homework/controller/add_homework_controller.dart';
// import '../add_homework/model/addHomework.dart';
import '../common_widgets/controller/CommonApiController.dart';
import 'controller/daily_assignment_controller.dart';
import 'model/DailyAssgnment.dart';

class TeacherDailyAssignmentScreen extends StatefulWidget {
  const TeacherDailyAssignmentScreen({Key? key});

  @override
  State<TeacherDailyAssignmentScreen> createState() =>
      _TeacherDailyAssignmentScreenState();
}

class _TeacherDailyAssignmentScreenState
    extends State<TeacherDailyAssignmentScreen> {
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

  CommonApiController commonApiController = Get.put(CommonApiController());
  CommonApiController controller3 = Get.put(CommonApiController());
  // AddHomeWorkController hcController = Get.put(AddHomeWorkController());

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
                children: <Widget>[
                  // Row(
                  //   children: [
                  //     Expanded(child: MyCustomSD(
                  //       hideSearch: true,
                  //       borderColor: Colors.grey,
                  //       listToSearch: controller3.classListModelMap.value,
                  //       valFrom: "className",
                  //       label: 'Class',
                  //       labelText: 'Class',
                  //       onChanged: (val) {
                  //         if (controller3.classListModelMap.value.length >
                  //             0) {
                  //           print("5555555555555");
                  //
                  //           controller3.selectedClassId.value =
                  //               val['id'].toString();
                  //           controller3.selectedClassName.value =
                  //               val['className'].toString();
                  //           controller3.update();
                  //           controller3.getSectionList();
                  //         }
                  //       },
                  //     )),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(child: MyCustomSD(
                  //       hideSearch: true,
                  //       borderColor: Colors.grey,
                  //       listToSearch: controller3.sectionListModelMap.value,
                  //       valFrom: "section",
                  //       label: 'Section',
                  //       labelText: 'Section',
                  //       onChanged: (val) {
                  //         print(val);
                  //         if (controller3.sectionListModelMap.value.length >
                  //             0) {
                  //           controller3.selectedSectionId.value =
                  //               val['id'].toString();
                  //           controller3.selectedSectionName.value =
                  //               val['section'].toString();
                  //           controller3.update();
                  //         }
                  //       },
                  //     ))
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: MyCustomSD(
                  //         labelText: 'Subject Group',
                  //         hideSearch: true,
                  //         borderColor: Colors.grey,
                  //         listToSearch: controller.students,
                  //         valFrom: "name",
                  //         label: 'Subject Group',
                  //         onChanged: (val) {
                  //           print(val);
                  //         },
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: MyCustomSD(
                  //         labelText: 'Subject',
                  //         hideSearch: true,
                  //         borderColor: Colors.grey,
                  //         listToSearch: controller.students,
                  //         valFrom: "name",
                  //         label: 'Subject',
                  //         onChanged: (val) {
                  //           print(val);
                  //
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 3.0),
                  //   child: Text("Date",
                  //       style: theme.textTheme.bodySmall!
                  //           .copyWith(fontSize: 14)),
                  // ),
                  // SizedBox(
                  //   height: 3,
                  // ),
                  // Container(
                  //   height: 43,
                  //   child: TextField(
                  //     style: theme.textTheme.bodySmall,
                  //     decoration: InputDecoration(
                  //       hintText:
                  //       DateFormat('dd/MM/yyyy').format(DateTime.now()),
                  //       border: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.grey),
                  //           borderRadius:
                  //           BorderRadius.all(Radius.circular(10))),
                  //     ),
                  //     readOnly: true,
                  //     controller: controller.dateC.value,
                  //     onTap: () async {
                  //       final date = await getDate();
                  //       if (date != null) {
                  //         controller.dateC.value.text =
                  //             DateFormat('dd/MM/yyyy').format(date);
                  //       }
                  //     },
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: MyButton(
                  //       title: 'Search',
                  //       width: 80,
                  //       color: Colors.green,
                  //       onPress: () {},
                  //     )),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() => MyCustomSD(
                          isLoading: commonApiController.isClassLoading.value,
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch:
                                  commonApiController.classListModelMap.value,
                              valFrom: "className",
                              label: 'Class',
                              labelText: 'Class',
                              onChanged: (val) {
                                print(val);
                                if (commonApiController
                                        .classListModelMap.value.length >
                                    0) {
                                  print("5555555555555");

                                  commonApiController.selectedClassId.value =
                                      val['id'].toString();
                                  commonApiController.selectedClassName.value =
                                      val['className'].toString();
                                  commonApiController.update();
                                  commonApiController.getSectionList();
                                }
                              },
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Obx(() {
                          return MyCustomSD(
                            isLoading: commonApiController.isSectionLoading.value,
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch:
                                commonApiController.sectionListModelMap.value,
                            valFrom: "section",
                            label: 'Section',
                            labelText: 'Section',
                            onChanged: (val) {
                              print(val);
                              if (val != null) {
                                if (commonApiController
                                        .sectionListModelMap.value.length >
                                    0) {
                                  commonApiController.selectedSectionId.value =
                                      val['section_id'].toString();
                                  commonApiController.selectedSectionName
                                      .value = val['section'].toString();
                                  commonApiController.update();
                                  controller.subjectGroup();
                                }
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() => MyCustomSD(
                              isLoading: controller.isSubjectGroupLoading.value,
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch:
                                  controller.subjectGroupList.value.length > 0
                                      ? controller.subjectGroupList.value
                                          .map((e) => e.toJson())
                                          .toList()
                                      : [],
                              valFrom: "name",
                              label: 'Subject Group',
                              labelText: 'Subject Group',
                              onChanged: (val) {
                                print(val);
                                if (val != null) {
                                  controller.updateSubjectGroupId.value =
                                      val['subject_group_id'];
                                  controller.subject();
                                }
                              },
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Obx(() => MyCustomSD(
                          isLoading: controller.isSubjectLoading.value,
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch:
                                  controller.subjectList.value.length > 0
                                      ? controller.subjectList.value
                                          .map((e) => e.toJson())
                                          .toList()
                                      : [],
                              valFrom: "name",
                              label: 'Subject',
                              labelText: 'Subject',
                              onChanged: (val) {
                                print(val);
                                if (val != null) {
                                  controller.updateSubjectId.value = val['id'];
                                }
                              },
                            )),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DatePickerTextField(
                            controller: controller.dateC.value,
                            title: 'Attendance date',
                            onDateSelected: (date) async {
                              controller.dateC.value.text = await GlobalData()
                                  .ConvertToSchoolDateTimeFormat(date);
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MyButton(
                        color: Colors.green,
                        width: 80,
                        title: 'Search',
                        onPress: () {
                          controller.getData();
                          // if (hcController.getSubjectGroupId.value.isEmpty &&
                          //     commonApiController
                          //         .selectedSectionId.value.isEmpty &&
                          //     commonApiController.selectedClassId.value.isEmpty) {
                          //   print("Select DropDown");
                          // } else {
                          //   modal.homework(context);
                          //   modal.closeHomework(context);
                          // }
                        },
                      ),
                    ],
                  ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDailyAssignment(context);
        },
        tooltip: 'Add Staff',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addDailyAssignment(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return GetBuilder(
            init: controller,
            builder: (_) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Add Assignment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: MyCustomSD(
                                isLoading: commonApiController.isClassLoading.value,
                                hideSearch: true,
                                labelText: 'Class',
                                borderColor: Colors.grey,
                                listToSearch:
                                    commonApiController.classListModelMap.value,
                                valFrom: "className",
                                label: 'Class',
                                onChanged: (val) {
                                  if (commonApiController
                                          .classListModelMap.value.length >
                                      0) {
                                    print("5555555555555");

                                    commonApiController.selectedClassId.value =
                                        val['id'].toString();
                                    commonApiController.selectedClassName
                                        .value = val['className'].toString();
                                    commonApiController.update();
                                    commonApiController.getSectionList();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Obx(() {
                                return MyCustomSD(
                                  isLoading: commonApiController.isSectionLoading.value,
                                  labelText: 'Section',
                                  hideSearch: true,
                                  borderColor: Colors.grey,
                                  listToSearch: commonApiController
                                      .sectionListModelMap.value,
                                  valFrom: "section",
                                  label: 'Section',
                                  onChanged: (val) {
                                    if (val != null) {
                                      if (commonApiController
                                              .sectionListModelMap
                                              .value
                                              .length >
                                          0) {
                                        commonApiController
                                                .selectedSectionId.value =
                                            val['section_id'].toString();
                                        commonApiController.selectedSectionName
                                            .value = val['section'].toString();
                                        commonApiController.update();
                                        controller.subjectGroup();
                                      }
                                    }
                                  },
                                );
                              }),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Obx(() => MyCustomSD(
                                isLoading: controller.isSubjectGroupLoading.value,
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch:
                                controller.subjectGroupList.value.length > 0
                                    ? controller.subjectGroupList.value
                                    .map((e) => e.toJson())
                                    .toList()
                                    : [],
                                valFrom: "name",
                                label: 'Subject Group',
                                labelText: 'Subject Group',
                                onChanged: (val) {
                                  print(val);
                                  if (val != null) {
                                    controller.updateSubjectGroupId.value =
                                    val['subject_group_id'];
                                    controller.subject();
                                  }
                                },
                              )),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Obx(() => MyCustomSD(
                                isLoading: controller.isSubjectLoading.value,
                                    hideSearch: true,
                                    borderColor: Colors.grey,
                                    listToSearch:
                                        controller.subjectList.value.length > 0
                                            ? controller.subjectList.value
                                                .map((e) => e.toJson())
                                                .toList()
                                            : [],
                                    valFrom: "name",
                                    label: 'Subject',
                                    labelText: 'Subject',
                                    onChanged: (val) {
                                      print(val);
                                      if (val != null) {
                                        controller.updateSubjectId.value =
                                            val['id'];
                                      }
                                    },
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text("Assignment Date",
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
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                      ),
                                      readOnly: true,
                                      controller: controller.homeWorkDate.value,
                                      onTap: () async {
                                        final date =
                                            await controller.getDate(context);
                                        if (date != null) {
                                          String formattedDate =
                                              await GlobalData()
                                                  .ConvertToSchoolDateTimeFormat(
                                                      date);
                                          controller.homeWorkDate.value.text =
                                              formattedDate;
                                          print("@@@@@@@@ " +
                                              controller
                                                  .homeWorkDate.value.text);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
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
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                      ),
                                      readOnly: true,
                                      controller:
                                          controller.submissionDate.value,
                                      onTap: () async {
                                        final date =
                                            await controller.getDate(context);
                                        if (date != null) {
                                          String formattedDate =
                                              await GlobalData()
                                                  .ConvertToSchoolDateTimeFormat(
                                                      date);
                                          controller.submissionDate.value.text =
                                              formattedDate;
                                        }
                                      },
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
                        InkWell(
                          onTap: () {
                            _showImagePicker(context);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: Colors.green.shade200)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_file, color: Colors.green),
                                Text(
                                  "Drag and drop a file here or click",
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                            controller: controller.HtmlController.value,
                            //required
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
                                controller.addAssignment(context);
                                //Navigator.of(context).pop();
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
            });
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      controller.pickedFile.value = File(pickedFile.path);
      controller.update();
    }
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Select Image Source',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListTile(
                    leading: Icon(
                      Icons.photo_library,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Pick from Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Take a Picture'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
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
  TeacherDailyAssignmentController controller =
      Get.put(TeacherDailyAssignmentController());
  @override
  Widget build(BuildContext context) {
    return controller.assignmentList.value.data != null
        ? ListView.builder(
            itemCount: controller.assignmentList.value.data!.length,
            itemBuilder: (context, index) {
              Assignment assignment =
                  controller.assignmentList.value.data![index];
              //  print("PPPPPP${student.attendenceTypeId}");
              //  controller.studentAttendaceDet[student.studentSessionId] =  student.attendenceTypeId.toString() == '1' ? 'P' : student.attendenceTypeId.toString() == '4' ? 'A' : student.attendenceTypeId.toString() == '5' ? 'L' : 'P';

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4,
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row with Student Name and Class
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Html(
                                  data: assignment.description!,
                                ),
                              ),
                              assignment.document != null
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.remove_red_eye_sharp))
                                  : SizedBox()
                              // Expanded(child: Text("File: ${assignment.document ?? ""}")),
                            ],
                          ),
                          const SizedBox(height: 5.0),

                          // Details Section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                assignment.className!,
                                style: theme.textTheme.bodySmall!.copyWith(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                "Section: ${assignment.section!}",
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Subject: ${assignment.subjectName!}",
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Submission Date: ${assignment.submitDate!}",
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Evaluated By: ${assignment.staffName! ?? 'N/A'}",
                                style: theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Evaluation Date: ${'Evaluation Date'}",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                          // Action Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  print("Edit pressed");
                                  Get.toNamed('/evaluateHomeWork',
                                      arguments: {"id": assignment.id});
                                  // Call edit function here
                                },
                                icon: const Icon(Icons.people, size: 16),
                                label: const Text("Students"),
                              ),
                              const SizedBox(width: 5.0),
                              TextButton.icon(
                                onPressed: () {
                                  print("Edit pressed");
                                  // Call edit function here
                                },
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text("Edit"),
                              ),
                              const SizedBox(width: 5.0),
                              TextButton.icon(
                                onPressed: () {
                                  print("Delete pressed");
                                  // Call delete function here
                                },
                                icon: const Icon(Icons.delete,
                                    size: 16, color: Colors.red),
                                label: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Text("No Data Found");
    // return SingleChildScrollView(
    //   child: Column(
    //     children: controller.assignmentList!.value.data.asMap().entries.map((entry) {
    //       int index = entry.key;
    //       var data = entry.value;
    //
    //       return Card(
    //         margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(12.0),
    //         ),
    //         elevation: 4,
    //         child: Container(
    //           decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Colors.green.shade100,
    //                 Colors.green.shade50,
    //               ],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight,
    //             ),
    //             borderRadius: BorderRadius.circular(20),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.grey.shade200,
    //                 blurRadius: 10,
    //                 offset: Offset(0, 4),
    //               ),
    //             ],
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 // Header Row with Student Name and Class
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       data['studentName'],
    //                       style: theme.textTheme.bodySmall!.copyWith(
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     Text(
    //                       data['class'],
    //                       style: theme.textTheme.bodySmall!.copyWith(
    //                         color: Colors.grey.shade600,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 5.0),
    //
    //                 // Details Section
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       "Section: ${data['section']}",
    //                       style: theme.textTheme.bodySmall,
    //                     ),
    //                     const SizedBox(height: 5.0),
    //                     Text(
    //                       "Subject: ${data['subject']}",
    //                       style: theme.textTheme.bodySmall,
    //                     ),
    //                     const SizedBox(height: 5.0),
    //                     Text(
    //                       "Submission Date: Submission Date",
    //                       style: theme.textTheme.bodySmall,
    //                     ),
    //                     const SizedBox(height: 5.0),
    //                     Text(
    //                       "Evaluated By: ${data['evaluatedBy'] ?? 'N/A'}",
    //                       style: theme.textTheme.bodySmall,
    //                     ),
    //                     const SizedBox(height: 5.0),
    //                     Text(
    //                       "Evaluation Date: ${'Evaluation Date'}",
    //                       style: theme.textTheme.bodySmall,
    //                     ),
    //                   ],
    //                 ),
    //                 // Action Buttons
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     TextButton.icon(
    //                       onPressed: () {
    //                         print("Edit pressed");
    //                         // Call edit function here
    //                       },
    //                       icon: const Icon(Icons.edit, size: 16),
    //                       label: const Text("Edit"),
    //                     ),
    //                     const SizedBox(width: 5.0),
    //                     TextButton.icon(
    //                       onPressed: () {
    //                         print("Delete pressed");
    //                         // Call delete function here
    //                       },
    //                       icon: const Icon(Icons.delete,
    //                           size: 16, color: Colors.red),
    //                       label: Text(
    //                         "Delete",
    //                         style: TextStyle(color: Colors.red),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     }).toList(),
    //   ),
    // );
  }
}
