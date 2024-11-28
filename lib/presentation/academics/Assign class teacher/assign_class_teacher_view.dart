import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Assign%20class%20teacher/assign_class_teacher_controller.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';

class AssignClassTeacherView extends GetView<AssignClassTeacherController> {
  AssignClassTeacherView({Key? key})
      : super(
          key: key,
        );
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
                          child: CircularProgressIndicator(),
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
                                                'Class: ${entry.classN}',
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
                                                  entry.name!,
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
            MyCustomSD(
                borderColor: Colors.grey,
                label: "Select Class",
                listToSearch: [],
                valFrom: 'name',
                onChanged: (val) {}),
            SizedBox(
              height: 20,
            ),
            MyCustomSD(
                borderColor: Colors.grey,
                label: "Select Section",
                listToSearch: [],
                valFrom: 'name',
                onChanged: (val) {}),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Text("Class Teachers",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
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
                  });
                }),
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
        ));
  }
}
