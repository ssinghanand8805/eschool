

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common_widgets/custom_loader.dart';
import 'controller/ChatController.dart';
import 'model/Chat.dart';
import 'model/RecentChat.dart' as rec;

class ChatScreen extends  GetView<ChatController> {
  // final Conversations chat;
  // final bool isGroup;
  // final String chatId;

  ChatScreen({Key? key})
      : super(
    key: key,
  );


  final List<Map<String, dynamic>> messages = [
    {
      'sender': 'John Doe',
      'message': 'Hey! How are you?',
      'time': '12:31 PM',
      'isSentByMe': false,
    },
    {
      'sender': 'You',
      'message': 'I\'m doing well! What about you?',
      'time': '12:32 PM',
      'isSentByMe': true,
    },
    {
      'sender': 'Flutter Devs',
      'message': 'Let\'s discuss the new project!',
      'time': '12:40 PM',
      'isSentByMe': false,
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: controller.chat.isGroup == 1 ? Text(controller.chat.group!.name!) :Text(controller.chat.user!.name!),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {

            },
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchDataFuture,
            builder: (context,snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.ChatModelObj.value.data!.conversations!.length,
                      itemBuilder: (context, index) {
                        final message = controller.ChatModelObj.value.data!.conversations![index];
                        print(message.sender);
                        String senderUserId = message!.sender == null ? "" : message!.sender!.id!.toString();
                        String msgSenderName = message!.sender == null ? "" : message!.sender!.name!.toString();
                        bool isSentByMe = senderUserId == controller.chatUserId  ? true : false;
                        return MessageItem(
                           controller:controller,
                          message: message,
                          isGroupChat: controller.isGroup == 1 ?  true: false,
                            isSentByMe:isSentByMe,
                            msgSenderName:msgSenderName
                        );
                      },
                    ),
                  ),
                  MessageInputField(
                    onSendMessage: (String message) {

                      print('Sending message: $message');
                    },
                  ),
                ],
              );
            }
          );
        }
      ),
    );
  }
}


class MessageItem extends StatelessWidget {

  final ChatController controller;
  final Conversations message;
  final bool isGroupChat;
  final bool isSentByMe;
  final String msgSenderName;

  const MessageItem( {
    Key? key,
    required this.controller,
    required this.message,
    this.isGroupChat = false,
    this.isSentByMe = false,
    required this.msgSenderName ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSentByMe = this.isSentByMe;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
          isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isGroupChat && !isSentByMe)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  this.msgSenderName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 14.0,
              ),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(20).copyWith(
                  bottomRight: isSentByMe ? Radius.zero : null,
                  bottomLeft: !isSentByMe ? Radius.zero : null,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message!,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.createdAt!,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MessageInputField extends StatefulWidget {
  final Function(String) onSendMessage;

  MessageInputField({Key? key, required this.onSendMessage})
      : super(
    key: key,
  );


  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 6.0,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.emoji_emotions_outlined),
                    onPressed: () {
                      // TODO: Implement emoji picker
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: Implement file attachment
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              if (_controller.text.isNotEmpty) {
                widget.onSendMessage(_controller.text);
                _controller.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }}