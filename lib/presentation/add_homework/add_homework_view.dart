import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_button.dart';
import '../common_widgets/controller/CommonApiController.dart';
import 'DataModal/close_homework_modal.dart';
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
          'Homework',
          style: theme.textTheme.bodyMedium,
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
              color: Colors.green,
              onPress: () {
                showAddHomeWork();
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
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
                        child: Obx(() => MyCustomSD(
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
                                  modal.subjectGroup();
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
                        child: MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.getListGroupList.value,
                          valFrom: "name",
                          label: 'Subject Group',
                          labelText: 'Subject Group',
                          onChanged: (val) {
                            print(val);
                            if (val != null) {
                              controller.updateSubjectGroupId =
                                  val['subject_group_id'];
                              modal.subject();
                            }
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
                          listToSearch: controller.getSubjectList.value,
                          valFrom: "name",
                          label: 'Subject',
                          labelText: 'Subject',
                          onChanged: (val) {
                            print(val);
                            if (val != null) {
                              controller.updateSubjectId = val['id'];
                            }
                          },
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MyButton(
                      color: Colors.green,
                      width: 80,
                      title: 'Search',
                      onPress: () {
                        if (controller.getSubjectGroupId.value.isEmpty &&
                            commonApiController
                                .selectedSectionId.value.isEmpty &&
                            commonApiController.selectedClassId.value.isEmpty) {
                          print("Select DropDown");
                        } else {
                          modal.homework(context);
                          modal.closeHomework(context);
                        }
                      },
                    ),
                  ),
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
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          modal.controller.isUpcomingHomeworkList.value =
                              "Upcoming homework";
                          modal.controller.update();
                        },
                        child: Container(
                          height: 40,
                          width: Get.width / 2.2,
                          decoration: BoxDecoration(
                            color:
                                modal.controller.isUpcomingHomeworkList.value ==
                                        "Upcoming homework"
                                    ? Colors.green.shade200
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Upcoming homework",
                              style: theme.textTheme.titleMedium,
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        onTap: () {
                          modal.controller.isUpcomingHomeworkList.value =
                              "Close homework";
                          modal.controller.update();
                        },
                        child: Container(
                          height: 40,
                          width: Get.width / 2.2,
                          decoration: BoxDecoration(
                            color:
                                modal.controller.isUpcomingHomeworkList.value ==
                                        "Close homework"
                                    ? Colors.green.shade200
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Close homework",
                              style: theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Upcoming homework",
                    child: CustomTextField(
                      controller: modal.controller.searchC.value,
                      hint: "search....",
                      title: "",
                      onChanged: (val) {
                        modal.controller.update();
                      },
                    ),
                  ),

                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Close homework",
                    child: CustomTextField(
                      controller: modal.controller.searchC.value,
                      hint: "search....",
                      title: "",
                      onChanged: (val) {
                        modal.controller.update();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Upcoming homework",
                    child: Expanded(
                      child: modal.controller.getHomeworkList.isEmpty
                          ? Center(
                              child: Container(
                                child: Lottie.asset(
                                    "assets/images/no_data_found.json"),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  modal.controller.getHomeworkList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                CloseHomeworkDataModal upcomingHomeWorkData =
                                    modal.controller.getHomeworkList[index];
                                return upcomingHomework(upcomingHomeWorkData);
                              },
                            ),
                    ),
                  ),
                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Close homework",
                    child: Expanded(
                      child: modal.controller.getCloseHomeworkList.isEmpty
                          ? Center(
                              child: Container(
                                child: Lottie.asset(
                                    "assets/images/no_data_found.json"),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  modal.controller.getCloseHomeworkList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                CloseHomeworkDataModal closeHomeworkData = modal
                                    .controller.getCloseHomeworkList[index];
                                return closeHomeWork(closeHomeworkData);
                              },
                            ),
                    ),
                  )

                  // Expanded(child: MyTable())
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
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Homework',
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
                                        modal.subjectGroup();
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
                                labelText: 'Subject Group',
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: controller.getListGroupList.value,
                                valFrom: "name",
                                label: 'Subject Group',
                                onChanged: (val) {
                                  if (val != null) {
                                    controller.updateSubjectGroupId =
                                        val['subject_group_id'];
                                    modal.subject();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Obx(() => MyCustomSD(
                                    labelText: 'Subject',
                                    hideSearch: true,
                                    borderColor: Colors.grey,
                                    listToSearch:
                                        controller.getSubjectList.value,
                                    valFrom: "name",
                                    label: 'Subject',
                                    onChanged: (val) {
                                      if (val != null) {
                                        print("dddd" + val.toString());
                                        controller.updateAddSubjectId =
                                            val['id'];
                                      }

                                      // if(val!=null){
                                      //   controller.updateDutyFor = val['id'];
                                      //
                                      // }
                                      // else{
                                      //   controller.updateDutyFor=0;
                                      // }
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
                                        hintText: DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now()),
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
                                        hintText: DateFormat('dd/MM/yyyy')
                                            .format(DateTime.now()),
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
                                modal.addHomeWork(context);
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

Widget upcomingHomework(CloseHomeworkDataModal upcomingHomework) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Image Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(10),
                  //   child: upcomingHomework. != null &&
                  //       upcomingHomework.imageUrl!.isNotEmpty
                  //       ? Image.network(
                  //     upcomingHomework.imageUrl!,
                  //     width: 80,
                  //     height: 80,
                  //     fit: BoxFit.cover,
                  //   )
                  //       : Container(
                  //     width: 80,
                  //     height: 80,
                  //     color: Colors.grey.shade300,
                  //     child: Icon(Icons.image, color: Colors.grey.shade600),
                  //   ),
                  // ),
                  // const SizedBox(width: 16),
                  // Title Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          upcomingHomework.homeworkName
                                  .toString()
                                  .capitalizeFirst ??
                              "No Title",
                          style: theme.textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Class: ${upcomingHomework.className} | Section: ${upcomingHomework.section}",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Details Section
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Homework Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Homework Date:",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        upcomingHomework.homeworkDate ?? "N/A",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  // Submission Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Submission Date:",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        upcomingHomework.submitDate ?? "N/A",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Evaluation Date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Evaluation Date:",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        upcomingHomework.evaluationDate ?? "N/A",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  // Created By
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Created By:",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        upcomingHomework.staffInfo ?? "N/A",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

closeHomeWork(CloseHomeworkDataModal closeHomeworkData) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Title and Icon
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Homework Title
                Expanded(
                  child: Text(
                    closeHomeworkData.homeworkName ?? "No Title Available",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Status Icon
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 24,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          // Details Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Class and Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem("Class", closeHomeworkData.className),
                    _buildDetailItem("Section", closeHomeworkData.section),
                  ],
                ),
                const SizedBox(height: 8),
                // Subject Group and Subject
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                        "Subject Group", closeHomeworkData.subjectName),
                    _buildDetailItem("Subject", closeHomeworkData.subjectName),
                  ],
                ),
                const SizedBox(height: 8),
                // Dates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                        "Homework Date", closeHomeworkData.homeworkDate),
                    _buildDetailItem(
                        "Submission Date", closeHomeworkData.submitDate),
                  ],
                ),
                const SizedBox(height: 8),
                // Evaluation Date and Creator
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDetailItem(
                        "Evaluation Date", closeHomeworkData.evaluationDate),
                    _buildDetailItem("Created by", closeHomeworkData.staffInfo),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper function for creating consistent detail items
Widget _buildDetailItem(String label, String? value) {
  return Row(
    children: [
      Text(
        "$label: ",
        style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      ),
      Text(
        value ?? "N/A",
        style: theme.textTheme.bodySmall,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
