import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Subject%20Group/subject_group_controller.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class SubjectGroupView extends GetView<SubjectGroupController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Subject Group List',
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
                addSubjectGroup(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Text("Subject Group List",style: theme.textTheme.bodyLarge,),


          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: Get.width*0.2,
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Class (Section)')),
                DataColumn(label: Text('Subject')),
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
    );
  }


  addSubjectGroup(context){
    AlertDialogue().show(context,
      newWidget: [
        Column(
          children: [
            Text("Add Subject Group",style: theme.textTheme.bodyMedium,),
            CustomTextField(
                controller: controller.nameC.value,
                hint: "Name....",
                title: "Name",
            ),
            SizedBox(height: 20,),
            MyCustomSD(
              borderColor: Colors.grey,
                listToSearch: controller.demo,
                valFrom: 'name',
                onChanged: (val){

                }),

            Align(
              alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Subject:",style: theme.textTheme.bodyLarge,),
                )),

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

            CustomTextField(
                controller: controller.descriptionC.value,
                hint: 'Description',
                title: '',
              maxLine: 3,
            ),
            SizedBox(height: 15,),

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
