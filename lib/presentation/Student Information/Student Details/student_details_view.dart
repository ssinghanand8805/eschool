import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20Details/student_details_controller.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';

class StudentDetailsView extends GetView<StudentDetailsController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Select Criteria',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right:8 ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                      listToSearch: controller.demo,
                      valFrom: 'name',
                      label: 'Select class',
                      borderColor: Colors.grey,
                      onChanged: (val) {}),
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: MyCustomSD(
                      borderColor: Colors.grey,
                      listToSearch: controller.demo,
                      label: 'Select section',
                      valFrom: 'name',
                      onChanged: (val) {}),
                ),
              ],
            ),

            CustomTextField(
              controller: controller.searchC.value,
              hint: "Search by student name, roll number,enrolment number,national Id,local Id etc...",
              title: "",
            ),
            SizedBox(height: 20,),

            Align(
              alignment: Alignment.bottomRight,
              child: MyButton(
                width: 120,
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
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Roll No.')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Father Name')),
                  DataColumn(label: Text('Date of Birth')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Mobile Number')),
                  DataColumn(label: Text('Action')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Text(entry.value['studentId'].toString(),
                          style: theme.textTheme.bodySmall!)),
                      DataCell(Text("Anand")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
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

}