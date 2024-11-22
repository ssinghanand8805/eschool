import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Section/section_controller.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';

class SectionView extends GetView<SectionController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Section List',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.searchC.value,
              hint: 'Search.... ',
              title: '',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 30, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Section",
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Action",
                    style: theme.textTheme.bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GetBuilder<SectionController>(
                builder: (controller) {
                  if (controller.sectionList.value.data == null ||
                      controller.sectionList.value.data!.sectionlist!.isEmpty) {
                    return Center(child: CustomLoader());
                  }

                  return ListView.builder(
                    itemCount:
                        controller.sectionList.value.data!.sectionlist!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final section = controller
                          .sectionList.value.data!.sectionlist![index];
                      return Card(
                        elevation: 2.0,
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
                            padding: const EdgeInsets.only(left: 10.0, right: 8),
                            child: Row(
                              children: [
                                Text(
                                  section.section!.capitalizeFirst ?? "",
                                  style: theme.textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    _showEditDialog(
                                        context, section.id!, section.section!);
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
                                                controller.deleteSection(context,
                                                    section.id); // Perform delete
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                              },
                                              child: Text(
                                                "Delete",
                                                style:
                                                    TextStyle(color: Colors.red),
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
          addSection(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showEditDialog(BuildContext context, String id, String currentName) {
    showCustomBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: controller.sectionC.value,
              hint: 'Section Name',
              title: 'Edit Section Name',
            ),
            const SizedBox(height: 16),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  final newName = controller.sectionC.value.text.trim();
                  if (newName.isNotEmpty) {
                    controller.editSection(id, newName);
                    Navigator.pop(context);
                  }
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addSection(context) {
    showCustomBottomSheet(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Section",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.newSectionC.value,
              hint: "Section Name....",
              title: "",
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {
                  controller.addSection();
                },
              ),
            ),
          ],
        ));
  }
}
