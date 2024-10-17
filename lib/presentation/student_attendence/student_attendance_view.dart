import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/presentation/common_widgets/controller/CommonApiController.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/datePickerTextField.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonController.dart';
import 'controller/student_attendance_controller.dart';
import 'model/Student_Attendance.dart';

class StudentAttendanceScreen extends StatefulWidget {
  const StudentAttendanceScreen({Key? key});

  @override
  State<StudentAttendanceScreen> createState() =>
      _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends State<StudentAttendanceScreen> {
  StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  getDate() async {
    var date = await showDatePicker(
      context: context,
      initialDate: controller.applyDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2025),
    );
    return date;
  }

  CommonController controller2 = Get.put(CommonController());
  CommonApiController controller3 = Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Attendance'),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return CommonForm(
                widgetFilterSelectedData: Row(
                  children: [
                    Text(
                      "Class :  ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                        controller3.selectedClassName.value +
                            " ( " +
                            controller3.selectedSectionName.value +
                            " )",
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800)),
                    SizedBox(width: 20),
                    Text(
                      "Date :  ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(controller.attendanceDate.value.text,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade800)),
                  ],
                ),
                widgetFilterData: Column(
                  children: [
                    Obx(() => MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller3.classListModelMap.value,
                          valFrom: "className",
                          label: 'Class',
                          labelText: 'Class',
                          onChanged: (val) {
                            if (controller3.classListModelMap.value.length >
                                0) {
                              print("5555555555555");

                              controller3.selectedClassId.value =
                                  val['id'].toString();
                              controller3.selectedClassName.value =
                                  val['className'].toString();
                              controller3.update();
                              controller3.getSectionList();
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() => MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: controller3.sectionListModelMap.value,
                          valFrom: "section",
                          label: 'Section',
                          labelText: 'Section',
                          onChanged: (val) {
                            print(val);
                            if (controller3.sectionListModelMap.value.length >
                                0) {
                              controller3.selectedSectionId.value =
                                  val['id'].toString();
                              controller3.selectedSectionName.value =
                                  val['section'].toString();
                              controller3.update();
                            }
                          },
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    DatePickerTextField(
                        controller: controller.attendanceDate.value,
                        title: 'Attendace date',
                        onDateSelected: (date) async {
                          controller.attendanceDate.value.text =
                          await GlobalData().ConvertToSchoolDateTimeFormat(date);
                        }),

                  ],
                ),
                widgetformData: Column(
                  children: [
                SizedBox(height: 10,),
                    Expanded(
                        child: controller.isLoadingStudentList.isTrue
                            ? CustomLoader()
                            : controller.studentListModel.value.length == 0
                                ? Text("No Data")
                                : AttendancePage())
                  ],
                ),
                onTapAction: filterData);
          }),
    );
  }

  filterData() {
    print("Perform search action here");
    StudentAttendanceController controller =
        Get.put(StudentAttendanceController());
    controller.getFilterData();
    controller2.isSearchExpand.value = true;
  }
}







class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Set attendance for all students as',
          style: theme.textTheme.titleMedium,
        ),
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
              itemCount: controller.attendencetypestListModel.value.length,
              itemBuilder: (BuildContext context, int index) {
                final status =
                    controller.attendencetypestListModel.value[index].id!;
                return RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    controller.attendencetypestListModel.value[index].type!,
                    style: theme.textTheme.bodySmall,
                  ),
                  value: status,
                  groupValue: controller.selectedStatus.value,
                  onChanged: (value) {
                    setState(() {
                      print("dddd${value!}");
                      controller.selectedStatus.value = value!;
                      controller.updateForAll(value!);
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
            itemCount: controller.studentListModel.value.length,
            itemBuilder: (context, index) {
              controller.addOrUpdateRemarkController(
                  controller.studentListModel.value[index].studentSessionId!,
                  remarkFound: true,
                  remark:
                      controller.studentListModel.value[index]!.remark == null
                          ? ""
                          : controller.studentListModel.value[index]!.remark);

              return StudentTile(
                student: controller.studentListModel.value[index],
                selectedStatus: controller.selectedStatus.value,
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
                controller.saveAttendance();
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
  final Resultlist student;
  final String selectedStatus;

  const StudentTile({
    Key? key,
    required this.student,
    required this.selectedStatus,
  }) : super(key: key);

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  String? attendanceStatus;
  var selectedStatus = "";
  @override
  void initState() {
    super.initState();

    StudentAttendanceController controller2 =
        Get.put(StudentAttendanceController());
    attendanceStatus = controller2.selectedStatus.value;
    selectedStatus = controller2.attendencetypestListModel
        .firstWhere((element) => element.id! == attendanceStatus)
        .id!;
  }

  StudentAttendanceController controller =
      Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    print(controller.selectedStatus.value);
    //selectedStatus = controller.selectedStatus.value;

    selectedStatus = controller.studentAttendenceModel.value
        .firstWhere((element) =>
            element.studentSession == widget.student.studentSessionId)
        .attendencetype ?? "";
    String firstName = widget.student.firstname == null
        ? ""
        : widget.student.firstname.toString();
    String middleName = widget.student.middlename == null
        ? ""
        : widget.student.middlename.toString();
    String lastName = widget.student.lastname == null
        ? ""
        : widget.student.lastname.toString();

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
                "Admission No. :",
                style: theme.textTheme.titleSmall,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                widget.student.admissionNo.toString(),
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
                firstName + " " + middleName + " " + lastName,
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
            itemCount: controller.attendencetypestListModel.value.length,
            itemBuilder: (BuildContext context, int index) {
              var status =
                  controller.attendencetypestListModel.value[index].id!;
              return RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  controller.attendencetypestListModel.value[index].type!,
                  style: theme.textTheme.bodySmall,
                ),
                value: status,
                groupValue: selectedStatus,
                onChanged: (value) {
                  controller.updateStudentAttendence(
                      widget.student.studentSessionId, value);
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
                  controller: controller
                      .getRemarkController(widget.student.studentSessionId!),

                  // onChanged: (value) {
                  //   print("OOOOOOO${value}");
                  //   // Handle text changes
                  //   controller.updateStudentAttendenceRemark(widget.student.studentSessionId);
                  // },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}





class AttendancePage extends StatefulWidget {
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String _selectedValue = 'i';
   // Initialize all as 'P' (Present)
  StudentAttendanceController controller =
  Get.put(StudentAttendanceController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _markAll(controller,'P'); // Mark all as present
                },
                icon: Icon(Icons.check_circle, color: Colors.green),
                label: Text('All Present'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _markAll(controller,'A'); // Mark all as absent
                },
                icon: Icon(Icons.cancel, color: Colors.red),
                label: Text('All Absent'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _markAll(controller,'L'); // Mark all as on leave
                },
                icon: Icon(Icons.event_busy, color: Colors.orange),
                label: Text('All Leave'),
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.studentListModel.value.length,
            itemBuilder: (context, index) {
              Resultlist student =  controller.studentListModel.value[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(

                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/child-girl-schoolgirl-elementary-school-student-123686003.jpg'),
                  ),
                  title: Text('${student.firstname} ${student.middlename ?? ""} ${student.lastname ?? ""}',style: TextStyle(fontSize: 14),),
                  subtitle: Text('Roll No. ${student.rollNo}',style: TextStyle(fontSize: 14),),
                  trailing: Column(

                    children: [
                      Text("${student.admissionNo}"),
                      SizedBox(height: 5,),
                      GestureDetector(
                        onTap: () {
                          _toggleAttendance(controller,index); // Toggle individual attendance
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: _getAttendanceColor(controller.attendanceStatus[index]),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              controller.attendanceStatus[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () {
                    controller.saveAttendance();
                  },
                  text: 'Mark Attendance',
                  buttonTextStyle: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(width: 8),

            ],
          ),
        ),
      ],
    );
  }

  // Mark all students as present, absent, or on leave
  void _markAll(controller,String status) {
    controller.attendanceStatus = List.filled(controller.attendanceStatus.length, status);
    controller.update();
    // setState(() {
    //   _attendanceStatus = List.filled(_attendanceStatus.length, status);
    // });
  }

  // Toggle individual attendance status
  void _toggleAttendance(controller,int index) {
    setState(() {
      if (controller.attendanceStatus[index] == 'P') {
        controller.attendanceStatus[index] = 'A'; // Present to Absent
      } else if (controller.attendanceStatus[index] == 'A') {
        controller.attendanceStatus[index] = 'L'; // Absent to Leave
      } else {
        controller.attendanceStatus[index] = 'P'; // Leave to Present
      }
    });
  }

  // Get the color for each attendance status
  Color _getAttendanceColor(String status) {
    switch (status) {
      case 'P':
        return Colors.green;
      case 'A':
        return Colors.red;
      case 'L':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}