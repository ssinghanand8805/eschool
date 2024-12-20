import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apiHelper/GlobalData.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/datePickerTextField.dart';
import 'EvaluateHomeworkController.dart';

class EvaluateHomeworkPage extends GetView<EvaluateHomeworkController> {
  DateTime? _selectedDate = DateTime.now();

  void _saveSelectedStudents() {
    final selected = _selectedStudents
        .map((index) =>
            controller.evaluateHomework.value.data!.studentlist![index])
        .toList();
    print("Selected Students: $selected");
  }

  RxList<int> _selectedStudents = <int>[].obs;

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
                              Text(
                                "Summary",
                                style: theme.textTheme.titleMedium!.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const Divider(),
                              _buildSummaryRow(
                                  "Class",
                                  controller.evaluateHomework.value.data!
                                          .result!.className ??
                                      ""),
                              _buildSummaryRow(
                                  "Section",
                                  controller.evaluateHomework.value.data!
                                          .result!.section ??
                                      ""),
                              _buildSummaryRow(
                                  "Subject",
                                  controller.evaluateHomework.value.data!
                                          .result!.subjectGroup ??
                                      ""),
                              // _buildSummaryRow(
                              //     "Description",
                              //     controller.evaluateHomework.value.data!
                              //             .result!.description ??
                              //         ""),
                              _buildSummaryRow(
                                  "Submission Date",
                                  controller.evaluateHomework.value.data!
                                          .result!.submitDate ??
                                      ""),
                              _buildSummaryRow(
                                  "Evaluation Date",
                                  controller.evaluateHomework.value.data!
                                          .result!.evaluationDate ??
                                      ""),
                              Row(
                                children: [
                                  Text(
                                    "Description",
                                    style: theme.textTheme.bodySmall!
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Html(
                                      data: controller.evaluateHomework.value
                                              .data!.result!.description ??
                                          "",
                                      style: {
                                        "body": Style(
                                          fontSize: FontSize(13.0),
                                          color: Colors.black,
                                        ),
                                        "h1": Style(
                                          fontSize: FontSize(12.0),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal,
                                        ),
                                        "h2": Style(
                                          fontSize: FontSize(12.0),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal.shade700,
                                        ),
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    const Text(
                      "Students",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: constraints.maxHeight * 0.5,
                      child: Obx(() {
                        // Check if data is loading
                        if (controller.evaluateHomework.value.data == null ||
                            controller
                                    .evaluateHomework.value.data!.studentlist ==
                                null) {
                          // Show loader when data is loading
                          return const Center(
                            child: CustomLoader(),
                          );
                        }

                        // If data is available, show the ListView
                        final students = controller
                            .evaluateHomework.value.data!.studentlist!;
                        final allSelected =
                            _selectedStudents.length == students.length;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: allSelected,
                                    onChanged: (bool? value) {
                                      if (value == true) {
                                        _selectedStudents.clear();
                                        for (int i = 0;
                                            i < students.length;
                                            i++) {
                                          _selectedStudents.add(i);
                                        }
                                      } else {
                                        _selectedStudents.clear();
                                      }
                                      controller.update();
                                    },
                                    activeColor: Colors.green,
                                  ),
                                  Text("Select All Students",
                                      style: theme.textTheme.titleMedium!),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: students.length,
                                itemBuilder: (context, index) {
                                  final student = students[index];
                                  return Card(
                                    elevation: 2,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.green.shade100,
                                            Colors.green.shade50,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Obx(() {
                                                // Observe the state of each checkbox
                                                final isSelected =
                                                    _selectedStudents
                                                        .contains(index);
                                                return Checkbox(
                                                  value: isSelected,
                                                  onChanged: (bool? value) {
                                                    if (value == true) {
                                                      _selectedStudents
                                                          .add(index);
                                                    } else {
                                                      _selectedStudents
                                                          .remove(index);
                                                    }
                                                  },
                                                  activeColor: Colors.green,
                                                );
                                              }),
                                              Expanded(
                                                child: Text(
                                                  "${student.firstname} ${student.lastname}(${student.id.toString()})"
                                                      .capitalizeFirst!,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(),
                                                ),
                                              ),
                                              Text(
                                                student.assignmentlist
                                                            ?.isEmpty ??
                                                        true
                                                    ? "Not Submitted"
                                                    : student.assignmentlist![0]
                                                        .message
                                                        .toString()
                                                        .capitalizeFirst!,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontSize: 12,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.visibility,
                                                  color: Colors.blue,
                                                  size: 17,
                                                ),
                                                onPressed: () {
                                                  showStudentDetailsDialog(
                                                    context,
                                                    "${student.firstname} ${student.lastname}(${student.id.toString()})"
                                                        .capitalizeFirst!,
                                                    student.assignmentlist![0]
                                                        .message!,
                                                    student.assignmentlist![0]
                                                        .docs!,
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          CustomTextField(
                                              controller:
                                                  controller.titleC.value,
                                              hint: "Enter notes or feedback",
                                              title: ""),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
            // Buttons Fixed at Bottom
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: DatePickerTextField(
                        controller: controller.evaluateDateC.value,
                        title: 'Evaluate Date',
                        onDateSelected: (date) async {
                          controller.evaluateDateC.value.text =
                              await GlobalData()
                                  .ConvertToSchoolDateTimeFormat(date);
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22.0),
                      child: SizedBox(
                        height: 40, // Match the height with the text field
                        child: ElevatedButton(
                          onPressed: _saveSelectedStudents,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Optional for rounded corners
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  void showStudentDetailsDialog(
      BuildContext context, String name, String message, String link) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          title: Text(
            "Student Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(name,
                        style: theme.textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.message,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message.isNotEmpty
                          ? message.capitalizeFirst!
                          : "No message provided.",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.link,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        final uri = Uri.parse(link);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Could not open link"),
                            ),
                          );
                        }
                      },
                      child: Text(
                        link.isNotEmpty ? link : "No link available.",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Close",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
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
            style: theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
