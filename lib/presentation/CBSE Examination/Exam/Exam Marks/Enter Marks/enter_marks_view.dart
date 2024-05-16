import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import '../../../../../theme/theme_helper.dart';
import '../../../../../widgets/custom_button.dart';
import 'enter_marks_controller.dart';

class EnterMarksView extends GetView<EnterMarksController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Enter Mathematics Marks',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: Get.width * 0.2,
               dataRowHeight: 100,
              columns: const [
                DataColumn(label: Text('Admission No')),
                DataColumn(label: Text('Roll No.')),
                DataColumn(label: Text('Student Name')),
                DataColumn(label: Text('Class')),
                DataColumn(label: Text('Father Name')),
                DataColumn(label: Text('Gender')),
                DataColumn(label: Text('Theory (TH02)')),
                DataColumn(label: Text('Note')),
              ],
              rows: controller.data.asMap().entries.map((entry) {
                int index = entry.key;
                return DataRow(
                  cells: [
                    DataCell(Text(entry.value['class'],
                        style: theme.textTheme.bodySmall!)),
                    DataCell(Text("A")),
                    DataCell(Text("Mohd Faheem")),
                    DataCell(Text("A")),
                    DataCell(Text("A")),
                    DataCell(Text("A")),
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(() => Checkbox(
                              checkColor: Colors.white,
                              //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                              value: controller.isMarked.value,
                              onChanged: (value) {
                                controller.isMarked.value = value!;
                                print(value);
                              },
                            ),

                            ),
                            Text('Mark as Absent',style: theme.textTheme.titleSmall,)
                          ],
                        ),

                        Container(
                          decoration: BoxDecoration(
                              border: Border.all()
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 150,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none, // Make border invisible
                                        borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                                      ),
                                      contentPadding: EdgeInsets.only(bottom: 5,left: 10)
                                  ),
                                  controller: controller.gameController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.gameCounter = double.tryParse(value) ?? 0.0;
                                  },
                                ),
                              ),

                              Column(
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap:(){
                                        controller.gameCounter++;
                                        controller.gameController.text = '${controller.gameCounter}';
                                      },
                                      child: Icon(Icons.arrow_drop_up)),

                                  InkWell(
                                      onTap:(){
                                        controller.gameCounter--;
                                        controller.gameController.text = '${controller.gameCounter}';
                                      },
                                      child: Icon(Icons.arrow_drop_down)),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                    DataCell(
                      SizedBox(width: Get.width*0.5,
                        child: CustomTextField(
                          controller: controller.noteC.value,
                          hint: 'Note',
                          title: '',),
                      )
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 80,
                title: 'Save',
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                color: Colors.green.shade200,
                onPress: () {
                  //addObservation(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
