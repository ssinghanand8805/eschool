import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject/subject_controller.dart';
import 'package:learnladderfaculity/presentation/academics/Subject/subject_modal.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class SubjectView extends GetView<SubjectController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title: Text(
            'Subject List',
            style: theme.textTheme.titleLarge,
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
                        "Subject",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Subject Code",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Subject Type",
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

              // Data List Section
              Expanded(
                child: GetBuilder<SubjectController>(
                  builder: (controller) {
                    if ( controller
                        .subjectList.value.data!.subjectlist!.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }


                    return ListView.builder(
                      itemCount: controller
                          .subjectList.value.data!.subjectlist!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final subject = controller
                            .subjectList.value.data!.subjectlist![index];

                        return Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),

                                // Subject Code
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    subject.code!.capitalizeFirst ?? "",
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),

                                // Subject Type
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    subject.type!.capitalizeFirst ?? "",
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),

                                // Actions
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          await controller.viewData(subject.id);
                                          addSubject(context);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Confirm Delete",style: theme.textTheme.bodyLarge,),
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
                                    ],
                                  ),
                                ),
                              ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.resetData();
            addSubject(context);
          },
          tooltip: 'Add Item',
          shape: CircleBorder(),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ));
  }

  addSubject(context) {
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
              controller: controller.subjectNameC.value,
              hint: "Subject Name....",
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
                      Text("Theory"),
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
                      Text("Practical"),
                    ],
                  );
                }),
              ],
            ),
            CustomTextField(
              controller: controller.subjectCodeC.value,
              hint: 'Subject Code',
              title: 'Subject Code',
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
