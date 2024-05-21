

import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assign%20Observation/assign_observation_controller.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';

class AssignObservationView extends GetView<AssignObservationController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam List',
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
                addObservation(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
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
                columnSpacing: Get.width*0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Observation')),
                  DataColumn(label: Text('Term')),
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['class'],
                          style: theme.textTheme.bodySmall!)),
                      DataCell(
                          Text("A")),
                      DataCell(
                          Text("A")),
                      DataCell(
                          Text("A")),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.assignment, size: 15),
                              onPressed: () async {
                                await Get.toNamed(AppRoutes.assign_marksRoute);
                              },
                            ),
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

  addObservation(context){
    AlertDialogue().show(context,
        newWidget: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Add Observation Term",
          style: theme.textTheme.bodyMedium,
        ),
        Row(
          children: [
            Expanded(
                child: MyCustomSD(
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: 'name',
                  label: "Select Observation",
                  onChanged: (value) {},
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: MyCustomSD(
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: 'name',
                  label: "Select Term",
                  onChanged: (value) {},
                )),
          ],
        ),
          CustomTextField(
            controller: controller.descriptionC.value,
            hint: "Description",
            title: "",
            maxLine: 3,
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
      ])
    ]);
  }

}