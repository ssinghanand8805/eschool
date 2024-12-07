import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';

import '../../widgets/myCustomsd.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/UserListController.dart';
import 'model/StaffList.dart';



class NewConversationsPage extends GetView<UserListController>  {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title:  Text("Users",style: theme.textTheme.bodyMedium,),
        bottom: TabBar(
          controller: controller.tabController,
          //  isScrollable: true,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Staff"),
            Tab(text: "Students"),
            // Tab(text: "Groups"),
            // Tab(text: "Blocked Users"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _buildStaffContactsTab(),
          _buildNewConversationTab(context),
          // _buildGroupsTab(),
          // _buildBlockedUsersTab(),
        ],
      ),
      floatingActionButton: Obx ( () { return controller.isAddingMember.value && controller.selectedItems.values.any((value) => value)? FloatingActionButton(
        onPressed: () {
         if(controller.callBackFunction != null)
           {
             controller.callBackFunction(controller.selectedItems);
             Get.back();
           }
        },
        tooltip: 'Add',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.save),
      ) : SizedBox(); } ),

    );
  }

  Widget _buildStaffContactsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: controller.txtController,
                  hint: 'Search...',
                  title: 'Search',
                ),
              ),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: "Male", child: Text("Male")),
                  const PopupMenuItem(value: "Female", child: Text("Female")),
                  const PopupMenuItem(value: "Online", child: Text("Online")),
                  const PopupMenuItem(value: "Offline", child: Text("Offline")),
                ],
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: controller.fetchDataFuture,
          builder: (context1,snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            }

            return   controller.staffUserList.value.data == null ? Container(child: Text("no data found"),) :

              Expanded(
              child: ListView.builder(
                itemCount: controller.staffUserList.value.data!.users!.length, // Replace with actual contact count
                itemBuilder: (context, index) {
                  Users staff = controller.staffUserList.value.data!.users![index];
                  return Obx(() => GestureDetector(
                    onTap: () {
                      if(controller.isAddingMember.value == true)
                        {
                          controller.selectedItems[staff.id!.toString()] =
                          !(controller.selectedItems[staff.id!.toString()] ?? false);
                        }

                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title:  Text(staff.name!),
                      subtitle: Text(staff.roleName!),
                      trailing: controller.isAddingMember.value == true ?
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          color: controller.selectedItems[staff.id!.toString()]!
                              ? Colors.blue
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: controller.selectedItems[staff.id!.toString()]!
                                ? Colors.blue
                                : Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: controller.selectedItems[staff.id!.toString()]!
                            ? Icon(Icons.check, color: Colors.white, size: 20.0)
                            : null, // Show check icon if selected
                      )
                          : IconButton(
                        icon: const Icon(Icons.message, color: Colors.blue),
                        onPressed: () {
                          // Action for messaging
                        },
                      ),
                    ),
                  ));
                },
              ),
            );
          }
        ),
      ],
    );
  }
  Widget _buildStudentsContactsTab() {
    return Obx(() => Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.txtController,
                    hint: 'Search...',
                    title: 'Search',
                  ),
                ),
                const SizedBox(width: 10),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list),
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: "Male", child: Text("Male")),
                    const PopupMenuItem(value: "Female", child: Text("Female")),
                    const PopupMenuItem(value: "Online", child: Text("Online")),
                    const PopupMenuItem(value: "Offline", child: Text("Offline")),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
              future:  controller.getStudentDataByClassAndSection(),
              builder: (context1,snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return CustomLoader(); // CustomLoader();
                }

                return   controller.studentUserList.value.data == null ? Container(child: Text("no data found"),) :

              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.studentUserList.value.data!.users!.length, // Replace with actual contact count
                  itemBuilder: (context, index) {
                    Users student = controller.studentUserList.value.data!.users![index];
                    return GestureDetector(
                      onTap: () {
                        if(controller.isAddingMember.value == true)
                        {
                          controller.selectedItems[student.id!.toString()] =
                          !(controller.selectedItems[student.id!.toString()] ?? false);
                          controller.update();
                        }

                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title:  Text(student.name!),
                        subtitle: Text(student.roleName!),
                        trailing: controller.isAddingMember.value ?
                        Obx(() => Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            color: controller.selectedItems[student.id!.toString()]!
                                ? Colors.blue
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: controller.selectedItems[student.id!.toString()]!
                                  ? Colors.blue
                                  : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          child: controller.selectedItems[student.id!.toString()]!
                              ? Icon(Icons.check, color: Colors.white, size: 20.0)
                              : null, // Show check icon if selected
                        ))
                            : IconButton(
                          icon: const Icon(Icons.message, color: Colors.blue),
                          onPressed: () {
                            final String chatID = student.id!.toString();
                            final int isGroupChat = 0;
                            bool isAllowSend =  false;
                            String lastSeen = student.lastSeen == null ?  'Last seen: never' : 'Last seen: ${student.lastSeen}';
                            String chatName = student!.name!.capitalizeFirst! ;
                            String photoUrl =    student!.photoUrl!;


                            String groupCreatedBy =  '' ;
                            String groupDescription =  '' ;
                            String chatUserAbout = student.about.toString() ;
                            String chatUserPhone = student.phone.toString() ;
                            String chatUserEmail = student.email.toString() ;

                            Get.toNamed('/chatMain', arguments: {
                              'isGroup': isGroupChat,
                              "chatId": chatID,
                              "photoUrl":photoUrl,
                              "chatName":chatName,
                              "lastSeen":lastSeen,
                              "isAllowToSend":isAllowSend,

                              "groupCreatedBy":groupCreatedBy,
                              "groupDescription":groupDescription,
                              "chatUserAbout":chatUserAbout,
                              "chatUserPhone":chatUserPhone,
                              "chatUserEmail":chatUserEmail,
                            });

                          },
                        ),
                      ),
                    );
                  },
                );
              }
          ),
        ],
      ),
    ));
  }
  Widget _buildNewConversationTab(context) {
    return  Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() => MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:
                controller.commonApiController.classListModelMap.value,
                valFrom: "className",
                label: 'Class',
                labelText: 'Class',
                onChanged: (val) {
                  print(val);
                  if (controller.commonApiController
                      .classListModelMap.value.length >
                      0) {
                    print("5555555555555");

                    controller.commonApiController.selectedClassId.value =
                        val['id'].toString();
                    controller. commonApiController.selectedClassName.value =
                        val['className'].toString();
                    controller.commonApiController.getSectionList();
                    controller.commonApiController.update();

                  }
                },
              )),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Obx(() {
                return MyCustomSD(
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch:
                  controller.commonApiController.sectionListModelMap.value,
                  valFrom: "section",
                  label: 'Section',
                  labelText: 'Section',
                  onChanged: (val) {
                    print(val);
                    if (val != null) {
                      if (controller.commonApiController
                          .sectionListModelMap.value.length >
                          0) {
                        controller.commonApiController.selectedSectionId.value =
                            val['section_id'].toString();
                        controller.commonApiController.selectedSectionName
                            .value = val['section'].toString();
                        controller.commonApiController.update();
                        //
                      }
                    }
                  },
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 10,),
        _buildStudentsContactsTab()
      ],
    );
  }


}
