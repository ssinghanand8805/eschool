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
          'Assign Class Teacher',
          style: theme.textTheme.titleLarge,
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
              Align(
                alignment: Alignment.centerRight,
                child: MyButton(
                  width: 80,
                  color: Colors.green,
                  textStyle: TextStyle(color: Colors.white),
                  title: 'Search',
                  onPress: () {
                    print("object");
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        final student = controller.data[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: controller.isChecked.value,
                                      onChanged: (value) {
                                        controller.isChecked.value = value!;
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Admission No: ${student['admissionNo']}",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Student Name: ${student['studentName']}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Father Name: ${student['fatherName']}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Date of Birth: ${student['dob']}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Current Result: ${student['currentResult']}",
                                  style: theme.textTheme.bodySmall,
                                ),
                                SizedBox(height: 5),
                                Obx(() {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _customRadioButton(
                                        title: "Pass",
                                        isSelected: controller.isChecked.value,
                                        onTap: () {
                                          controller.isChecked.value = true;
                                        },
                                      ),
                                      _customRadioButton(
                                        title: "Fail",
                                        isSelected: !controller.isChecked.value,
                                        onTap: () {
                                          controller.isChecked.value = false;
                                        },
                                      ),
                                      _customRadioButton(
                                        title: "Continue",
                                        isSelected: controller.isChecked.value,
                                        onTap: () {
                                          controller.isChecked.value = true;
                                        },
                                      ),
                                      _customRadioButton(
                                        title: "Leave",
                                        isSelected: !controller.isChecked.value,
                                        onTap: () {
                                          controller.isChecked.value = false;
                                        },
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
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
