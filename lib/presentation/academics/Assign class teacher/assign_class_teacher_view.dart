import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Assign%20class%20teacher/assign_class_teacher_controller.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';

class AssignClassTeacherView extends GetView<AssignClassTeacherController> {
  AssignClassTeacherView({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Assign Class Teacher',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(Icons.add,color: Colors.white,),
              title: 'Add',
              textStyle: TextStyle(fontSize:18,color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addAssignClassTeacher(context);
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Column(
              children: [
            Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: CustomTextField(
              controller: controller.searchC.value,
              hint: 'Search.... ', title: '',),
          ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: Get.width*0.2,
                    columns: const [
                      DataColumn(label: Text('Class')),
                      DataColumn(label: Text('Section')),
                      DataColumn(label: Text('Class Teacher')),
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
              ]
          )
          );
        }
      )
    );
  }



  addAssignClassTeacher(context){
    AlertDialogue().show(context,
      newWidget: [
        Column(
          children: [
            Text("Add Content Type",style: theme.textTheme.bodyMedium,),
            MyCustomSD(
                borderColor: Colors.grey,
                label: "Select Class",
                listToSearch: controller.demo,
                valFrom: 'name',
                onChanged: (val){
                }
            ),
            SizedBox(height: 20,),

            MyCustomSD(
                borderColor: Colors.grey,
                label: "Select Section",
                listToSearch: controller.demo,
                valFrom: 'name',
                onChanged: (val){
                }
            ),

            SizedBox(height: 20,),

    
    ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
        itemBuilder: (BuildContext context, int index){
      return  Obx(() {
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

            Text("Faheem")
          ],
        );
      });
    }),




            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                title:'Save',textStyle: TextStyle(color: Colors.black,),
                color:Colors.green.shade100,
                onPress: () {

                },
              ),
            ),

          ],
        )
      ],

    );
  }



}
