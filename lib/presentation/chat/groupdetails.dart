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
    // print(controller.groupDetails.value!.users!.first.toJson());
    // print(controller.groupDetails.value!.users!.last.toJson());
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
      body: Obx(() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  controller.photoUrl.value.isNotEmpty
                      ? CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      NetworkImage(controller.photoUrl.value))
                      : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      AssetImage("assets/projectImages/user.jpg")),
                  SizedBox(height: 10),
                  Text(
                    controller.chatName.value.toString().capitalizeFirst!,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    controller.groupCreatedBy.value.toString(),
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
              controller.groupDescription.value.isNotEmpty
                  ? controller.groupDescription.value
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
                    child: Text('Members ${controller.groupDetails.value!.users!.length}'),
                  ),
                ) ,
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
            controller.groupDetails.value!.users == null ? Text("No Member") :
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.groupDetails.value!.users!.length,
                  itemBuilder: (context, index)  {
                    Users user = controller.groupDetails.value!.users![index];
                    return  ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          user.name![0].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(user.name!.capitalizeFirst!),
                          if (controller.groupDetails.value!.createdByUser!.id! == user.id!)
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
                          if (user.roleName! != 'Member')
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              height: 35,
                              child: Chip(
                                label: Text(
                                  user.roleName!,
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
                          if(value == 'remove')
                          {
                            controller.deleteMemberFromGroup(user.id!.toString());
                          }
                          else if(value == 'make_admin')
                            {
                              controller.makeMemberAdmin(user.id!.toString());
                            }
                          else if(value == 'remove_admin')
                          {
                            controller.removeMemberAsAdmin(user.id!.toString());
                          }
                          // Handle menu actions
                        },
                        itemBuilder: (context) => [
                          if(controller.groupDetails.value!.createdByUser!.id! != user.id!)
                          PopupMenuItem(
                            value: 'remove',
                            child: Text('Remove Member'),
                          ),
                          if(controller.groupDetails.value!.createdByUser!.id! != user.id!)
                          PopupMenuItem(
                            value: user.roleName! == 'Member' ? 'make_admin' : 'remove_admin',
                            child: user.roleName! == 'Member' ? Text('Make Admin') : Text('Remove Admin'),
                          ),
                          // if (controller.groupDetails.value!.createdByUser!.id! == user.id! || user.roleName! != 'Member')
                          //   PopupMenuItem(
                          //     value: 'make_admin',
                          //     child: Text('Make Admin'),
                          //   ),
                        ],
                      ),
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
                  onPressed: () {
                    Get.toNamed('/new_Chat',arguments: {'isAddingMember':true,'callBackFunction':controller.addNewMemberCallback});

                  },
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
      )),
    );
  }
}


