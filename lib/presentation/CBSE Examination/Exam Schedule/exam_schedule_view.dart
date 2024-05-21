import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_helper.dart';
import 'exam_schedule_controller.dart';

class ExamScheduleView extends GetView<ExamScheduleController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Schedule',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: ListView(
        children: controller.jsonData['tests'].map<Widget>((test) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.grey
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    test['test_name'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Subject')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Start Time')),
                    DataColumn(label: Text('Duration (minutes)')),
                    DataColumn(label: Text('Room No.')),
                  ],
                  rows: test['subjects'].map<DataRow>((subject) {
                    return DataRow(
                      cells: [
                        DataCell(Text(subject['subject'],style: theme.textTheme.titleMedium,)),
                        DataCell(Text(subject['date'],style: theme.textTheme.titleMedium,)),
                        DataCell(Text(subject['start_time'],style: theme.textTheme.titleMedium,)),
                        DataCell(Text(subject['duration_minutes'].toString(),style: theme.textTheme.titleMedium,)),
                        DataCell(Text(subject['room_no'].toString(),style: theme.textTheme.titleMedium,)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

}