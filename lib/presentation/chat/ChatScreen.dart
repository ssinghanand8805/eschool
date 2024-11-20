import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/presentation/chat/userDetails.dart';
import '../../apiHelper/userData.dart';
import '../common_widgets/custom_loader.dart';
import '../login_screen/models/ChatUser.dart';
import 'controller/ChatController.dart';
import 'groupdetails.dart';
import 'model/Chat.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter/foundation.dart' as foundation;
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
        backgroundColor: Colors.green.shade200,
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
                    controller: controller,
                    groups: [
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
                              ? controller.chat.group!.name!.capitalizeFirst!
                              : controller.chat.user!.name!.capitalizeFirst!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    controller.chat.isGroup == 1
                        ? 'Tap here for group info'
                        : 'Last seen: ${controller.chat.user!.lastSeen}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.grey[600],
                    ),
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
            UserData usersData = UserData();
            ChatUser? myDetail = usersData.getChatUser();
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  var i = 0;
                  // final groupedMessages = controller.groupMessagesByDate(controller.ChatModelObj.value.data!.conversations!);
                  // final flattenedMessages = controller.flattenGroupedMessages(groupedMessages);
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          // reverse: true,
                          controller: controller.scrollController,
                          itemCount: controller.flattenedMessages.length,
                          itemBuilder: (context, index) {
                            final item = controller.flattenedMessages[index];

                            if (item is String) {
                              // This is a date header
                              DateTime date = DateTime.parse(item);
                              String formattedDate = _formatDate(date);

                              return Center(
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
                                    side: BorderSide(
                                        color: Colors.blue.shade200, width: 1),
                                  ),
                                ),
                              );
                            } else if (item is Conversations) {
                              // This is a message
                              final message = item;
                              String senderUserId = message.fromId == null
                                  ? ""
                                  : message.fromId.toString();
                              print(senderUserId);
                              print(myDetail!.data!.user!.id);
                              String msgSenderName = message.sender == null
                                  ? ""
                                  : message.sender!.name!.toString();
                              bool isSentByMe = senderUserId.toString() ==
                                  myDetail!.data!.user!.id.toString();
                              return MessageItem(
                                controller: controller,
                                message: message,
                                isGroupChat: controller.isGroup == 1,
                                isSentByMe: isSentByMe,
                                msgSenderName: msgSenderName,
                                previousMessageDate: message.createdAt!,
                              );
                            }

                            return SizedBox
                                .shrink(); // Fallback in case of unexpected data
                          },
                        ),
                      ),
                      controller.chat.group != null &&
                              controller.chat.group!.groupType == 2
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: Text(
                                "Only Admin can send messages",
                                style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 12,
                                  color: theme.primaryColorDark,
                                ),
                              ),
                            )
                          : MessageInputField(
                              onSendMessage: (String message) {
                                print('Sending message: $message');
                                controller.sendMessage(message);
                              },
                            ),
                    ],
                  );
                });
          }),
    );
  }
}

String _formatDate(DateTime messageDate) {
  final DateTime now = DateTime.now();
  final DateTime today = DateTime(now.year, now.month, now.day); // Remove time
  final DateTime yesterday =
      today.subtract(const Duration(days: 1)); // Remove time from yesterday

  // Truncate time from messageDate
  final DateTime messageDateOnly =
      DateTime(messageDate.year, messageDate.month, messageDate.day);

  if (messageDateOnly == today) {
    return "Today";
  } else if (messageDateOnly == yesterday) {
    return "Yesterday";
  } else {
    return DateFormat('MMM dd, yyyy').format(messageDateOnly);
  }
}

// List<GroupedMessage> buildGroupedMessages(List<ChatMessage> messages) {
//   List<GroupedMessage> groupedMessages = [];
//   // Group messages by date
//   var groupedByDate = groupBy<ChatMessage, DateTime>(messages, (msg) {
//   DateTime date = DateTime.fromMillisecondsSinceEpoch(msg.msgTime!);
//   return DateTime(date.year, date.month, date.day);  });
//   // Sort dates in ascending order
//    var sortedKeys = groupedByDate.keys.toList()..sort();
//    // Add grouped messages to the list
//  for (var date in sortedKeys) {
//    String formattedDate =        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//    groupedMessages.add(GroupedMessage(date: formattedDate));
//    // Sort messages within the date by msgTime in ascending order
//   var messagesForDate = groupedByDate[date]!..sort((a, b) => a.msgTime!.compareTo(b.msgTime!));
//   // Add each message to the grouped list
//   messagesForDate.forEach((msg) {
//     groupedMessages.add(GroupedMessage(message: msg));    });  }
//  return groupedMessages.reversed.toList();
//  // Return in descending date order
//   }

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
    required this.isSentByMe,
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
    print("hhhhhhh${isSentByMe}");
    DateTime messageDate = DateTime.parse(message.createdAt!);
    String formattedTime = _formatTime(message.createdAt);
    String formattedDate = _formatDate(messageDate);

    bool isFileMessage = message!.messageType == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Chip
        message.messageType == 9
            ? Center(
                child: Chip(
                  label: Text(
                    message.message!,
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  backgroundColor: Colors.yellow[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.yellow, width: 1),
                  ),
                ),
              )
            : SizedBox(),
        // Message bubble
        message.messageType == 9
            ? SizedBox()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
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
                      ChatMessageBubble(
                        message: message.message!,
                        isSentByMe: isSentByMe,
                        fileName: message.fileName,
                        imageUrl: message.message!,
                        formattedTime: formattedTime,
                        isFileMessage: isFileMessage,
                      ),
                      //             Container(
                      //               constraints: BoxConstraints(
                      //                   maxWidth: MediaQuery.of(context).size.width * 0.7),
                      //               padding: const EdgeInsets.symmetric(
                      //                   vertical: 10.0, horizontal: 14.0),
                      //               decoration: BoxDecoration(
                      //                 color: isSentByMe
                      //                     ? Theme.of(context).primaryColor.withOpacity(0.2)
                      //                     : Colors.grey[300],
                      //                 borderRadius: BorderRadius.circular(20).copyWith(
                      //                   bottomRight: isSentByMe ? Radius.zero : null,
                      //                   bottomLeft: !isSentByMe ? Radius.zero : null,
                      //                 ),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black.withOpacity(0.05),
                      //                     blurRadius: 5,
                      //                     offset: const Offset(0, 2),
                      //                   ),
                      //                 ],
                      //               ),
                      //               child: isFileMessage
                      // ?Column(
                      //                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                 children: [
                      //                   // Display the file name
                      //                   Text(
                      //                     message.fileName!,
                      //                     style: const TextStyle(
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //                   ),
                      //                   const SizedBox(height: 8),
                      //                   // Display the image from the network
                      //                   Image.network(
                      //                     message.message!,
                      //                     fit: BoxFit.cover,
                      //                     width: double.infinity, // Adjust the width as needed
                      //                     height: 200, // Adjust the height as needed
                      //                     loadingBuilder: (context, child, loadingProgress) {
                      //                       if (loadingProgress == null) {
                      //                         return child; // Show the image when loaded
                      //                       }
                      //                       return Center(
                      //                         child: CircularProgressIndicator(
                      //                           value: loadingProgress.expectedTotalBytes != null
                      //                               ? loadingProgress.cumulativeBytesLoaded /
                      //                               (loadingProgress.expectedTotalBytes ?? 1)
                      //                               : null,
                      //                         ),
                      //                       );
                      //                     },
                      //                     errorBuilder: (context, error, stackTrace) {
                      //                       return  Image.asset('assets/projectImages/no_data.png',height: 100,);
                      //                     },
                      //                   ),
                      //                   const SizedBox(height: 8),
                      //                   // Show the time if sent by the user
                      //                   if (isSentByMe)
                      //                     Text(
                      //                       formattedTime,
                      //                       style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      //                     ),
                      //                 ],
                      //               )
                      //
                      //               // ? Column(
                      //                   //     crossAxisAlignment: CrossAxisAlignment.start,
                      //                   //     children: [
                      //                   //       Text(
                      //                   //         message.fileName!,
                      //                   //         style: const TextStyle(
                      //                   //             fontSize: 16, fontWeight: FontWeight.bold),
                      //                   //       ),
                      //                   //       const SizedBox(height: 4),
                      //                   //       Text(
                      //                   //         "Size: ${message.fileName!}",
                      //                   //         style: TextStyle(
                      //                   //             fontSize: 14, color: Colors.grey[600]),
                      //                   //       ),
                      //                   //       const SizedBox(height: 4),
                      //                   //       isSentByMe
                      //                   //           ? Text(
                      //                   //               formattedTime,
                      //                   //               style: TextStyle(
                      //                   //                   fontSize: 10, color: Colors.grey[600]),
                      //                   //             )
                      //                   //           : ElevatedButton.icon(
                      //                   //               icon: const Icon(Icons.download),
                      //                   //               label: const Text("Download",style: TextStyle(color: Colors.white),),
                      //                   //               onPressed: () {
                      //                   //                 _downloadFile(message.urlDetails!,
                      //                   //                     message.fileName!);
                      //                   //               },
                      //                   //             ),
                      //                   //     ],
                      //                   //   )
                      //                   : Column(
                      //                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                       children: [
                      //                         controller.isHtml(message.message!) ? Html(
                      //                           data: message.message!,
                      //
                      //                         ) : Text(
                      //                           message.message!,
                      //                           style: const TextStyle(fontSize: 16),
                      //                         ),
                      //                         const SizedBox(height: 4),
                      //                         Text(
                      //                           formattedTime,
                      //                           style: TextStyle(
                      //                               fontSize: 10, color: Colors.grey[600]),
                      //                         ),
                      //                       ],
                      //                     ),
                      //             ),
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
  final FocusNode _focusNode = FocusNode();
  File? groupImage;
  bool _showEmoji = false;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      setState(() {
        _showEmoji = false;
        _isKeyboardVisible = true;
      });
    } else {
      setState(() {
        _isKeyboardVisible = false;
      });
    }
  }

  void _onEmojiSelected(Category? category, Emoji emoji) {
    final text = _controller.text;
    final selection = _controller.selection;
    final newText = text.replaceRange(selection.start, selection.end, emoji.emoji);
    final newSelection = TextSelection.collapsed(
      offset: selection.baseOffset + emoji.emoji.length,
    );

    _controller.value = TextEditingValue(
      text: newText,
      selection: newSelection,
    );
  }

  void _toggleEmojiKeyboard() {
    setState(() {
      _showEmoji = !_showEmoji;
      if (_showEmoji) {
        _focusNode.unfocus();
        _isKeyboardVisible = false;
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_showEmoji) {
          setState(() {
            _showEmoji = false;
          });
          return false;
        }
        return true;
      },
      child: Column(
        children: [
          Container(
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
                          icon: Icon(
                            _showEmoji ? Icons.keyboard : Icons.emoji_emotions_outlined,
                            color: _showEmoji ?Colors.grey.shade600:Colors.amber,
                          ),
                          onPressed: _toggleEmojiKeyboard,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file_sharp, color: Colors.grey.shade600),
                          onPressed: () async {
                            _pickFile(context);
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
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.greenAccent, Colors.green],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          if (_showEmoji) SizedBox(
            height: 300,
            child: EmojiPicker(
              onEmojiSelected: _onEmojiSelected,
              textEditingController: _controller,

              config: Config(
                emojiViewConfig: EmojiViewConfig(
                  emojiSizeMax: 28 *
                      (foundation.defaultTargetPlatform ==
                          TargetPlatform.iOS
                          ? 1.2
                          : 1.0),
                ),
                height: 256,
                checkPlatformCompatibility: true,

                skinToneConfig: const SkinToneConfig(),
                categoryViewConfig: const CategoryViewConfig(),
                bottomActionBarConfig: const BottomActionBarConfig(),
                searchViewConfig: const SearchViewConfig(),
              ),
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

  Future<void> _pickFile(context) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Title
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Upload File',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Options Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(
                        context: context,
                        icon: Icons.camera_alt_rounded,
                        label: 'Camera',
                        color: Colors.blue,
                        onTap: () async {
                          Navigator.pop(context);
                          final ImagePicker _picker = ImagePicker();
                          try {
                            final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera,
                            );
                            if (photo != null) {
                              print('Photo path: ${photo.path}');
                              // Handle the captured photo
                            }
                          } catch (e) {
                            print('Error picking image: $e');
                          }
                        },
                      ),
                      _buildOptionButton(
                        context: context,
                        icon: Icons.folder_rounded,
                        label: 'Files',
                        color: Colors.green,
                        onTap: () async {
                          Navigator.pop(context);
                          final FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.any,
                            allowMultiple: false,
                          );

                          if (result != null) {
                            PlatformFile file = result.files.first;
                            print('File path: ${file.path}');
                            print('File name: ${file.name}');
                            // Handle the picked file
                          }
                        },
                      ),
                      _buildOptionButton(
                        context: context,
                        icon: Icons.image_rounded,
                        label: 'Gallery',
                        color: Colors.purple,
                        onTap: () async {
                          Navigator.pop(context);
                          final ImagePicker _picker = ImagePicker();
                          try {
                            final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (image != null) {
                              print('Image path: ${image.path}');
                              // Handle the selected image
                            }
                          } catch (e) {
                            print('Error picking image: $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Cancel Button
              Padding(
                padding: EdgeInsets.all(15),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.grey.withOpacity(0.1),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 90,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  final String? fileName;
  final String? imageUrl;
  final String formattedTime;
  final bool isFileMessage;

  const ChatMessageBubble({
    Key? key,
    required this.message,
    required this.isSentByMe,
    this.fileName,
    this.imageUrl,
    required this.formattedTime,
    this.isFileMessage = false,
  }) : super(key: key);

  bool isHtml(String text) {
    return text.contains('<') && text.contains('>');
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: Radius.circular(isSentByMe ? 16 : 4),
              bottomRight: Radius.circular(isSentByMe ? 4 : 10),
            ),
          ),
          color: isSentByMe ? Colors.green.shade500 : Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isFileMessage) ...[
                  _buildFileMessage(),
                ] else ...[
                  _buildTextMessage(),
                ],
                const SizedBox(height: 4),
                _buildTimestamp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (fileName != null)
          Text(
            fileName!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSentByMe ? Colors.white : Colors.black87,
            ),
          ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl ?? '',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 160,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                    color: isSentByMe
                        ? Colors.white
                        : Theme.of(context).primaryColor,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.error_outline, color: Colors.red),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextMessage() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.6, // Limit width to 80% of screen
      ),
      child: isHtml(message)
          ? Html(
              data: message,
              style: {
                "body": Style(
                  color: isSentByMe ? Colors.white : Colors.black87,
                  fontSize: FontSize(14),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  whiteSpace: WhiteSpace.normal, // Ensures text wraps
                ),
              },
            )
          : Text(
              message,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: 13,
                color: isSentByMe ? Colors.white : Colors.black87,
              ),
              softWrap: true, // Ensures wrapping for long messages
              overflow: TextOverflow.visible,
            ),
    );
  }

  Widget _buildTimestamp() {
    return Text(
      formattedTime,
      style: TextStyle(
        fontSize: 10,
        color: isSentByMe ? Colors.white70 : Colors.grey[600],
      ),
    );
  }
}
