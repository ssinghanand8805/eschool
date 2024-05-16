import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Assign%20Observation/Assign%20Marks/assign_marks_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/myCustomsd.dart';

class AssignMarksView extends GetView<AssignMarksController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Assign Marks',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8),
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
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      valFrom: 'name',
                      label: "Select Section",
                      onChanged: (value) {},
                    )),

              ],
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title: 'Search',
                prefixIcon: Icon(Icons.search),
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {},
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width*0.2,
                 dataRowHeight: 50,
                columns: const [
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Game (Max Marks30)')),
                  DataColumn(label: Text('Painting (Max Marks20)')),
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
                        Text('s')
                      ),
                      DataCell(
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
                                      controller.gameCounter = int.tryParse(value) ?? 0;
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
                                    // IconButton(
                                    //   icon: Icon(Icons.arrow_drop_up),
                                    //   onPressed: () {
                                    //     controller.counter++;
                                    //     controller.controller.text = '${controller.counter}';
                                    //   },
                                    // ),
                                    // IconButton(
                                    //   icon: Icon(Icons.arrow_drop_down),
                                    //   onPressed: () {
                                    //     controller.counter--;
                                    //     controller.controller.text = '${controller.counter}';
                                    //   },
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                      DataCell(
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
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(8.0),
                                          
                                        ),
                                        contentPadding: EdgeInsets.only(bottom: 5,left: 10)
                                    ),
                                    controller: controller.paintingController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      controller.paintingCounter = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                ),

                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap:(){
                                          controller.paintingCounter++;
                                          controller.paintingController.text = '${controller.paintingCounter}';
                                        },
                                        child: Icon(Icons.arrow_drop_up)),

                                    InkWell(
                                        onTap:(){
                                          controller.paintingCounter--;
                                          controller.paintingController.text = '${controller.paintingCounter}';
                                        },
                                        child: Icon(Icons.arrow_drop_down)),
                                  ],
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),

         Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 80,
                title: 'Save',
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                color: Colors.green.shade100,
                onPress: () {},
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

}