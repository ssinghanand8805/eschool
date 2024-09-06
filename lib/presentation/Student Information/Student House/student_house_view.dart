import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20House/student_house_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';

class StudentHouseView extends GetView<StudentHouseController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Student House List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 80,
              prefixIcon: Icon(
                Icons.add,size: 16,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 16, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addStudentHouse(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0,right: 15),
        child: Column(
          children: [
            CustomTextField(
              controller: controller.searchC.value,
              hint: "Search...",
              title: "",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('House ID')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['studentId'].toString(),
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Text("Faheem")),
                      DataCell(Text("120112")),
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

  addStudentHouse(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Marks Grade",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.nameC.value,
              hint: "Name",
              title: "",
            ),

            CustomTextField(
              controller: controller.descriptionC.value,
              hint: "Description",
              maxLine: 3,
              title: "",
            ),

            SizedBox(height: 10,),
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