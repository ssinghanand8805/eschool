import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Assign%20class%20teacher/assign_class_teacher_controller.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/controller/CommonApiController.dart';

class AssignClassTeacherView extends GetView<AssignClassTeacherController> {
  AssignClassTeacherView({Key? key})
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
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Column(
              children: [
                // Search Field
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: CustomTextField(
                    controller: controller.searchC.value,
                    hint: 'Search.... ',
                    title: '',
                  ),
                ),
                const SizedBox(height: 15),

                Expanded(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CustomLoader(),
                        )
                      : (controller.assignClassList.value.data
                                      ?.assignteacherlist ==
                                  null ||
                              controller.assignClassList.value.data!
                                  .assignteacherlist!.isEmpty)
                          ? Center(
                              child: Container(
                                child: Lottie.asset(
                                    "assets/images/no_data_found.json"),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.assignClassList.value.data!
                                  .assignteacherlist!.length,
                              itemBuilder: (context, index) {
                                final entry = controller.assignClassList.value
                                    .data!.assignteacherlist![index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Class Info
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Class: ${entry.classN.toString().capitalizeFirst}',
                                                style: theme
                                                    .textTheme.titleMedium!
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              Text(
                                                'Section: ${entry.section}',
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          // Class Teacher
                                          Row(
                                            children: [
                                              Text(
                                                'Class Teacher:',
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                "${entry.name!}  (${entry.employeeId})",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      theme.textTheme.bodySmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          // Action Buttons
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit,
                                                    color: Colors.blue,
                                                    size: 18),
                                                onPressed: () {
                                                  // Edit action
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(Icons.delete,
                                                    color: Colors.red,
                                                    size: 18),
                                                onPressed: () {
                                                  controller.deleteGallery(
                                                      context,
                                                      entry.classId,
                                                      entry.sectionId);
                                                  // Delete action
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addAssignClassTeacher(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  addAssignClassTeacher(context) {
    showCustomBottomSheet(
        context: context,
        child: Column(
          children: [
            Text(
              "Add Content Type",
              style: theme.textTheme.bodyMedium,
            ),
            SizedBox(height: 10,),
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
              height: 20,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text("Class Teachers",
                    style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold))),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
                    return Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.isChecked.value = value!;
                              print(value);
                            }),
                        Text(controller.getClassTeacherList.value.data![index].name!, style: theme.textTheme.bodyMedium)
                      ],
                    );
                  });
                }),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.green,
                ),
                color: Colors.green,
                onPress: () {},
              ),
            ),
          ],
        ));
  }
}
