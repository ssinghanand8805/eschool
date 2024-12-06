import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'controller/ChatController.dart';
import 'model/Chat.dart';

class GroupDetailsPage extends GetView<ChatController> {
  GroupDetailsPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'About',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit,size: 18,),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  controller.photoUrl!.isNotEmpty
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(controller.photoUrl!))
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage("assets/projectImages/user.jpg")),
                  SizedBox(height: 10),
                  Text(
                    controller.chatName.toString().capitalizeFirst!,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    controller.groupCreatedBy.toString(),
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 13, color: theme.unselectedWidgetColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Description Section
            Text(
              'Description',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              controller.groupDescription.isNotEmpty
                  ? controller.groupDescription
                      .toString()
                      .capitalizeFirst!
                  : 'No description added yet...',
              style: theme.textTheme.titleMedium!.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Members ${controller.groupDetails!.users!.length}'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text('Media '),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Members',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            controller.groupDetails!.users == null ? Text("No Member") :
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                  itemCount: controller.groupDetails!.users!.length,
              itemBuilder: (context, index)  {
               Users user = controller.groupDetails!.users![index];

                  return MemberTile(
                    name: user.name!,
                    isOwner: controller.groupDetails!.createdByUser!.id! == user.id!,
                  );
                }
              ),
            ),


            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.all(3),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () { Get.toNamed('/new_Chat',arguments: {'isAddingMember':true});},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    'Add Members',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {

                    // Navigator.pop(context) ;

                    },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Delete Group',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final String name;
  final bool isOwner;
  final ChatController? controller;

  const MemberTile({required this.name, this.isOwner = false, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          name[0].toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      title: Row(
        children: [
          Text(name.capitalizeFirst!),
          if (isOwner)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 35,
                child: Chip(
                  label: Text(
                    'Owner',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    trailing:  PopupMenuButton<String>(
        onSelected: (value) {
          // Handle menu actions
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'remove',
            child: Text('Remove Member'),
          ),
          PopupMenuItem(
            value: 'make_admin',
            child: Text('Make Admin'),
          ),
        ],
      ),
    );
  }
}
