import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Login%20Credentials%20Send/login_credentials_send_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';

class LoginCredentialsSendView extends GetView<LoginCredentialsSendController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Login Credential',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8),
        child: Column(
          children: [
            MyCustomSD(
                listToSearch: [
                  {"name": "Faheem"},
                  {"name": "Amritash"},
                  {"name": "Anand"}
                ],
                valFrom: "name",
                label: "Select Class",
                borderColor: Colors.grey,
                onChanged: (val) {}),
            MyCustomSD(
                listToSearch: [
                  {"name": "Faheem"},
                  {"name": "Amritash"},
                  {"name": "Anand"}
                ],
                valFrom: "name",
                label: "Select Section",
                borderColor: Colors.grey,
                onChanged: (val) {}),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                width: 100,
                title: 'Search',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 16,
                ),
                textStyle: TextStyle(fontSize: 14, color: Colors.white),
                color: Colors.green,
                onPress: () async {
                  // await Get.toNamed(AppRoutes.new_messageRoute);
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                      listToSearch: [
                        {"name": "Faheem"},
                        {"name": "Amritash"},
                        {"name": "Anand"}
                      ],
                      valFrom: "name",
                      label: "Message To",
                      borderColor: Colors.grey,
                      onChanged: (val) {}),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: MyCustomSD(
                      listToSearch: [
                        {"name": "Faheem"},
                        {"name": "Amritash"},
                        {"name": "Anand"}
                      ],
                      valFrom: "name",
                      label: "Notification Type",
                      borderColor: Colors.grey,
                      onChanged: (val) {}),
                ),
              ],
            ),
            CustomTextField(
                controller: controller.searchC.value,
                hint: 'Search...',
                title: ""),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: controller.data.map((entry) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                          borderRadius: BorderRadius.circular(10),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Obx(
                                        () => Checkbox(
                                      value: controller.isMarked.value,
                                      onChanged: (value) {
                                        controller.isMarked.value = value!;
                                        print(value);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.grey.shade600,
                                    ),
                                    onPressed: () {
                                      // Add any action here, like a dropdown menu.
                                    },
                                  ),
                                ],
                              ),
                              const Divider(),
                              Text(
                                "Admission No: ${entry['admission_no'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Student Name: ${entry['student_name'] ?? 'N/A'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Class: ${entry['class'] ?? 'N/A'}",
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Gender: ${entry['gender'] ?? 'N/A'}",
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Date of Birth: ${entry['dob'] ?? 'N/A'}",
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Mobile: ${entry['mobile'] ?? 'N/A'}",
                                      style: TextStyle(fontSize: 14, color: Colors.black54),
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
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: MyButton(
                  width: 80,
                  title: 'Send',
                  textStyle: TextStyle(fontSize: 14, color: Colors.white),
                  color: Colors.green,
                  onPress: () async {
                    // await Get.toNamed(AppRoutes.new_messageRoute);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
