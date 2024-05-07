import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Class/class_controller.dart';

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
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Class List',
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
                addClass(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Class List",style: theme.textTheme.labelLarge,),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: Get.width*0.2,
              dataRowHeight: 100,
              columns: const [
                DataColumn(label: Text('Class')),
                DataColumn(label: Text('Section')),
                DataColumn(label: Text('Action')),
              ],
              rows: controller.data.asMap().entries.map((entry) {
                int index = entry.key;
                return DataRow(
                  cells: [
                    DataCell(Text(entry.value['class'],
                        style: theme.textTheme.bodySmall!)),
                    DataCell(
                        SizedBox(
                          height: 60,width: 60,
                          child: ListView.builder(
                            itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index){
                                                return Text("A");
                                              }),
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
    );
  }


  addClass(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Class",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.classC.value,
              hint: "Class Name....",
              title: "",
            ),
            SizedBox(height: 10,),
            Text("Sections:",style: theme.textTheme.labelLarge,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
                itemBuilder: (BuildContext context, int index){
              return Obx(() {
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
              });
            }),
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