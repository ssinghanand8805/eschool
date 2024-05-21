
import 'package:flutter/material.dart';
import '../../apiHelper/userData.dart';
import '../../core/app_export.dart';
import '../../notifications/controller/NotificationController.dart';
import '../../widgets/alert_dialogue.dart';
import 'controller/dashbord_controller.dart';
// ignore_for_file: must_be_immutable

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({Key? key})
      : super(
          key: key,
        );
  UserData userData = UserData();
  NotificationController controller2 = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(  onPressed: () {  }, icon: Icon(Icons.),),
        centerTitle: true,
        title: Obx( () => controller.schoolImageUrl == "" ? Image.asset("assets/projectImages/online_logo.png", height: 30): Image.network(controller.schoolImageUrl.toString(), height: 30)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Stack(
              clipBehavior: Clip.none, // Allows the badge to go out of the box
              children: [
                IconButton(
                  onPressed: () {
                    // controller2.markNotificationAsRead(null);
                    Get.toNamed("/notificationsList");
                  },
                  icon: Image.asset(
                    "assets/projectImages/ic_notification.png",
                    height: 22,
                    color: Colors.green,
                  ),
                ),
                // Badge
                Positioned(
                    top:
                        5, // Adjust these values as needed to position the badge
                    right:
                        -3, // Adjust these values as needed to position the badge
                    child: Obx(
                      () => controller2.currentCount() > 0
                          ? Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Text(
                                controller2.currentCount().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : SizedBox.shrink(), // Don't show badge if count is 0
                    )),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AlertDialogue().show(context,
              newWidget: [
                Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.message),
                      title: Text('Term'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.termRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Assessment'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.assessmentRoute);

                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Exam Grade'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.exam_gradeRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Exam'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.examRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Exam Schedule'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.exam_scheduleRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Assign Observation'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.assign_observationRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Observation Parameter'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.observation_ParameterRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Print Marksheet'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.print_marksheetRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Observation'),
                      onTap: () async {
                        await Get.toNamed(AppRoutes.observationRoute);
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),

                    // Add more ListTiles for additional buttons
                  ],
                )
              ]);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green.shade400,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header of the Drawer
              Material(
                color: Colors.green.shade100,
                child: InkWell(
                  onTap: () {
                    /// Close Navigation drawer before
                    Navigator.pop(context);
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile()),);
                  },
                  child: Container(
                    padding: userData.getUserHasMultipleChild == true
                        ? EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            bottom: 5,
                          )
                        : EdgeInsets.only(top: 35, bottom: 25, left: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          userData.getIsUserImage
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.orange,
                                  backgroundImage: NetworkImage(
                                      userData.getUserImage.toString()),
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.orange,
                                  backgroundImage: AssetImage(
                                      'assets/projectImages/placeholder_user.png'),
                                ),
                          SizedBox(
                            width: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 18.0),
                            child: Column(
                              children: [
                                Text(
                                  userData.getUserStudentName,
                                  style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                                ),
                                Text(
                                  userData.getUserClassSection,
                                  style: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                userData.getUserHasMultipleChild == true
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          controller.loadChildList(context);
                                        },
                                        child: Icon(
                                          Icons.swap_horiz,
                                        ))
                                    : SizedBox()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              /// Header Menu items
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      size: 18,
                    ),
                    title: Text(
                      'Home',
                        style: theme.textTheme.titleSmall!.copyWith(fontSize: 14)
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person_add_alt_rounded,
                      size: 18,
                    ),
                    title: Text(
                      'Profile',
                        style: theme.textTheme.titleSmall!.copyWith(fontSize: 14)
                    ),
                    onTap: () {
                      /// Close Navigation drawer before
                      Navigator.pop(context);
                      Get.toNamed("/profile");
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()),);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.error_outline,
                      size: 18,
                    ),
                    title: Text(
                      'About School',
                        style: theme.textTheme.titleSmall!.copyWith(fontSize: 14)
                    ),
                    onTap: () {
                      Get.toNamed("/aboutSchool");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      size: 18,
                    ),
                    title: Text(
                      'Setting',
                        style: theme.textTheme.titleSmall!.copyWith(fontSize: 14)
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.login,
                      size: 18,
                    ),
                    title: Text(
                      'Logout',
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14)
                    ),
                    onTap: () {
                      controller.logOutDialog(context);
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.4,
                  ),
                  Text(
                    "Version 1.0.0",
                    style: theme.textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ), //
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return RefreshIndicator(
            onRefresh: () async {
              // Implement your refresh logic here
              await controller.eLearningapi(); // Example method to load data
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: false,
                  floating: false,
                  centerTitle: true,
                  leading: Container(),
                  // title: TextWidget(detail.title,
                  //     weight: FontWeight.bold
                  // ),
                  expandedHeight: 240,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.parallax,
                    background: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 290,
                          color: Colors.green.shade100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              userData.getIsUserImage == true
                                  ? CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.orange,
                                      backgroundImage: NetworkImage(
                                          userData.getUserImage.toString()),
                                    )
                                  : CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.orange,
                                      backgroundImage: AssetImage(
                                          'assets/projectImages/placeholder_user.png'),
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                userData.getFaculity()!.name!,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Role. ${userData.getFaculity()!.roles!.roleName!} ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, int index) {
                      return controller.gridViewWidgets[index];
                    },
                    childCount: controller.gridViewWidgets.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
