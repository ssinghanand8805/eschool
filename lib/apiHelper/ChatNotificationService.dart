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
      else if(data['type'] == 6) // readNotificationWhenChatWindowOpen also update unread count
          {
        final RecentChatController recentChatControllerService = Get.put(RecentChatController());
        recentChatControllerService.addUnreadCountRealTime(data);
      //  print('New private event received: ${data['owner_id']}');
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


  void listenForGroupUpdates(String groupId)
  {
    echoService.echo.private('group.${groupId}').listen('GroupEvent', (data) {
      print(data);
      if(data['type'] == 7)
        {
          final RecentChatController recentChatControllerService = Get.put(RecentChatController());
          final ChatGlobalController chatControllerService = Get.put(ChatGlobalController());
          recentChatControllerService.addIncomingMessage(data);
          chatControllerService.addIncomingMessage(data);
        }
    });
    echoService.echo.private('group.${groupId}').listenForWhisper('group-message-typing', (data) {

    print("Group Typing Start for : ${groupId}");
    }).listenForWhisper('stop-group-message-typing',  (data) {

    });

  //   Echo.private(`group.${groupId}`).
  //   listen('GroupEvent', (e) => {
  //   let group = e;
  //       let currentGroupId = $('.chat__person-box--active').data('id');
  //
  //   // Group details updated
  //   if (e.type === 1) {
  //     updateGroupDetails(e.group);
  //   } else if (e.type === 2 && currentGroupId == e.group.id) { // Group member role changed
  //     updateGroupMemberRole(e.group.id, e.user_id, e.is_admin,
  //         e.userIds);
  //   } else if (e.type === 3 && currentGroupId == e.group.id) { // member removed from group
  //     removeMemberFromGroup(e.group.id, e.user_id);
  //   } else if (e.type === 4 && currentGroupId == e.group.id) { // new members added into group
  //     let data = e.group;
  //     data.my_role = myRoleInGroup;
  //     data.users = e.group.users;
  //     addMembersToGroup(e.group.id, data);
  //   } else if (e.type === 5 && currentGroupId == e.group.id) { // group deleted by owner
  //     groupDeletedByOwner(e.group.id);
  //   } else if (e.type === 6 && currentGroupId == e.group.id) { // message read by all group members
  //     setTimeout(function () {
  //     $('.message-' + e.conversation_id).
  //     find('.chat-container__read-status').
  //     addClass('chat-container__read-status--read');
  //     }, 1000);
  //   } else if (e.type === 7) { // new group message arrived
  //     groupMessageArrived(e);
  //   } else if (e.type === 8) { // group messages read by group member
  //     updateReadByUsersOfGroupMessage(e);
  //   }
  // });
  }


  blockUnblockUserEvent(loggedInUserId,e)
  {
    if(loggedInUserId != e['blockedTo']['id'])
      {
        return;
      }


  }

}