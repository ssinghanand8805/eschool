import 'package:lerno/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:lerno/theme/theme_controller.dart';
import '../../apiHelper/userData.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../login_screen/chnagePassword.dart';
import '../notifications/controller/NotificationController.dart';
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
    return GetBuilder(
        init: ThemeController(),
        builder: (context1) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.primaryColor,
              centerTitle: true,
              title: Obx(() => controller.schoolImageUrl == ""
                  ? Image.asset("assets/projectImages/LearnoLogo.png",
                      height: 30)
                  : Image.network(controller.schoolImageUrl.toString(),
                      height: 30)),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Stack(
                    clipBehavior:
                        Clip.none, // Allows the badge to go out of the box
                    children: [
                      IconButton(
                        onPressed: () {
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
                                : SizedBox
                                    .shrink(), // Don't show badge if count is 0
                          )),
                    ],
                  ),
                )
              ],
            ),
            drawer: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Header of the Drawer
                    Material(
                      color: theme.primaryColor,
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
                                      InkWell(
                                        onTap: () {
                                          print(
                                              userData.getUserImage.toString());
                                        },
                                        child: Text(
                                          userData.getUsername,
                                          style: theme.textTheme.titleSmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        userData.getUserClassSection,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      userData.getUserHasMultipleChild == true
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                controller
                                                    .loadChildList(context);
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
                          title: Text('Home',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontSize: 13)),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person_add_alt_rounded,
                            size: 18,
                          ),
                          title: Text('Profile',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontSize: 13)),
                          onTap: () {
                            /// Close Navigation drawer before
                            Navigator.pop(context);
                            Get.toNamed("/profile");
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()),);
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.password,
                            size: 18,
                          ),
                          title: Text('Change Password',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontSize: 13)),
                          onTap: () {
                            /// Close Navigation drawer before
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordScreen()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.error_outline,
                            size: 18,
                          ),
                          title: Text('About School',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontSize: 13)),
                          onTap: () {
                            Get.toNamed("/aboutSchool");
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.login,
                            size: 18,
                          ),
                          title: Text('Logout',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(fontSize: 13)),
                          onTap: () {
                            controller.logOutDialog(context);
                          },
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.4,
                        ),
                        Text(
                          "Version 1.9.0",
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
                    await controller
                        .eLearningapi(); // Example method to load data
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
                              InkWell(
                                onTap: () {

                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 290,
                                  color: theme.primaryColor,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      userData.getIsUserImage == true
                                          ? CircleAvatar(
                                              radius: 45,
                                              backgroundColor: Colors.orange,
                                              backgroundImage: NetworkImage(
                                                  userData.getUserImage
                                                      .toString()),
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
                                        userData.getUsername ?? "",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Admission No. ${userData.getUserAdmissionNo}  Class: ${userData.getUserClassSection}",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
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
        });
  }
}
