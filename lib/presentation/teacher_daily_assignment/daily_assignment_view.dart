import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import 'controller/daily_assignment_controller.dart';

class TeacherDailyAssignmentScreen extends StatefulWidget {
  const TeacherDailyAssignmentScreen({Key? key});

  @override
  State<TeacherDailyAssignmentScreen> createState() =>
      _TeacherDailyAssignmentScreenState();
}

class _TeacherDailyAssignmentScreenState
    extends State<TeacherDailyAssignmentScreen> {
  TeacherDailyAssignmentController controller =
      Get.put(TeacherDailyAssignmentController());

  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Daily Assignment List',
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: MyCustomSD(
                          labelText: 'Class',
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Class',
                          onChanged: (val) {
                            print(val);

                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyCustomSD(
                          labelText: 'Section',
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Section',
                          onChanged: (val) {
                            print(val);

                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MyCustomSD(
                          labelText: 'Subject Group',
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Subject Group',
                          onChanged: (val) {
                            print(val);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyCustomSD(
                          labelText: 'Subject',
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller.students,
                          valFrom: "name",
                          label: 'Subject',
                          onChanged: (val) {
                            print(val);
                                          
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text("Date",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontSize: 14)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 43,
                    child: TextField(
                      style: theme.textTheme.bodySmall,
                      decoration: InputDecoration(
                        hintText:
                        DateFormat('dd/MM/yyyy').format(DateTime.now()),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                      ),
                      readOnly: true,
                      controller: controller.dateC.value,
                      onTap: () async {
                        final date = await getDate();
                        if (date != null) {
                          controller.dateC.value.text =
                              DateFormat('dd/MM/yyyy').format(date);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: MyButton(
                        title: 'Search',
                        width: 80,
                        color: Colors.green,
                        onPress: () {},
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Daily Assignment List',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                Expanded(child: MyTable())
                ],
              ),
            );
          }),
    );
  }
}

class MyTable extends StatefulWidget {
  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  TeacherDailyAssignmentController controller =
      Get.put(TeacherDailyAssignmentController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: controller.data.asMap().entries.map((entry) {
          int index = entry.key;
          var data = entry.value;

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade100,
                    Colors.green.shade50,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row with Student Name and Class
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data['studentName'],
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['class'],
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),

                    // Details Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Section: ${data['section']}",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Subject: ${data['subject']}",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Submission Date: Submission Date",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Evaluated By: ${data['evaluatedBy'] ?? 'N/A'}",
                          style: theme.textTheme.bodySmall,
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Evaluation Date: ${'Evaluation Date'}",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            print("Edit pressed");
                            // Call edit function here
                          },
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text("Edit"),
                        ),
                        const SizedBox(width: 5.0),
                        TextButton.icon(
                          onPressed: () {
                            print("Delete pressed");
                            // Call delete function here
                          },
                          icon: const Icon(Icons.delete,
                              size: 16, color: Colors.red),
                          label: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
