import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/presentation/chat/userDetails.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/ChatController.dart';
import 'groupdetails.dart';
import 'model/Chat.dart';
import 'package:open_filex/open_filex.dart';

class ChatScreen extends GetView<ChatController> {
  ChatScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        titleSpacing: -14,
        leading: Container(
          margin: EdgeInsets.only(right: 0),
          width: 10,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: theme.primaryColorLight,
        title: InkWell(
          onTap: () {
            if (controller.chat.isGroup == 1) {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => GroupDetails(email: controller.chat.group!., groups: [],
              //
              //     ),
              //   ),
              // );
              //
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileModal(
                    controller:controller,
                    groups:  [
                    {'name': 'Test', 'members': 'You, Anand Singh, San...'},
                    {'name': 'test2', 'members': 'You, Anand Singh, San...'},
                    ],
                  ),
                ),
              );
            }
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                child: CircleAvatar(
                  backgroundImage: controller.chat.isGroup == 1
                      ? NetworkImage(controller.chat.group!.photoUrl!)
                      : NetworkImage(controller.chat.user!.photoUrl!),
                  radius: 20, // Adjust size as needed
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.1,
                    child: Row(
                      children: [
                        Text(
                          controller.chat.isGroup == 1
                              ? controller.chat.group!.name!
                              : controller.chat.user!.name!,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    controller.chat.isGroup == 1
                        ? 'Tap here for group info'
                        : 'Last seen: ${controller.chat.user!.lastSeen}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder(
          init: controller,
          builder: (context) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller
                              .ChatModelObj.value.data!.conversations!.length,
                          itemBuilder: (context, index) {
                            final message = controller
                                .ChatModelObj.value.data!.conversations![index];
                            print(message.sender);
                            String senderUserId = message!.sender == null
                                ? ""
                                : message!.sender!.id!.toString();
                            String msgSenderName = message!.sender == null
                                ? ""
                                : message!.sender!.name!.toString();
                            bool isSentByMe =
                                senderUserId == controller.chatUserId
                                    ? true
                                    : false;
                            return MessageItem(
                              controller: controller,
                              message: message,
                              isGroupChat:
                                  controller.isGroup == 1 ? true : false,
                              isSentByMe: isSentByMe,
                              msgSenderName: msgSenderName,
                              previousMessageDate: controller.chat.createdAt!,
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
                });
          }),
    );
  }
}

class MessageItem extends StatelessWidget {
  final ChatController controller;
  final Conversations message;
  final bool isGroupChat;
  final bool isSentByMe;
  final String msgSenderName;
  final String previousMessageDate;

  const MessageItem({
    Key? key,
    required this.controller,
    required this.message,
    this.isGroupChat = false,
    this.isSentByMe = false,
    required this.msgSenderName,
    required this.previousMessageDate,
  }) : super(key: key);

  String _formatTime(String? dateTime) {
    DateTime parsedDate = DateTime.parse(dateTime!);
    return DateFormat('h:mm a').format(parsedDate);
  }

  String _formatDate(DateTime messageDate) {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime yesterday = DateTime(now.year, now.month, now.day - 1);

    if (messageDate.isAfter(today)) {
      return "Today";
    } else if (messageDate.isAfter(yesterday)) {
      return "Yesterday";
    } else {
      return DateFormat('MMM dd, yyyy').format(messageDate);
    }
  }

  Future<void> _downloadFile(String url, String fileName) async {
    Dio dio = Dio();
    try {
      String savePath =
          '/storage/emulated/0/Download/$fileName'; // Define the download path
      await dio.download(url, savePath);
      await OpenFilex.open(savePath); // Open the file after downloading
    } catch (e) {
      print("Download failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSentByMe = this.isSentByMe;
    DateTime messageDate = DateTime.parse(message.createdAt!);
    String formattedTime = _formatTime(message.createdAt);
    String formattedDate = _formatDate(messageDate);

    bool isFileMessage = message.urlDetails != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Chip
        Center(
          child: Chip(
            label: Text(
              formattedDate,
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14),
            ),
            backgroundColor: Colors.blue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.blue, width: 1),
            ),
          ),
        ),
        // Message bubble
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Align(
            alignment:
                isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: isSentByMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Sender name in group chat
                if (isGroupChat && !isSentByMe)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      msgSenderName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                // Message content
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 14.0),
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
                  child: isFileMessage
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.fileName!,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Size: ${message.urlDetails!}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 4),
                            isSentByMe
                                ? Text(
                                    formattedTime,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey[600]),
                                  )
                                : ElevatedButton.icon(
                                    icon: const Icon(Icons.download),
                                    label: const Text("Download"),
                                    onPressed: () {
                                      _downloadFile(message.urlDetails!,
                                          message.fileName!);
                                    },
                                  ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.message!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MessageInputField extends StatefulWidget {
  final Function(String) onSendMessage;

  MessageInputField({Key? key, required this.onSendMessage}) : super(key: key);

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();
  File? groupImage;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File pickedFile = File(result.files.single.path!);
      setState(() {
        groupImage = pickedFile;
      });
    }
  }

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
                      icon: Icon(Icons.attach_file),
                      onPressed: () async {
                        _pickFile();
                      }),
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
  }
}
