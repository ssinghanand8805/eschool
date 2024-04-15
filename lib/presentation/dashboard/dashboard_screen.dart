import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../apiHelper/userData.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
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
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(  onPressed: () {  }, icon: Icon(Icons.),),
        centerTitle: true,
        title: Obx(() { if (controller.schoolImageUrl.value == "") {
          return CircularProgressIndicator();  // Show loading indicator
        } else {
          return Image.network(controller.schoolImageUrl.value!);  // Show the image
        } } ),

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
              color: Colors.deepOrangeAccent,
            ),
          ),
          // Badge
          Positioned(
            top: -5, // Adjust these values as needed to position the badge
            right: -5, // Adjust these values as needed to position the badge
            child:  Obx(() => controller2.currentCount() > 0 ? Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Text(
                controller2.currentCount().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              ),
            ) : SizedBox.shrink(), // Don't show badge if count is 0
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
                        : EdgeInsets.only(
                            top: 35,
                            bottom: 25,
                      left: 10
                          ),
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
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  userData.getUserClassSection,
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                userData.getUserHasMultipleChild == true
                                    ? InkWell(
                                        onTap: () {},
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
                    leading: Icon(Icons.home_outlined),
                    title: Text('Home'),
                    onTap: () {
                      /// Close Navigation drawer before
                      Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add_alt_rounded),
                    title: Text('Profile'),
                    onTap: () {
                      /// Close Navigation drawer before
                      Navigator.pop(context);
                      Get.toNamed("/profile");
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()),);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.error_outline),
                    title: Text('About School'),
                    onTap: () {
                      Get.toNamed("/aboutSchool");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Logout'),
                    onTap: () {
                      controller.logout();

                    },
                  ),
                  const Divider(
                    color: Colors.black45,
                  ),
                  Text("Version 1.6.6")
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
                              userData.getIsUserImage
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
                                userData.getUserStudentName,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Admission No. ${userData.getUserAdmissionNo}  Class: ${userData.getUserClassSection}",
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
