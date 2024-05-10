import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Teacher%20Time%20Table/teacher_time_table_controller.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class TeacherTimeTableView extends GetView<TeacherTimeTableController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Teacher Time Table',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Teachers",
              style: theme.textTheme.bodyMedium,
            ),
            CustomTextField(
              controller: controller.teacherC.value,
              hint: "Section Teacher",
              title: "",
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowHeight: 180,
                columnSpacing: Get.width * 0.05,
                columns: const [
                  DataColumn(label: Text('Monday')),
                  DataColumn(label: Text('Tuesday')),
                  DataColumn(label: Text('Wednesday')),
                  DataColumn(label: Text('Thursday')),
                  DataColumn(label: Text('Friday')),
                  DataColumn(label: Text('Saturday')),
                  DataColumn(label: Text('Sunday')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(
                          ClassContainer(),
                      ),
                      DataCell(Center(
                        child: Text(entry.value['section'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['subjectGroup'],
                            style: theme.textTheme.bodySmall!),
                      )),
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

  Widget ClassContainer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.green.shade50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClassDetailsCard(
              icon: Icons.class_, title: "Class", subTitle: "Faheem"),
          ClassDetailsCard(
              icon: Icons.subject, title: "Subject", subTitle: "Faheem"),
          ClassDetailsCard(
              icon: Icons.timer,
              title: "",
              subTitle: DateTime.now().toString()),
          ClassDetailsCard(
              icon: Icons.home_work_outlined,
              title: "Room No.",
              subTitle: "123"),
        ],
      ),
    );
  }

  Widget ClassDetailsCard({IconData? icon, String? title, String? subTitle}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon),
        SizedBox(
          width: 5,
        ),
        Text(
            title!.isEmpty?title.toString():"${title.toString()} :",
          style: theme.textTheme.labelSmall,
        ),
        Text(subTitle.toString())
      ]),
    );
  }
}
