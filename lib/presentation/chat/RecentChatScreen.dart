import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../../apiHelper/SocketService.dart';
import '../common_widgets/custom_loader.dart';
import 'ChatScreen.dart';

import 'controller/RecentChatController.dart';
import 'model/RecentChat.dart';
import 'package:badges/badges.dart' as badges;
class RecentChatScreen extends StatefulWidget {



  RecentChatScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen> {
  RecentChatController controller = Get.put(RecentChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorLight,
        title:  Text('Recent Chats',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),),

        actions: [
          IconButton(
              onPressed: () {
                sendEvent();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader(); // CustomLoader();
                  }
                  return controller.recentChatModelObj.value.data != null
                      ? ListView.builder(
                          itemCount: controller.recentChatModelObj.value.data!
                              .conversations!.length,
                          itemBuilder: (context, index) {
                            final chat = controller.recentChatModelObj.value
                                .data!.conversations![index];
                            return InkWell(
                              onTap: () {
                                final String chatID = chat.isGroup == 1
                                    ? chat.group!.id!
                                    : chat.user!.id!.toString();
                                final int isGroupChat = chat.isGroup!;

                                Get.toNamed('/chatMain', arguments: {
                                  'chat': chat,
                                  'isGroup': isGroupChat,
                                  "chatId": chatID
                                });
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //
                                //
                                //
                                //       return ChatScreen(
                                //           chat:  chat
                                //       );
                                //     },
                                //   ),
                                // );
                              },
                              child: chatItem(chat),
                            );
                          },
                        )
                      : Text("No Data Found");
                });
          }),
    );
  }

  Widget chatItem(chat) {
    if (chat.isGroup == 1) {
      return _buildChatItemForGroup(chat);
    } else {
      return _buildChatItem(chat);
    }
  }

  Widget _buildChatItem(Conversations chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          // CircleAvatar(
          //   radius: 24,
          //   backgroundImage: NetworkImage(chat!.user!.photoUrl!),
          // ),
          chat.user!.photoUrl!.isNotEmpty
              ? CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(chat.user!.photoUrl!))
              : CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/projectImages/user.jpg")),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.user!.name!.capitalizeFirst!,
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.message!,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.formatChatDateString(chat.createdAt!),
                style: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                ),
              ),

                  chat.unreadCount != null && chat.unreadCount! != '0' ?  badges.Badge(
                  badgeContent: Text(chat.unreadCount!,style: theme.textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                  ),),

                ) : SizedBox(),
              const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatItemForGroup(Conversations chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          chat.group?.photoUrl != null && chat.group!.photoUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(chat.group!.photoUrl!))
              : CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/images/img.png")),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.group!.name!.capitalizeFirst!,
                  style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.message!,
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                controller.formatChatDateString(chat.createdAt!),
                style: theme.textTheme.bodySmall!.copyWith(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              if (chat.isGroup! == 1)
                Row(
                  children: [
                    chat.unreadCount != null && chat.unreadCount! != '0' ? badges.Badge(
                      badgeContent: Text(chat.unreadCount!,style: theme.textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                      ),),

                    ) : SizedBox(),
                    SizedBox(width: 10,),
                    const Icon(
                      Icons.group,
                      color: Colors.blueGrey,
                      size: 16,
                    ),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }

  sendEvent() {
    print("sending..");
    final EchoService echoService = Get.put(EchoService());
    echoService.startTypingPersonal(2, 'sam', 3);
  }
}

