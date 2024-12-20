import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:lottie/lottie.dart';

import '../../apiHelper/GlobalData.dart';
import '../../widgets/alert_dialogue.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/datePickerTextField.dart';
import '../../widgets/myCustomsd.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../teacher_daily_assignment/controller/daily_assignment_controller.dart';
import '../teacher_daily_assignment/model/DailyAssgnment.dart';
import 'class_work_controller.dart';
import 'class_work_modal.dart';

class ClassWorkPage extends GetView<ClassWorkController> {
  CommonApiController commonApiController = Get.put(CommonApiController());
  CommonApiController controller3 = Get.put(CommonApiController());
  // AddHomeWorkController hcController = Get.put(AddHomeWorkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Class Work',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Obx(() => MyCustomSD(
                          isLoading: commonApiController.isClassLoading.value ,
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
                            isLoading: commonApiController.isSectionLoading.value ,
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
                          isLoading: controller.isSubjectGroupLoading.value ,
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
                          isLoading: controller.isSubjectLoading.value ,
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
                  DatePickerTextField(
                      controller: controller.dateC.value,
                      title: 'Class Work date',
                      onDateSelected: (date) async {
                        controller.dateC.value.text = await GlobalData()
                            .ConvertToSchoolDateTimeFormat(date);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(() => MyButton(
                      isLoading: controller.isFetchDataLoading.value,
                      color: Colors.green,
                      width: 80,
                      title: 'Search',
                      onPress: () {
                        controller.getData();
                      },
                    )),
                  ),
                  Text(
                    'Class Work List',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(child: MyTable())
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addDailyClassWork(context);
        },
        tooltip: 'Add Class Work',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addDailyClassWork(BuildContext context) {
    showCustomBottomSheet(
        context: context,
        child: GetBuilder(
            init: controller,
            builder: (_) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Add Class Work',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: MyCustomSD(
                              isLoading:commonApiController.isClassLoading.value,
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
                                  commonApiController.selectedClassName.value =
                                      val['className'].toString();
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
                                            .sectionListModelMap.value.length >
                                        0) {
                                      commonApiController.selectedSectionId
                                          .value = val['section_id'].toString();
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
                            child: MyCustomSD(
                              isLoading: controller.isSubjectGroupLoading.value ,
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
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Obx(() => MyCustomSD(
                              isLoading: controller.isSubjectLoading.value ,
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
                                    controller: controller.classWorkDate.value,
                                    onTap: () async {
                                      final date =
                                          await controller.getDate(context);
                                      if (date != null) {
                                        String formattedDate =
                                            await GlobalData()
                                                .ConvertToSchoolDateTimeFormat(
                                                    date);
                                        controller.classWorkDate.value.text =
                                            formattedDate;
                                        print("@@@@@@@@ " +
                                            controller
                                                .classWorkDate.value.text);
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
                                    controller: controller.submissionDate.value,
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
                              border: Border.all(color: Colors.green.shade200)),
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
                          MyButton(
                            color: Colors.green,
                            width: 80,
                            title: 'Cancel',
                            onPress: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Obx(() => MyButton(
                            isLoading: controller.isAdding.value,
                            color: Colors.green,
                            width: 80,
                            title: 'Save',
                            onPress: () {
                              controller.addClassWork(context);
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
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
  ClassWorkController controller =
      Get.put(ClassWorkController());
  @override
  Widget build(BuildContext context) {
    return controller.classList.length > 0
        ? ListView.builder(
            itemCount: controller.classList.length,
            itemBuilder: (context, index) {
              Classwork classWork =
                  controller.classList.value[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10.0),
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
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Html(
                                data: classWork.description,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Class: ${classWork.className!}",
                                style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              "Section: ${classWork.section!}",
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Subject: ${classWork.subjectName!}",
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Date: ${classWork.createDate!}",
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Document: ${classWork.document ?? 'N/A'}",
                              style: theme.textTheme.bodySmall,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Staff: ${classWork.staffName ?? 'N/A'}",
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Container(
            child: Lottie.asset("assets/images/no_data_found.json"),
          );
  }
}
