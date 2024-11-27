import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../apiHelper/userData.dart';
import '../../notifications/controller/NotificationController.dart';
import '../../theme/theme_helper.dart';
import '../dashboard/dashboard_screen.dart';
import 'NavigationScreen.dart';
import 'homepage_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<HomePage> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.dashboard,
    Icons.home,
    Icons.chat,
    Icons.settings,
  ];
  final pageList = <String>[
    "Dashoboard",
    "Home",
    "Chat",
    "Setting",
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }
  UserData userData = UserData();
  NotificationController controller2 = Get.put(NotificationController());
  HomePageController controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
   // final colors = theme;//Theme.of(context).extension<ThemeHelper>()!;
    return Scaffold(
      extendBody: true,
      appBar: _bottomNavIndex != 2 ? AppBar(
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
      ) : null,
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
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        child: NavigationScreen(iconList[_bottomNavIndex],_bottomNavIndex),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          iconList[_bottomNavIndex],
          color: theme.cardColor,
        ),
        onPressed: () {
          _fabAnimationController.reset();
          _borderRadiusAnimationController.reset();
          _borderRadiusAnimationController.forward();
          _fabAnimationController.forward();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? Colors.orange
              : theme.colorScheme.onSecondary;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  pageList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: theme.colorScheme.onPrimary,
        activeIndex: _bottomNavIndex,
        splashColor: theme.colorScheme.onPrimary,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
