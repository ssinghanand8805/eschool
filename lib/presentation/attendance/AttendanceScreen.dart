import 'dart:collection';


import 'package:flutter/material.dart';
import 'package:learnladder/presentation/attendance/controller/attendanceController.dart';
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
      appBar: AppBar(title:  Text('Attendance',style: theme.textTheme.titleMedium,),),
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
                  return Container(
                    height: 30,
                    child: ListTile(
                      title: Text(item['status'] ?? '',style: theme.textTheme.bodySmall!.copyWith(fontSize: 15),),
                      // subtitle: Text(item['status'] ?? ''),
                      trailing: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getAttendanceColor(item['status']),
                        ),
                      ),
                    ),
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


