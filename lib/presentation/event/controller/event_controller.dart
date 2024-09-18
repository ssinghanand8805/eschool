import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lerno/presentation/daily_assignment/DailyAssignmentScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../NotificationServices/PushNotificationService.dart';
import '../../../apiHelper/Constants.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../apiHelper/popular_product_repo.dart';
import '../../../apiHelper/userData.dart';
import '../../../core/app_export.dart';
import '../models/dashboard_model.dart';
import '../models/eventModal.dart';

/// A controller class for the FormScreen.
///
/// This class manages the state of the FormScreen, including the
/// current formModelObj
class EventController extends GetxController {
  UserData userData = Get.put(UserData());
  ApiRespository apiRespository = ApiRespository(apiClient: Get.find());
  RxList<EventModal> EventModalvModelObj = <EventModal>[].obs;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  void onEventTap(CalendarTapDetails details, BuildContext context,
      Function showEventDialog) {
    if (details.appointments != null && details.appointments!.isNotEmpty) {
      final Appointment appointment = details.appointments![0] as Appointment;

      // Convert Appointment to EventModal
      EventModal event = EventModal(
        title: appointment.subject,
        eventStart:
            appointment.startTime.toString().split(' ')[0], // Extract date only
        eventEnd:
            appointment.endTime.toString().split(' ')[0], // Extract date only
        description: appointment.notes ?? 'No Description',
        // Set other fields if needed
      );

      showEventDialog(context, event);
    }
  }

  void showEventDialog(BuildContext context, EventModal event) {
    DateTime startDate = DateTime.parse(event.eventStart!);
    DateTime endDate = DateTime.parse(event.eventEnd!);
    final startDateFormatted =
        "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
    final endDateFormatted =
        "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: ContentBox(
            context: context,
            event: event,
            endDate: endDateFormatted,
            startDAte: startDateFormatted,
          ),
        );
      },
    );
  }

  Future<void> getData() async {
    Map<String, dynamic> body = {};

    var data =
        await apiRespository.postApiCallByJson(Constants.getEventList, body);
    print("DATA @@@@ ${data.body}");

    List<EventModal> d = [];
    for (var i = 0; i < data.body['listResult'].length; i++) {
      print("nmjvkjjgkjnnj");
      d.add(EventModal.fromJson(data.body['listResult'][i]));
      print("nhbhbhhhbbhhb");
    }
    EventModalvModelObj.value = d;
    print("fvffhghnhnhnhnhnhn$d");
    update();
  }
}

class ContentBox extends StatelessWidget {
  final EventModal event;
  final String endDate;
  final String startDAte;

  const ContentBox(
      {Key? key,
      required this.context,
      required this.event,
      required this.endDate,
      required this.startDAte})
      : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            event.title?.capitalizeFirst ?? 'No Title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 15),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                    style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                    title: "Event Start:",
                    value: startDAte,
                  ),
                  InfoRow(
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                    style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                    title: "Event End:",
                    value: endDate,
                  ),
                  InfoRow(
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                    style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                    title: "Event Venue:",
                    value: event.eventVenue ?? "Not specified",
                  ),
                  InfoRow(
                    style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                    style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                    title: "Description:",
                    value: event.description ?? "No description available",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 22),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
