import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_widgets/custom_loader.dart';
import 'ChatScreen.dart';

import 'controller/RecentChatController.dart';
import 'model/RecentChat.dart';



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
  final List<Map<String, dynamic>> recentChats = [
    {
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'time': '12:30 PM',
      'isGroupChat': false,
      'avatar': 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'
    },
    {
      'name': 'Flutter Devs',
      'message': 'New project update',
      'time': '11:00 AM',
      'isGroupChat': true,
      'avatar': 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'
    },
    {
      'name': 'Emily Watson',
      'message': 'Lunch tomorrow?',
      'time': '10:15 AM',
      'isGroupChat': false,
      'avatar': 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'
    },
    {
      'name': 'Team Alpha',
      'message': 'Meeting at 3 PM',
      'time': '9:00 AM',
      'isGroupChat': true,
      'avatar': 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recent Chats'),
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
              return ListView.builder(
                itemCount: controller.recentChatModelObj.value.data!.conversations!.length,
                itemBuilder: (context, index) {
                  final chat = controller.recentChatModelObj.value.data!.conversations![index];
                  return  InkWell(
                    onTap: () {
                      final String chatID = chat.isGroup == 1 ? chat.group!.id! : chat.user!.id!.toString();
                      final int isGroupChat = chat.isGroup!;
                      Get.toNamed('/chatMain',arguments: { 'chat': chat,'isGroup': isGroupChat,"chatId": chatID});
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
              );
            }
          );
        }
      ),
    );
  }
Widget chatItem(chat)
{
  if(chat.isGroup == 1)
    {
      return _buildChatItemForGroup(chat);
    }
  else
    {
      return _buildChatItem(chat);
    }
}
  Widget _buildChatItem(Conversations chat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(chat!.user!.photoUrl!),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.user!.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.message!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
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
                chat.createdAt!,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
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
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(chat.group!.photoUrl!),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.group!.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chat.message!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
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
                chat.createdAt!,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              if (chat.isGroup! == 1)
                const Icon(
                  Icons.group,
                  color: Colors.blueGrey,
                  size: 16,
                )
            ],
          ),
        ],
      ),
    );
  }
}

