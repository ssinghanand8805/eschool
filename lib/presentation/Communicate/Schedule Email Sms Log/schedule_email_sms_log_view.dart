import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Schedule%20Email%20Sms%20Log/schedule_email_sms_log_controller.dart';
import 'package:learnladderfaculity/theme/theme_helper.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

class ScheduleEmailSmsLogView extends GetView<ScheduleEmailSmsLogController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Schedule Email SMS Log',
          style: theme.textTheme.titleLarge,
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: MyButton(
        //       width: 160,
        //       prefixIcon: Icon(
        //         Icons.add,size: 14,
        //         color: Colors.white,
        //       ),
        //       title: 'Post New Message',
        //       textStyle: TextStyle(fontSize: 14, color: Colors.white),
        //       color: theme.hintColor,
        //       onPress: () async {
        //        // await Get.toNamed(AppRoutes.new_messageRoute);
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8),
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
                  DataColumn(label: Text('Message')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Schedule Date')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Sms')),
                  DataColumn(label: Text('Group')),
                  DataColumn(label: Text('Individual')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Action')),
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
                          Text(DateTime.now().toString())),
                      DataCell(
                          Icon(Icons.check_box)),
                      DataCell(Icon(Icons.check_box)),
                      DataCell(
                          Text("A")),
                      DataCell(
                          Icon(Icons.check_box)
                      ),
                      DataCell(
                          Icon(Icons.check_box)
                      ),
                      DataCell(
                          Row(
                            children: [
                              Icon(Icons.menu),
                              SizedBox(width: 15,),
                              Icon(Icons.delete),
                            ],
                          )
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