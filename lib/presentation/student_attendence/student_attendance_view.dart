import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../widgets/myCustomsd.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonController.dart';
import 'controller/student_attendance_controller.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({Key? key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  final List _students = [
    {"id": 1001, "classId": "0202", "name": "Hudson1"},
    {"id": 1002, "classId": "0203", "name": "Hudson2"},
    {"id": 1003, "classId": "0204", "name": "Hudson2"},
  ];
  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }
  CommonController controller2 =
  Get.put(CommonController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   //  backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Attendance'),
      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
         return CommonForm(
           widgetFilterData: Column(
                            children: [
                              MyCustomSD(
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: _students,
                                valFrom: "name",
                                label: 'Class',
                                labelText: 'Class',
                                onChanged: (val) {
                                  print(val);

                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyCustomSD(
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: _students,
                                valFrom: "name",
                                label: 'Section',
                                labelText: 'Section',
                                onChanged: (val) {
                                  print(val);

                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text("Attendance Date",
                                        style: theme.textTheme.bodySmall!.copyWith(fontSize: 14)),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 43,
                                    child: TextField(
                                      style: theme.textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                            borderRadius: BorderRadius.all(Radius.circular(5))),
                                      ),
                                      readOnly: true,
                                      controller: controller.attendanceDate.value,
                                      onTap: () async {
                                        final date = await getDate();
                                        if (date != null) {
                                          controller.attendanceDate.value.text =
                                              DateFormat('dd/MM/yyyy').format(date);
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17,
                                  ),

                                ],
                              ),
                            ],
                          ),
           widgetformData: Column(
           children:[  Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                 'Student List',
                 style: theme.textTheme.titleLarge,
               ),

             ],
           ),
           SizedBox(
             height: 10,
           ),
           Text(
             'Set attendance for all students as',
             style: theme.textTheme.titleMedium,
           ),
           Expanded(child: StudentListPage())
          ]
           ,),
           onTapAction: filterData,);

        }
      ),
    );
  }

  filterData() {
    print("Perform search action here");
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<Student> students = [
    Student(admissionNo: 1001, rollNumber: 0201, name: 'Hudson'),
    Student(admissionNo: 1020, rollNumber: 0204, name: 'Marlie'),
    Student(admissionNo: 2152, rollNumber: 0205, name: 'Kaylen'),
  ];

  AttendanceStatus selectedStatus = AttendanceStatus.Present;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 75,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3,
                crossAxisCount: 3,
              ),
              itemCount: AttendanceStatus.values.length,
              itemBuilder: (BuildContext context, int index) {
                final status = AttendanceStatus.values[index];
                return RadioListTile<AttendanceStatus>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    status.toString().split('.').last,
                    style: theme.textTheme.bodySmall,
                  ),
                  value: status,
                  groupValue: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 15,
            ),
            itemCount: students.length,
            itemBuilder: (context, index) {
              return StudentTile(
                student: students[index],
                selectedStatus: selectedStatus,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                print(" Handle save attendance logic here");
              },
              child: Text(
                'Save Attendance',
                style:
                    theme.textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StudentTile extends StatefulWidget {
  final Student student;
  final AttendanceStatus selectedStatus;

  const StudentTile({
    Key? key,
    required this.student,
    required this.selectedStatus,
  }) : super(key: key);

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  AttendanceStatus? attendanceStatus;

  @override
  void initState() {
    super.initState();
    attendanceStatus = widget.selectedStatus;
  }

  AttendanceStatus selectedStatus = AttendanceStatus.Present;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(
              3.0,
              5.0,
            ),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Roll No. :",
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.student.rollNumber.toString(),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Name :",
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.student.name,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.5,
              crossAxisCount: 3, // Number of columns
            ),
            itemCount: AttendanceStatus.values.length,
            itemBuilder: (BuildContext context, int index) {
              final status = AttendanceStatus.values[index];
              return RadioListTile<AttendanceStatus>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  status.toString().split('.').last,
                  style: theme.textTheme.bodySmall,
                ),
                value: status,
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Note",
                style: theme.textTheme.bodySmall,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                height: 25.0, // Adjust the height as needed
                width: 150.0, // Adjust the width as needed
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  ),
                  style: TextStyle(fontSize: 14.0),
                  maxLines: 1,
                  controller: TextEditingController(),
                  onChanged: (value) {
                    // Handle text changes
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Student {
  final int admissionNo;
  final int rollNumber;
  final String name;

  Student({
    required this.admissionNo,
    required this.rollNumber,
    required this.name,
  });
}

enum AttendanceStatus { Present, Late, Absent, Holiday, HalfDay }
