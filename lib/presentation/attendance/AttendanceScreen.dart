import 'package:flutter/material.dart';
import 'package:lerno/presentation/attendance/controller/attendanceController.dart';
import 'package:lerno/presentation/common_widgets/custom_loader.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../apiHelper/toastMessage.dart';
import '../../core/app_export.dart';
import '../../theme/theme_controller.dart';
import 'model/Attendance.dart';
import 'model/monthlyAttendance.dart';

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (context1) {
        return DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: theme.primaryColor,
              title: Text(
                'Attendance',
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),
              ),
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TabBar(
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12),
                    unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 12),
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    dividerHeight: 0.0,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    indicator: BoxDecoration(
                      color: theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    tabs: [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Attendance"),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("Monthly Report"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // First tab: CBSE Marks view
                      _buildAttendanceView(context),

                      monthlyReport(context)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceView(BuildContext context) {
    return GetBuilder<AttendanceController>(
      init: controller,
      builder: (context) {
        return ListView(
          children: [
            TableCalendar<Event>(
              headerStyle: HeaderStyle(formatButtonVisible: false),
              daysOfWeekHeight: 30,
              daysOfWeekStyle: DaysOfWeekStyle(
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(50)))),
              eventLoader: (DateTime date) => controller.getEvents(date) ?? [],
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {},
              focusedDay: _focusedDay,
              firstDay: _firstDay,
              lastDay: _lastDay,
              onPageChanged: (focusedDay) {
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
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
              ),
              calendarBuilders:
                  CalendarBuilders(headerTitleBuilder: (context, day) {
                String dateString = day.toString();
                String cleanedDateString = dateString.substring(0, 10);
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(cleanedDateString),
                );
              }, markerBuilder: (context, day, events) {
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
                          ),
                        ),
                      )
                    : null;
              }),
            ),
            SizedBox(height: 10),
            Obx(() {
              return Center(
                child: Text(
                  "${controller.currentMont.value} Month Attendance",
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: CustomLoader(),
                  ),
                );
              }
              if (controller.kEvents.value.isNotEmpty) {
                Map<String, dynamic> countsMap =
                    controller.attendanceModelObj.value.counts == null
                        ? {}
                        : controller.attendanceModelObj.value.counts!.toJson();
                List<String> keys = countsMap.keys.toList();
                List<dynamic> values = countsMap.values.toList();

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: keys.length,
                  itemBuilder: (context, index) {
                    int presentDays = values[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: StatusCard(
                        color: getAttendanceColor(keys[index]),
                        count: presentDays.toString(),
                        countBackgroundColor: getAttendanceColor(keys[index]),
                        label: keys[index],
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('No attendance records available.'));
              }
            }),
          ],
        );
      },
    );
  }

  Widget monthlyReport(BuildContext context) {
    return Obx(() {
      if (controller.monthlyAttendanceModelObj.value.monthlySummary == null) {
        return CustomLoader();
      }

      List<MonthlySummary>? monthlySummary = controller.monthlyAttendanceModelObj.value.monthlySummary;
      OverallSummary? overallSummary = controller.monthlyAttendanceModelObj.value.overallSummary;

      return monthlySummary!.length > 0? Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: monthlySummary!.length,
              itemBuilder: (context, index) {
                var month = monthlySummary[index];
                return _buildMonthCard(
                  '${month.monthName}',
                  month.present.toString(),
                  month.absent.toString(),
                  month.leave.toString(),
                  month.totalWorkingDays.toString(),
                  month.attendancePercentage!.toDouble(),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(2),
            color: Colors.grey[200], // Optional styling
            child: _buildSummaryCard(
                '${overallSummary?.present ?? 0}',
                '${overallSummary?.absent ?? 0}',
                '${overallSummary?.leave ?? 0}',
                '${overallSummary?.attendancePercentage ?? 0}'),
          ),
        ],
      ):Ui.NoDataWidget();
    });
  }


  Widget _buildSummaryCard(
    String value,
    String value1,
    String value2,
    String value4,
  ) {
    return Container(
      padding: EdgeInsets.all(10),
      color: theme.primaryColorDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('Total Present', value, Colors.white),
          _buildSummaryItem('Total Absent', value1, Colors.red),
          _buildSummaryItem('Total Leave', value2, Colors.orange),
          _buildSummaryItem('Percentage', '${value4}' + '%', Colors.white),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 14)),
        Text(value,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildMonthCard(String month,  String present,
      String absent, String leave,String total, double percentage,) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 120,
            decoration: BoxDecoration(
              color: theme.primaryColorDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Center(
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  month,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Working days $total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                  Text('Your Present $present',
                      style: TextStyle(
                          color: theme.primaryColorDark, fontSize: 14)),
                  Text('Your Absent $absent',
                      style: TextStyle(color: Colors.red, fontSize: 14)),
                  Text('Your Leave $leave',
                      style: TextStyle(color: Colors.orange, fontSize: 14)),
                ],
              ),
            ),
          ),
          Container(
            width: 80,
            alignment: Alignment.center,
            child: Text(
              '${percentage.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getAttendanceColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'present':
        return Colors.green;
      case 'absent':
        return Colors.red;
      case 'late':
        return Colors.yellow;
      case 'half day':
        return Colors.orange;
      case 'holiday':
        return Colors.grey;
      case 'leave':
        return Colors.yellow;
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
      padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                child: Text(label,
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
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
