import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import 'email_sms_log_controller.dart';

class EmailSmsLogView extends GetView<EmailSmsLogController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Email / SMS Log',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8,),
        child: Column(
          children: [
            CustomTextField(
                controller: controller.searchC.value,
                hint: "Search...",
                title: ''),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width*0.2,
                //dataRowHeight: 100,
                columns: const [
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('SMS')),
                  DataColumn(label: Text('Group')),
                  DataColumn(label: Text('Individual')),
                  DataColumn(label: Text('Class')),
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
                          Text(DateTime.now().toString())),
                      DataCell(
                          Icon(Icons.check_box)),
                      DataCell(
                          Icon(Icons.check_box)),
                      DataCell(Icon(Icons.check_box)),
                      DataCell(
                          Text("A")),
                      DataCell(
                          Icon(Icons.check_box)
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