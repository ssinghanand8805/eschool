import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/theme_helper.dart';
import '../../../../widgets/custom_button.dart';
import 'exam_mark_controller.dart';

class ExamMarkView extends GetView<ExamMarkController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Subjects',
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
                //addObservation(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,top: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Exam",style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),),
                    Text("CBSE Monthly Week Test",style: theme.textTheme.headlineMedium,),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Class (Section)",style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),),
                    Text("Class 4: A, B, C, D",style: theme.textTheme.headlineMedium,),
                  ],
                ),

              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width*0.2,
                // dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Start Time')),
                  DataColumn(label: Text('Room No.')),
                  DataColumn(label: Text('Enter Marks')),
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
                        IconButton(
                          icon: Icon(Icons.note_sharp, size: 15),
                          onPressed: () async {
                            await Get.toNamed(AppRoutes.enter_marksRoute);
                          },
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