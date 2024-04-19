import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import '../../../core/app_export.dart';
import '../model/FCMNotifications.dart';





class NotificationController extends GetxController {


  RxList<FCMNotifications> notificationModelObj = <FCMNotifications>[].obs;
  RxInt currentCount = 0.obs;
  late Future<void> fetchDataFuture;
  @override
  void onClose() {
    super.onClose();

  }
  @override
  void onInit() {
    super.onInit();
    fetchDataFuture = getData(); // Initialize the future when the controller is created
  }
  Future<void> getData() async
  {
    List<Map<String, dynamic>> data =  getNotifications();
    List<FCMNotifications> d = [];
    for(var i =0;i<data.length; i++)
    {
      d.add(FCMNotifications.fromJson(data[i]));
    }
    notificationModelObj.value = d;
    countUnreadNotifications();
    update();
  }

  List<Map<String, dynamic>> getNotifications()  {
    final box =  GetStorage();
    var storedNotifications = box.read('notifications');
   return storedNotifications != null ? List<Map<String, dynamic>>.from(json.decode(storedNotifications)) : [];

  }

  void AddNewNotification(id,title,body)
  {
    final box = GetStorage();
    var currentNotifications = box.read('notifications');
    List<dynamic> notifications = currentNotifications != null ? json.decode(currentNotifications) : [];
    notifications.add({
      'id':id,
      'title': title,
      'body': body,
      'timestamp': DateTime.now().toIso8601String(),
      'read': false  // default is unread
    });
    box.write('notifications', json.encode(notifications));
    countUnreadNotifications();
    getData();
  }

  void markNotificationAsRead(int? index) {
    final box = GetStorage();
    var storedNotifications = box.read('notifications');
    if (storedNotifications != null) {
      List<dynamic> notifications = json.decode(storedNotifications);

      if (index != null && index < notifications.length) {
        notifications[index]['read'] = true;  // Mark as read
      } else {
        // If index is null, mark all as read
        notifications.forEach((n) => n['read'] = true);
      }

      // Save back to storage
      box.write('notifications', json.encode(notifications));
      countUnreadNotifications();
      update();  // Update the UI if needed
    }
  }


  int countUnreadNotifications() {
    final box = GetStorage();
    var storedNotifications = box.read('notifications');
    if (storedNotifications == null) return 0;

    List<dynamic> notifications = json.decode(storedNotifications);
    int unreadCount = 0;

    for (var notification in notifications) {
      if (notification['read'] == false) {
        unreadCount++;
      }
    }
    currentCount.value = unreadCount;
    update();
    return unreadCount;
  }

}
