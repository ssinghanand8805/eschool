import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../../../theme/theme_helper.dart';
import '../../../../../widgets/custom_button.dart';
import 'assign_view_student_controller.dart';


class AddExamAssignViewStudentView extends GetView<AddExamAssignViewStudentController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Students',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            MyCustomSD(
                listToSearch: controller.demo,
                valFrom: "name",
                label: "Select class",
                borderColor: Colors.grey,
                onChanged: (val){

                }),

            MyCustomSD(
                listToSearch: controller.demo,
                valFrom: "name",
                label: "Select section",
                borderColor: Colors.grey,
                onChanged: (val){

                }),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
                prefixIcon: Icon(Icons.search),
                title: 'Search',
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
                columnSpacing: Get.width * 0.1,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Row(
                    children: [
                      Icon(Icons.check_box_outline_blank),
                      SizedBox(width: 5,),
                      Text("All")
                    ],
                  )),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Class (Section)')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Gender')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(
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
                            ],
                          );
                        }),
                      ),
                      DataCell(Text(
                        "gree or nsity.",
                        maxLines: null,
                        overflow: TextOverflow.ellipsis,
                      )),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),

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
                  width: 120,
                  title: 'Save',
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  color: Colors.green.shade100,
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}