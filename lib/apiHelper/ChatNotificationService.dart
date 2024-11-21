import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../presentation/chat/controller/ChatController.dart';
import '../presentation/chat/controller/ChatGlobalController.dart';
import '../presentation/chat/controller/RecentChatController.dart';
import 'SocketService.dart';

class ChatNotificationService {
  final EchoService echoService;

  ChatNotificationService(this.echoService);

  void listenToUserChannel(String loggedInUserId) {
    echoService.echo.private('user.$loggedInUserId').listen('UserEvent', (data) {
      log(jsonEncode(data));
      print('New private event received: ${data['type']}');
      print('New private event received: ${data['owner_id']}');
      if(data['type'] == 1) // block-unblock user event
        {

        }
      else if(data['type'] == 2) // new user-to-user message arrived
          {

       final RecentChatController recentChatControllerService = Get.put(RecentChatController());
       final ChatGlobalController chatControllerService = Get.put(ChatGlobalController());
       recentChatControllerService.addIncomingMessage(data);
       chatControllerService.addIncomingMessage(data);
          }
      else if(data['type'] == 3) // added to group
          {

          }
      else if(data['type'] == 4) // private message read
          {

          }
      else if(data['type'] == 5) // message deleted for everyone
          {

          }

      // Handle the event data (e.g., update UI or show a notification)

    });

    echoService.echo.private('chat').listenForWhisper('start-typing.${loggedInUserId}', (data) {


    }).listenForWhisper('stop-typing.${loggedInUserId}',  (data) {

    });

    echoService.echo.join('user-status').here((users) {

    }).joining((user) {

    }).leaving((user) {

    });
    // echoService.echo('jj').whi
  }



  blockUnblockUserEvent(loggedInUserId,e)
  {
    if(loggedInUserId != e['blockedTo']['id'])
      {
        return;
      }


  }

}