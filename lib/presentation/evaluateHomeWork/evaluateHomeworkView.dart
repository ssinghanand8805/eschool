
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_helper.dart';
import 'EvaluateHomeworkController.dart';



class EvaluateHomeworkPage extends  GetView<EvaluateHomeworkController>  {
  final List<Map<String, dynamic>> students = [
    {
      "name": "Faheem",
      "id": 98765,
      "message": "ddddd",
      "document": "image.png"
    },
    {"name": "Ali", "id": 98766, "message": "Sample", "document": "doc1.pdf"},
    {"name": "Ayesha", "id": 98767, "message": "Test", "document": "doc2.png"},
    {
      "name": "Faheem",
      "id": 98765,
      "message": "ddddd",
      "document": "image.png"
    },
    {"name": "Ali", "id": 98766, "message": "Sample", "document": "doc1.pdf"},
    {"name": "Ayesha", "id": 98767, "message": "Test", "document": "doc2.png"},
  ];

  DateTime? _selectedDate = DateTime.now();

  void _pickDate() async {
    // DateTime? date = await showDatePicker(
    //   context: context,
    //   initialDate: _selectedDate ?? DateTime.now(),
    //   firstDate: DateTime(2022),
    //   lastDate: DateTime(2030),
    // );
    // if (date != null) {
    //   setState(() {
    //     _selectedDate = date;
    //   });
    // }
  }

  void _saveSelectedStudents() {
    final selected = _selectedStudents.map((index) => students[index]).toList();
    print("Selected Students: $selected");
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Selected ${selected.length} student(s)."),
    //   ),
    // );
  }

  final Set<int> _selectedStudents = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Evaluate Homework',
          style: theme.textTheme.titleMedium,
        ),
        backgroundColor: Colors.green.shade200,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Fixes buttons at bottom
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Card
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
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
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Summary",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              _buildSummaryRow("Class", "11th"),
                              _buildSummaryRow("Section", "A"),
                              _buildSummaryRow("Subject", "ENGLISH (301)"),
                              _buildSummaryRow("Description", "ffff"),
                              _buildSummaryRow(
                                  "Submission Date", "18/12/2024".toString()),
                              const SizedBox(height: 8),
                              _buildSummaryRow("Evaluation Date",
                                  _selectedDate?.toString() ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Students",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                        height: constraints.maxHeight * 0.5,
                        child: ListView.builder(
                          itemCount: students.length,
                          itemBuilder: (context, index) {
                            final student = students[index];
                            final isSelected =
                            _selectedStudents.contains(index);

                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
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
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: Checkbox(
                                    value: isSelected,
                                    onChanged: (bool? value) {
                                      // setState(() {
                                      //   if (value == true) {
                                      //     _selectedStudents.add(index);
                                      //   } else {
                                      //     _selectedStudents.remove(index);
                                      //   }
                                      // });
                                    },
                                    activeColor: Colors.teal,
                                  ),
                                  title: Text(
                                      "${student['name']} (${student['id'].toString()})"),
                                  subtitle: Text(student['message']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.visibility,
                                          size: 18,
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Downloading ${student['document']}...'),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 18,
                                        ), // Second visibility icon
                                        onPressed: () {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Viewing details for ${student['name']}...'),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ),
            ),
            // Buttons Fixed at Bottom
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _pickDate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Evaluation Date",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveSelectedStudents,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
