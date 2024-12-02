import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject%20Group/subject_group_controller.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class SubjectGroupView extends GetView<SubjectGroupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Subject List',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: controller.searchC.value,
              hint: 'Search.... ',
              title: '',
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Name",
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Class (Section)	",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Subject",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Action",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<SubjectGroupController>(
                builder: (controller) {
                  if (controller.subjectGroupList.value.data == null ||
                      controller.subjectGroupList.value.data!.subjectgroupList!
                          .isEmpty) {
                    return Center(child: CustomLoader());
                  }

                  return ListView.builder(
                    itemCount: controller
                        .subjectGroupList.value.data!.subjectgroupList!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final subject = controller.subjectGroupList.value.data!
                          .subjectgroupList![index];

                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
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
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Subject Name
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    subject.name!.capitalizeFirst ?? "",
                                    style:
                                        theme.textTheme.bodySmall!.copyWith(),
                                  ),
                                ),

                                // Subject Code
                                Expanded(
                                  flex: 2,
                                  child: ListView.builder(
                                      itemCount: subject.sections!.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text(
                                          " ${subject.sections![index].classN} (${subject.sections![index].section})",
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodySmall!
                                              .copyWith(),
                                        );
                                      }),
                                ),

                                // Subject Type
                                Expanded(
                                  flex: 2,
                                  child: ListView.builder(
                                    itemCount: subject.groupSubject!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      String sectionText = index < subject.sections!.length
                                          ? " (${subject.sections![index].section})"
                                          : "";
                                      return Text(
                                        " ${subject.groupSubject![index].name}$sectionText",
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme.bodySmall!.copyWith(),
                                      );
                                    },
                                  ),
                                ),

                                // Actions
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text(
                                              "Confirm Delete",
                                              style: theme.textTheme.bodyLarge,
                                            ),
                                            content: Text(
                                              "Are you sure you want to delete this subject? This action cannot be undone.",
                                              style: theme.textTheme.bodySmall,
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  controller.deleteSubject(
                                                      context,
                                                      subject
                                                          .id); // Perform delete
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     controller.resetData();
      //     addSubjectGroup(context);
      //   },
      //   tooltip: 'Add Item',
      //   shape: CircleBorder(),
      //   backgroundColor: Colors.green,
      //   foregroundColor: Colors.white,
      //   child: Icon(Icons.add),
      // )
    );
  }

  addSubjectGroup(context) {
    showCustomBottomSheet(
        context: context,
        child: Column(
          children: [
            controller.selectedSubjectId.value == ''
                ? Text(
                    "Add Subject",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                : Text(
                    "Update Subject",
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
            CustomTextField(
              controller: controller.nameC.value,
              hint: "Subject ....",
              title: "",
            ),
            Row(
              children: [
                Obx(() {
                  return Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: controller.isTheory.value,
                        onChanged: (value) {
                          if (value == true) {
                            controller.isTheory.value = true;
                            controller.isPractical.value = false;
                          }
                        },
                      ),
                      Text("Section A"),
                    ],
                  );
                }),
                Obx(() {
                  return Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: controller.isPractical.value,
                        onChanged: (value) {
                          if (value == true) {
                            controller.isPractical.value = true;
                            controller.isTheory.value = false;
                          }
                        },
                      ),
                      Text("Section B"),
                    ],
                  );
                }),
              ],
            ),
            CustomTextField(
              controller: controller.descriptionC.value,
              hint: 'Description.........',
              title: 'Description',
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: controller.selectedSubjectId.value == ''
                    ? 'Save'
                    : "Update",
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () async {
                  await controller.addSubject();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ));
  }
}
