import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/cutomformbuttom.dart';
import '../../../widgets/myCustomsd.dart';
import 'import_student_controller.dart';

class ImportStudentView extends GetView<ImportStudentController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Student List',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              // prefixIcon: Icon(
              //   Icons.add,
              //   color: Colors.white,
              // ),
              title: 'Demo',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                demo(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyCustomSD(
                      listToSearch: controller.demo,
                      valFrom: 'name',
                      label: 'Select class',
                      borderColor: Colors.grey,
                      onChanged: (val) {}),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      label: 'Select section',
                      valFrom: 'name',
                      onChanged: (val) {}),
                ),
              ],
            ),

            SizedBox(height: 20,),

            InkWell(
              onTap: () {
                _showImagePicker(context);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: Colors.green.shade200
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file,color: Colors.green),
                    Text("Drag and drop a file here or click",style: TextStyle(color: Colors.green),),
                  ],
                ),

              ),
            ),

            SizedBox(height: 20,),

            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Import Student',
                textStyle: TextStyle(color: Colors.black,),
                color: Colors.green.shade100,
                onPress: () {

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  demo(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        GetBuilder(
            init: controller,
            builder: (_) {
              return Column(
                children: [
                  MyCustomSD(
                      hideSearch: true,
                      listToSearch: controller.groupList.value,
                      valFrom: 'name',
                      onChanged: (val) {
                        print(val);
                        controller.selectedGroup.value = val['name'];
                        print(controller.selectedGroup.value);
                      }),


                  Obx(() {
                    return Visibility(
                      visible: controller.selectedGroup.value == "Group",
                      child: MyCustomSD(
                          multiSelect: true,
                          hideSearch: true,
                          listToSearch: controller.ggroupList.value,
                          valFrom: 'name',
                          onChanged: (val) {
                            print(val);
                            controller.selectedGgroupList.value = jsonDecode(
                                val);
                            print(controller.selectedGgroupList.value.toList());
                          }),
                    );
                  }),


                  Obx(() {
                    return Row(
                      children: [
                        Visibility(
                          visible: controller.selectedGroup.value ==
                              "Individual",
                          child: Expanded(
                            child: MyCustomSD(
                                hideSearch: true,
                                listToSearch: controller.ggroupList.value,
                                valFrom: 'name',
                                onChanged: (val) {
                                  print(val);
                                  controller.selectIndividual.value = val['id'];
                                }),
                          ),
                        ),

                        Visibility(
                          visible: controller.selectedGroup.value ==
                              "Individual",
                          child: Expanded(
                            child: MyCustomSD(
                                multiSelect: true,
                                hideSearch: true,
                                listToSearch: controller.demo,
                                valFrom: 'name',
                                onChanged: (val) {
                                  print(val);
                                  controller.selectedIndividualList.value =
                                      jsonDecode(val);
                                }),
                          ),
                        )
                      ],
                    );
                  }),

                  ///Class

                  Obx(() {
                    return Visibility(
                      visible: controller.groupList.value == "Class",
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: MyCustomSD(
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch:
                              controller.commonApiController
                                  .classListModelMap.value,
                              valFrom: "className",
                              label: 'Class',
                              labelText: 'Class',
                              initialValue: [
                                {
                                  'parameter': 'id',
                                  'value': controller.commonApiController
                                      .selectedClassId!
                                }
                              ],
                              onChanged: (val) {
                                if (controller.commonApiController
                                    .classListModelMap.value
                                    .length >
                                    0) {
                                  print("5555555555555");

                                  controller.commonApiController
                                      .selectedClassId.value =
                                      val['id'].toString();
                                  controller.commonApiController
                                      .selectedClassName.value =
                                      val['className'].toString();
                                  controller.selectedClassName.value =
                                      val['className'].toString();
                                  controller.commonApiController.update();
                                  controller.commonApiController
                                      .getSectionList();
                                }
                              },
                            )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child:  MyCustomSD(
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch: controller
                                  .commonApiController.sectionListModelMap
                                  .value,
                              valFrom: "section",
                              label: 'Section',
                              labelText: 'Section',
                              initialValue: [
                                {
                                  'parameter': 'id',
                                  'value':
                                  controller.commonApiController
                                      .selectedSectionId!
                                }
                              ],
                              onChanged: (val) {
                                print(val);
                                if (controller.commonApiController
                                    .sectionListModelMap
                                    .value.length >
                                    0) {
                                  controller.commonApiController
                                      .selectedSectionId.value =
                                      val['section_id'].toString();
                                  controller.commonApiController
                                      .selectedSectionName
                                      .value = val['section'].toString();
                                  controller.selectedSectionName.value =
                                      val['section'].toString();
                                  controller.commonApiController.update();
                                }
                              },
                            )
                          ),
                        ],
                      ),
                    );
                  }),

                ],
              );
            }
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: MyButton(
            width: 100,
            title: 'Search',
            textStyle: TextStyle(
              color: Colors.black,
            ),
            color: Colors.green.shade100,
            onPress: () {
              Get.back();
            },
          ),
        ),
      ],
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      // controller.image.value = File(pickedFile.path);
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
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
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
                      color: Theme
                          .of(context)
                          .primaryColor,
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
                      color: Theme
                          .of(context)
                          .primaryColor,
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


class CustomDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final String hintText;
  final Function(T?) onChanged;
  final TextStyle? hintStyle;
  final TextStyle? valueStyle;

  CustomDropdown({
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    this.hintStyle,
    this.valueStyle,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: widget.selectedValue,
              isExpanded: false,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              borderRadius: BorderRadius.circular(10),
              style: widget.valueStyle ?? TextStyle(color: Colors.black),
              hint: Text(widget.hintText,
                  style: widget.hintStyle ?? TextStyle(color: Colors.black)),
              items: widget.items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {});
                widget.onChanged(val);
              },
            )));
  }
}
