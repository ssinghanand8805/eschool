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



  void onEventTap(CalendarTapDetails details, BuildContext context, Function showEventDialog) {
    if (details.appointments != null && details.appointments!.isNotEmpty) {
      final Appointment appointment = details.appointments![0] as Appointment;

      // Convert Appointment to EventModal
      EventModal event = EventModal(
        title: appointment.subject,
        eventStart: appointment.startTime.toString().split(' ')[0], // Extract date only
        eventEnd: appointment.endTime.toString().split(' ')[0], // Extract date only
        description: appointment.notes ?? 'No Description',
        // Set other fields if needed
      );

      showEventDialog(context, event);
    }
  }

  void showEventDialog(BuildContext context, EventModal event) {
    DateTime startDate = DateTime.parse(event.eventStart!);
    DateTime endDate = DateTime.parse(event.eventEnd!);
    final startDateFormatted = "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
    final endDateFormatted = "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Set the radius here
          ),
          title: Text(
            event.title!.capitalizeFirst ?? 'No Title',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.20, // Adjust as needed
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: "Event Start:", value:  startDateFormatted ),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: "Event End:", value:  endDateFormatted ),
                    
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: "Event Venue:", value: "${event.eventVenue ?? ""}"),
                    
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: "Description:", value: "${event.description ?? ""}"),
                    
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> getData() async {

    Map<String, dynamic> body = {
    };

    var data = await apiRespository.postApiCallByJson(Constants.getEventList, body);
    print("DATA @@@@ ${data.body}");

    List<EventModal> d = [];
    for(var i =0;i <data.body['listResult'].length; i++)
    {
      print("nmjvkjjgkjnnj");
      d.add(EventModal.fromJson(data.body['listResult'][i]));
      print("nhbhbhhhbbhhb");
    }
    EventModalvModelObj.value = d;
    print("fvffhghnhnhnhnhnhn$d");
    update();
  }
}