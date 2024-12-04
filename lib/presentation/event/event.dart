import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/theme/theme_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../theme/theme_helper.dart';
import 'controller/event_controller.dart';
import 'models/eventModal.dart';

class EventCalendar extends StatefulWidget {
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  EventController controller = Get.put(EventController());

  List<Appointment> _getDataSource() {
    final List<Appointment> meetings = <Appointment>[];
    if (controller.EventModalvModelObj.isNotEmpty) {
      for (int i = 0; i < controller.EventModalvModelObj.length; i++) {
        List dateSplit =
            controller.EventModalvModelObj[i].eventStart.toString().split("-");
        final DateTime startTime = DateTime(int.parse(dateSplit[0]),
            int.parse(dateSplit[1]), int.parse(dateSplit[2]), 0, 0, 0);
        final DateTime endTime =
            startTime.add(const Duration(hours: 23, minutes: 59));
        meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          isAllDay: false,
          subject: controller.EventModalvModelObj[i].slug.toString(),
          color: Colors.green.shade400,
          id:controller.EventModalvModelObj[i].id
        ));
        print(
            "DATE :  ${meetings[i].startTime}  NAME : ${meetings[i].subject}");

      }
    }
    return meetings;
  }

  //  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ThemeController(),
      builder: (context1) {
        return Scaffold(

            appBar: AppBar(
              backgroundColor: theme.primaryColor,
              title:  Text('Event Calendar',style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),),
            ),
            body: GetBuilder(
              init: EventController(),
              builder: (context2) {
                return SfCalendar(
                  onTap: (CalendarTapDetails details) {
                   controller.onEventTap(details, context, controller.showEventDialog); // Pass the correct function
                  },
                  view: CalendarView.month,

                  allowAppointmentResize: true,
                  todayHighlightColor: Colors.blue,
                  //monthCellBuilder: monthCellBuilder,
                  //appointmentBuilder: appointmentBuilder,
                  dataSource: MeetingDataSource(_getDataSource()),

                  monthViewSettings: MonthViewSettings(
                      dayFormat: 'EEE',
                      appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                      showTrailingAndLeadingDates: false,
                      showAgenda: true,
                      agendaItemHeight: 60,
                      agendaViewHeight: 200,
                      agendaStyle: AgendaStyle(
                        backgroundColor: Colors.white,
                        appointmentTextStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            color: Colors.white),
                        dateTextStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        dayTextStyle: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      monthCellStyle: MonthCellStyle(
                          textStyle: TextStyle(fontSize: 18, color: Colors.black))),
                );
              }
            ));
      }
    );
  }

  Widget appointmentBuilder(BuildContext context,
      CalendarAppointmentDetails calendarAppointmentDetails) {
    final Appointment appointment =
        calendarAppointmentDetails.appointments.first;

    return Column(
      children: [
        Container(
          width: 70,
          color: Colors.grey,
          child: Text(
            appointment.subject.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        )
      ],
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256), // Red component (0-255)
      random.nextInt(256), // Green component (0-255)
      random.nextInt(256), // Blue component (0-255)
    );
  }

  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    return Column(
      children: [
        Container(
          child: Text(details.date.day.toString()),
        ),
        Container(
          child: IconButton(
            icon: Icon(Icons.date_range),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.now();
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.now();
  }

  @override
  String getSubject(int index) {
    return appointments![index].holidayName;
  }

  @override
  Color getColor(int index) {
    return Colors.red;
  }

  @override
  bool isAllDay(int index) {
    return true;
  }
}
