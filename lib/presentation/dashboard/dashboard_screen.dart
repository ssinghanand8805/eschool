import 'package:anand_s_application1/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/material.dart';
import '../../apiHelper/userData.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../homework/HomeworkScreen.dart';
import '../lesson_plan/lesson_plan.dart';
import 'controller/dashbord_controller.dart';
// ignore_for_file: must_be_immutable

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key})
      : super(
          key: key,
        );

  DashboardController controller = Get.put(DashboardController());
  UserData usersData = UserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('App Title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notification_add),
            onPressed: () {
              // Add your action here
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LessonPlanScreen()),
              // );
              Get.toNamed(
                AppRoutes.homeworkRoute,
              );
            },
          ),
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
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, bottom: 24),
                    child: Column(
                      children:  [
                        CircleAvatar(
                          radius: 52,
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
                              //'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c21pbHklMjBmYWNlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'
                              ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                         "sandeep",
                          style: TextStyle(fontSize: 28, color: Colors.black),
                        ),
                         Text(
                         "First" + '( '+ "A" + ' )',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
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
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()),);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.error_outline),
                    title: Text('About School'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.login),
                    title: Text('Logout'),
                    onTap: () {},
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
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colorScheme.onPrimary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lbl_man_fashion".tr,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 13.v),
         // _buildGridItem(),
          SizedBox(height: 37.v),
          Text(
            "lbl_woman_fashion".tr,
            style: theme.textTheme.titleSmall,
          ),
          //_buildGridItem(),
          SizedBox(height: 13.v),

        ],
      ),
    );
  }



  /// Section Widget
  Widget _buildGridItem(IconData iconData, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 25.0),
          SizedBox(height: 8.0),
          Text(
            text,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
