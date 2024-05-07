import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject/subject_controller.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addSubject(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text("Subject List",style: theme.textTheme.titleLarge,),
            CustomTextField(
              controller: controller.searchC.value,
              hint: 'Search.... ', title: '',),


            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width*0.2,
                columns: const [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Subject Code')),
                  DataColumn(label: Text('Subject Type')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Center(
                        child: Text(entry.value['section'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 15),
                              onPressed: () {
                                //editHomework(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 15),
                              onPressed: () {
                                print("Delete leave");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),


          ],
        ),
      ),
    );
  }

  addSubject(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          children: [
            Text(
              "Add Subject",
              style: theme.textTheme.bodyMedium,
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
                      Checkbox(
                          checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                          value: controller.isChecked.value,
                          onChanged: (value) {
                            controller.isChecked.value = value!;
                            print(value);
                          }),
                      Text("Theory")
                    ],
                  );
                }),


                Obx(() {
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
                      Text("Practical")
                    ],
                  );
                }),
              ],
            ),
            CustomTextField(
              controller: controller.subjectCodeC.value,
              hint: 'Subject Code',
              title: '',
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
                onPress: () {},
              ),
            ),
          ],
        )
      ],
    );
  }
}
