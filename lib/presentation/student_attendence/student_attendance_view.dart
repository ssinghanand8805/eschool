import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/presentation/common_widgets/controller/CommonApiController.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import '../../../widgets/myCustomsd.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
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
  CommonController controller2 =
  Get.put(CommonController());
  CommonApiController controller3 =
  Get.put(CommonApiController());
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
           widgetFilterSelectedData: Row(
             children: [
               Text("Class :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
               Text(controller3.selectedClassName.value + " ( " + controller3.selectedSectionName.value + " )",
                   style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
               SizedBox(width: 20),
               Text("Date :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
               Text(controller.attendanceDate.value.text,style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
             ],
           ),
           widgetFilterData: Column(
                            children: [
               Obx( () => MyCustomSD(

                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: controller3.classListModelMap.value,
                                valFrom: "className",
                                label: 'Class',
                                labelText: 'Class',
                                onChanged: (val) {
                                  if(controller3.classListModelMap.value.length > 0)
                                    {
                                      print("5555555555555");

                                      controller3.selectedClassId.value = val['id'].toString();
                                      controller3.selectedClassName.value = val['className'].toString();
                                      controller3.update();
                                      controller3.getSectionList();
                                    }

                                },
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Obx( () => MyCustomSD(
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: controller3.sectionListModelMap.value,
                                valFrom: "section",
                                label: 'Section',
                                labelText: 'Section',
                                onChanged: (val) {
                                  print(val);
                                  if(controller3.sectionListModelMap.value.length > 0)
                                  {


                                    controller3.selectedSectionId.value = val['id'].toString();
                                    controller3.selectedSectionName.value = val['section'].toString();
                                    controller3.update();

                                  }

                                },
                              )),
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

          Expanded(child: controller.isLoadingStudentList.isTrue ? CustomLoader() : controller.studentListModel.value.length == 0 ?
          Text("No Data") : StudentListPage())
          ]
           ,),
           onTapAction: filterData);

        }
      ),
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
    StudentAttendanceController controller2 =
    Get.put(StudentAttendanceController());

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
                final status = controller.attendencetypestListModel.value[index].id!;
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
              controller.addOrUpdateRemarkController(controller.studentListModel.value[index].studentSessionId!,remarkFound: true,
                  remark: controller.studentListModel.value[index]!.remark == null ? "" : controller.studentListModel.value[index]!.remark);

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
    selectedStatus = controller2.attendencetypestListModel.firstWhere((element) => element.id! == attendanceStatus).id!;
  }
  StudentAttendanceController controller =
  Get.put(StudentAttendanceController());

  @override
  Widget build(BuildContext context) {
    print(controller.selectedStatus.value);
     //selectedStatus = controller.selectedStatus.value;

   selectedStatus = controller.studentAttendenceModel.value.firstWhere((element) => element.studentSession == widget.student.studentSessionId).attendencetype!;
    String firstName = widget.student.firstname == null ? "" : widget.student.firstname.toString();
    String middleName = widget.student.middlename == null ? "" : widget.student.middlename.toString();
    String lastName = widget.student.lastname == null ? "" : widget.student.lastname.toString();

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
              var status = controller.attendencetypestListModel.value[index].id!;
              return RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  controller.attendencetypestListModel.value[index].type!,
                  style: theme.textTheme.bodySmall,
                ),
                value: status,
                groupValue: selectedStatus,
                onChanged: (value) {
                  controller.updateStudentAttendence(widget.student.studentSessionId,value);


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
                  controller: controller.getRemarkController(widget.student.studentSessionId!),

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



