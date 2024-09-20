import 'dart:collection';


import 'package:flutter/material.dart';
import 'package:lerno/presentation/attendance/controller/attendanceController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/app_export.dart';
import '../../theme/theme_helper.dart';
import 'model/Attendance.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  AttendanceController controller = Get.put(AttendanceController());
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();

    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
  }

  final List<Map<String, String>> attendanceData = [
    {'name': 'Alice', 'status': 'Present'},
    {'name': 'Bob', 'status': 'Absent'},
    {'name': 'Charlie', 'status': 'Late'},
    {'name': 'David', 'status': 'Half Day'},
    {'name': 'Eve', 'status': 'Holiday'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade100,
          title:  Text('Attendance',style: theme.textTheme.titleLarge!.copyWith(fontSize: 17))),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return ListView(
            children: [
              TableCalendar<Event>(
                headerStyle: HeaderStyle(
                  formatButtonVisible : false,
                ),
                daysOfWeekHeight: 30,
                daysOfWeekStyle: DaysOfWeekStyle(
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(50))
                    )
                ),
                eventLoader: (DateTime date) => controller.getEvents(date) ?? [],
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  // setState(() {
                  //   _calendarFormat = format;
                  // });
                },
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                onPageChanged: (focusedDay) {
                  print("********${focusedDay}");
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                  controller.getDataFromApi(focusedDay);
                },
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: const CalendarStyle(
                  // weekendTextStyle: TextStyle(
                  //   color: Colors.red,
                  // ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    String dateString = day.toString();

                    String cleanedDateString = dateString.substring(0, 10); // Extracts "2024-04-01"
                    print(cleanedDateString);
                    print("dgfgfdg"+day.toString());
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(cleanedDateString.toString()),
                    );

                  },
                    markerBuilder: (context, day, events) {
                      return events.isNotEmpty
                          ? PositionedDirectional(
                        bottom: 0,
                        end: 0,
                        child: Center(
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getAttendanceColor(events[0].title),
                              ),
                            )),
                      )
                          : null;
                    }
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {


                  final item = attendanceData[index];

                  int presentDays = attendanceData.where((entry) => entry["type"] == "Present")
                      .length;

                  print("jfnvjfnjvnfjvnfn${attendanceData}");
                 return Padding(
                   padding: const EdgeInsets.only(top: 15.0),
                   child: StatusCard(
                      color:getAttendanceColor(item['status']),
                     count: presentDays.toString(),
                     countBackgroundColor: getAttendanceColor(item['status']),
                     label: item['status'] ?? '',
                   )
                 );





                },
              ),

            ],
          );
        }
      ),
    );
  }





  Color getAttendanceColor(String? status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Late':
        return Colors.yellow;
      case 'Half Day':
        return Colors.orange;
      case 'Holiday':
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }
}


class StatusCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  final Color countBackgroundColor;

  StatusCard({
    required this.label,
    required this.count,
    required this.color,
    required this.countBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            // Left colored strip
            Container(
              height: 45, // Adjust height as per your requirement
              width: 15,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  label,
                    style: theme.textTheme.titleLarge!.copyWith(fontSize: 13,fontWeight: FontWeight.w600)
                ),
              ),
            ),

            // Circular badge for count
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: countBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    count,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


