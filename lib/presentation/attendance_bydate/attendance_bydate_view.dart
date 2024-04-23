import 'dart:collection';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import 'controller/attendance_bydate_controller.dart';

class AttendanceByDateScreen extends StatefulWidget {
  const AttendanceByDateScreen({Key? key});

  @override
  State<AttendanceByDateScreen> createState() => _ApproveLeaveScreenState();
}

class _ApproveLeaveScreenState extends State<AttendanceByDateScreen> {
  AttendanceByDateController controller = Get.put(AttendanceByDateController());


  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
  }


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
      appBar: AppBar(title:  Text('Attendance',style: theme.textTheme.titleMedium,),),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyCustomSD(
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch: controller.students,
                  valFrom: "name",
                  label: 'Class',
                  labelText: 'Class',
                  onChanged: (val) {
                    print(val);
                    // if(val!=null){
                    //   controller.updateDutyFor = val['id'];
                    //
                    // }
                    // else{
                    //   controller.updateDutyFor=0;
                    // }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                MyCustomSD(
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch:controller.students,
                  valFrom: "name",
                  label: 'Section',
                  labelText: 'Section',
                  onChanged: (val) {
                    print(val);
                    // if(val!=null){
                    //   controller.updateDutyFor = val['id'];
                    //
                    // }
                    // else{
                    //   controller.updateDutyFor=0;
                    // }
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
                    GestureDetector(
                      onTap: () {
                        print("Perform search action here");
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 32,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.green.shade200,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 8.0),
                                Text('Search', style: theme.textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  'Attendance List',
                  style: theme.textTheme.titleLarge,
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // Text(
                //   'Set attendance for all students as',
                //   style: theme.textTheme.titleMedium,
                // ),
                //Expanded(child: StudentListPage())
              ],
            ),
          );
        }
      ),
    );
  }

}


