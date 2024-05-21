
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../../../../theme/theme_helper.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/myCustomsd.dart';
import 'enter_marks_controller.dart';

class AddExamEnterMarksView extends GetView<AddExamEnterMarksController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Enter Choose Subject',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                    borderColor: Colors.grey,
                    listToSearch: controller.demo,
                    valFrom: 'name',
                    label: "Select Class",
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: MyCustomSD(
                    borderColor: Colors.grey,
                    listToSearch: controller.demo,
                    valFrom: 'name',
                    label: "Select Section",
                    onChanged: (value) {},
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                    borderColor: Colors.grey,
                    listToSearch: controller.demo,
                    valFrom: 'name',
                    label: "Select Session",
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(width: 50),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0,),
                  child: MyButton(
                    width: 120,
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    title: 'Search',
                    textStyle: TextStyle(fontSize: 18, color: Colors.white),
                    color: Colors.green.shade200,
                    onPress: () {
                      //addObservation(context);
                    },
                  ),
                )
              ],
            ),




            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                 dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Roll No.')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Attendance')),
                  DataColumn(label: Text('Marks')),
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
                      DataCell(Row(
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
                          Text('Absent',style: theme.textTheme.titleSmall,)
                        ],
                      )),
                      DataCell(
                          Container(
                            height: 55,
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
                      ),
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
      ),
    );
  }
}
