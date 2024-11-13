import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../../apiHelper/GlobalData.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import 'issueReturn_controller.dart';

class LibraryManagementPage extends GetView<IssueReturnController> {
  LibraryManagementPage({Key? key}) : super(key: key,);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management System',  style: theme.textTheme.titleLarge,),
      backgroundColor: Colors.green[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              color: Colors.grey[100],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(child: Text('Sam', style: TextStyle(fontSize: 16))),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildInfoRow('Member ID', '1'),
                    _buildInfoRow('Library Card No.', '123'),
                    _buildInfoRow('Admission No', '1'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  var book = books[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Book Title: ${book['title']}',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text('Book Number: ${book['bookNumber']}',style:theme.textTheme.bodySmall,),
                            SizedBox(height: 8),
                            Text('Issue Date: ${book['issueDate']}',style:theme.textTheme.bodySmall,),
                            SizedBox(height: 8),
                            Text('Due Return Date: ${book['dueDate']}',style:theme.textTheme.bodySmall,),
                            SizedBox(height: 8),
                            Text('Return Date: ${book['returnDate']}',style:theme.textTheme.bodySmall,),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEditContents(context);
        },
        tooltip: 'Add Item',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }


  void addEditContents(BuildContext context) {
    showCustomBottomSheet(context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyCustomSD(

              hideSearch: true,
              borderColor: Colors.grey,
              listToSearch: [],
              valFrom: "className",
              label: 'Class',
              labelText: 'Class',
              onChanged: (val) {


              },
            ),
            const SizedBox(height: 8),
            DatePickerTextField(
                controller: controller.attendanceDate.value,
                title: 'Attendace date',
                onDateSelected: (date) async {
                  controller.attendanceDate.value.text =
                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                }),
            const SizedBox(height: 24),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Implement save functionality
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value,style: theme.textTheme.bodySmall,),
          ),
        ],
      ),
    );
  }

  final List<Map<String, String>> books = [
    {
      'title': 'War And Peace',
      'bookNumber': '1214',
      'issueDate': '21/10/2024',
      'dueDate': '22/10/2024',
      'returnDate': '-',
    },
    {
      'title': 'War And Peace',
      'bookNumber': '1214',
      'issueDate': '13/04/2024',
      'dueDate': '15/04/2024',
      'returnDate': '21/10/2024',
    }, {
      'title': 'War And Peace',
      'bookNumber': '1214',
      'issueDate': '21/10/2024',
      'dueDate': '22/10/2024',
      'returnDate': '-',
    },
    {
      'title': 'War And Peace',
      'bookNumber': '1214',
      'issueDate': '13/04/2024',
      'dueDate': '15/04/2024',
      'returnDate': '21/10/2024',
    },
  ];
}