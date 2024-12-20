import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Class/class_controller.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class ClassView extends GetView<ClassController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Class List',
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
              onChanged: (val){
                controller.searchContentType(val);
                controller.update();
              },
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
                      "Class",
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Sections",
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
              child: GetBuilder<ClassController>(
                builder: (controller) {
                  if (controller
                      .classList.value.data == null || controller
                      .classList.value.data!.classlist!.isEmpty) {
                    return Center(child: CustomLoader());
                  }

                  return ListView.builder(
                    itemCount:controller
                        .classList.value.data!.classlist!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final data = controller
                          .classList.value.data!.classlist![index];

                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                                    data.classN!.capitalizeFirst ?? "",
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),

                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    data.sections!.map((s) => s.section).join(', '),
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
                                          await controller.viewData(data.id);
                                          addClass(context);
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
                                                          data.id); // Perform delete
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
            addClass(context);
          },
          tooltip: 'Add Item',
          shape: CircleBorder(),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        )
    );
  }

  addClass(context) {
    showCustomBottomSheet(
        context: context,
        child: GetBuilder(
          init: controller,
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.selectedId.value == ''
                    ? Text(
                  "Add Class",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                )
                    : Text(
                  "Update Class",
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                CustomTextField(
                  controller: controller.classC.value,
                  hint: 'Class',
                  title: 'Class',
                ),
                SizedBox(height: 10,),
                Obx(() {
                  if (controller.sectionListClass.value.data == null ||
                      controller.sectionListClass.value.data!.sectionlist!.isEmpty) {
                    return Center(
                      child: Text("No sections available."),
                    );
                  }
                  return SizedBox(
                    height:200,
                    child: Obx( () => ListView.builder(
                        itemCount: controller.sectionListClass.value.data!.sectionlist!.length,
                        itemBuilder: (context, index) {
                          final item = controller.sectionListClass.value.data!.sectionlist![index];
                          return CheckboxListTile(
                            title: Text(item.section!),
                            value: controller.selectedSections.value.contains(item.id),
                            onChanged: (bool? value) {

                              if (value == true) {
                                controller.selectedSections.value.add(item.id!);
                                controller.update();
                              } else {
                                controller.selectedSections.value.remove(item.id);
                                controller.update();
                              }
                              controller.update();
                            },
                          );
                        },
                      ),
                    ),
                  );
                }),


                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: MyButton(
                    width: 120,
                    title: controller.selectedId.value == ''
                        ? 'Save'
                        : "Update",
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                    color: Colors.green,
                    onPress: () async {
                      await controller.addSubject();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            );
          }
        ));
  }


}