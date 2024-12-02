import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/promote_student_controller.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';
import '../../common_widgets/controller/CommonApiController.dart';

class PromoteStudentView extends GetView<PromoteStudentController> {
  PromoteStudentView({Key? key})
      : super(
          key: key,
        );

  CommonApiController controller3 = Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Promote Student',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Obx(() => MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller3.classListModelMap.value,
                          valFrom: "className",
                          label: 'Class',
                          labelText: 'Class',
                          onChanged: (val) {
                            if (controller3.classListModelMap.value.length >
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
                          listToSearch: controller3.sectionListModelMap.value,
                          valFrom: "section",
                          label: 'Section',
                          labelText: 'Section',
                          onChanged: (val) {
                            print(val);
                            if (controller3.sectionListModelMap.value.length >
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
                height: 10,
              ),

              Obx(() => MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.SessionlistModelMap.value,
                valFrom: "session",
                label: 'Promote Students In Next Session',
                labelText: 'Promote Students In Next Session',
                onChanged: (val) {
                  print(val);
                  if (controller.SessionlistModelMap.value.length >
                      0) {
                    controller.selectedSessionId.value =
                        val['id'].toString();
                    controller.selectedSessionName.value =
                        val['session'].toString();
                    controller.update();
                  }
                },
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => MyCustomSD(
                      hideSearch: false,
                      borderColor: Colors.grey,
                      listToSearch: controller.pramotedClasslistModelMap.value,
                      valFrom: "className",
                      label: 'Promote Class',
                      labelText: 'Promote Class',
                      onChanged: (val) {
                        print("fffffff${controller.pramotedClasslistModelMap.value}");

                        if (controller.pramotedClasslistModelMap.value.length >
                            0) {
                          print("5555555555555");

                          controller.pramotedSelectedClassId.value =
                              val['id'].toString();
                          controller.getSectionList();
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
                      listToSearch: controller.pramotedSectionListModelMap.value,
                      valFrom: "section",
                      label: 'Section',
                      labelText: 'Section',
                      onChanged: (val) {
                        print(val);
                        if (controller.pramotedSectionListModelMap.value.length >
                            0) {
                          controller.pramotedSelectedSectionId.value =
                              val['id'].toString();
                          controller3.update();
                        }
                      },
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MyButton(
                  width: 80,
                  color: Colors.green,
                  textStyle: TextStyle(color: Colors.white),
                  title: 'Search',
                  onPress: () {
                    controller.findStudentList();
                   // print("object");
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Student List",
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              controller.studentList.value.data != null && controller.studentList.value.data!.resultlist!.length > 0 ?
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.studentList.value.data!.resultlist!.length,
                      itemBuilder: (context, index) {
                        final student = controller.studentList.value.data!.resultlist![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => Checkbox(
                                          value: true == controller.selecetedStudents[student.id],
                                          onChanged: (value) {
                                            controller.selecetedStudents[student.id] = !controller.selecetedStudents[student.id];
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Admission No: ${student.admissionNo}",
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Student Name: ${student.firstname}",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Father Name: ${student.fatherName}",
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Date of Birth: ${student.dob}",
                                    style: theme.textTheme.bodySmall,
                                  ),

                                  SizedBox(height: 5),
                                  Obx(() {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Current Result",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            _customRadioButton(
                                              title: "Pass",
                                              isSelected:  true == controller.isPassed[student.id],
                                              onTap: () {
                                                controller.isPassed[student.id] = true;
                                              },
                                            ),
                                            _customRadioButton(
                                              title: "Fail",
                                              isSelected:  false == controller.isPassed[student.id],
                                              onTap: () {
                                                controller.isPassed[student.id] = false;
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children:[
                                            Text(
                                              "Next Session Status",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            _customRadioButton(
                                              title: "Continue",
                                              isSelected: true ==  controller.isContinue[student.id],
                                              onTap: () {
                                                controller.isContinue[student.id] = true;
                                              },
                                            ),
                                            _customRadioButton(
                                              title: "Leave",
                                              isSelected:  false ==  controller.isContinue[student.id],
                                              onTap: () {
                                                controller.isContinue[student.id] = false;
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );

                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ) :
              Text("No data Found"),
              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MyButton(
                    width: 80,
                    color: Colors.green,
                    textStyle: TextStyle(color: Colors.white),
                    title: 'Promote',
                    onPress: () {
                      print("Promote");
                      controller.promoteStudent();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customRadioButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 17,
            width: 17,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8),
          Text(
            title,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
