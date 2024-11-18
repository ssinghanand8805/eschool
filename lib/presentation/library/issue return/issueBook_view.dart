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
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;
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
                        child: ClipOval(
                          child: controller.memberDetailsModel?.value.data?.memberList?.image != null
                              ? Image.network(
                            baseUrlFromPref+controller.memberDetailsModel!.value.data!.memberList!.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          )
                              : Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    _buildInfoRow('Member Name', controller.memberDetailsModel!.value.data!.memberList!.firstname!.capitalizeFirst!,),
                    _buildInfoRow('Member ID', controller.memberDetailsModel!.value.data!.memberList!.id!),
                    _buildInfoRow('Library Card No.', controller.memberDetailsModel!.value.data!.memberList!.libraryCardNo!),
                    _buildInfoRow('Admission No', controller.memberDetailsModel!.value.data!.memberList!.admissionNo!),

                  ],
                ),
              ),
            ),
            Expanded(
              child: controller.memberDetailsModel?.value.data?.issuedBooks?.isNotEmpty ?? false
                  ? ListView.builder(
                itemCount: controller.memberDetailsModel!.value.data!.issuedBooks!.length,
                itemBuilder: (context, index) {
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
                            Text(
                              'Book Title: ${controller.memberDetailsModel!.value.data!.issuedBooks![index].bookTitle!.capitalizeFirst}',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Book Number: ${controller.memberDetailsModel!.value.data!.issuedBooks![index].bookNo}',
                              style: theme.textTheme.bodySmall,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Issue Date: ${controller.memberDetailsModel!.value.data!.issuedBooks![index].issueDate}',
                              style: theme.textTheme.bodySmall,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Due Return Date: ${controller.memberDetailsModel!.value.data!.issuedBooks![index].duereturnDate}',
                              style: theme.textTheme.bodySmall,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Return Date: ${controller.memberDetailsModel!.value.data!.issuedBooks![index].returnDate}',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
                  : Center(
                child: Text(
                  'No issued books available',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
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
              label: 'Books',
              labelText: 'Books',
              onChanged: (val) {


              },
            ),
            const SizedBox(height: 8),
            DatePickerTextField(
                controller: controller.attendanceDate.value,
                title: 'Due Return Date',
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
}