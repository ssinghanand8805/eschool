import 'package:learnladder/presentation/login_screen/models/userDataModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../apiHelper/userData.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'controller/dashbord_controller.dart';
// ignore_for_file: must_be_immutable

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton( Icons.drag_handle_rounded),
      //   title: Text("My App"),
      //   actions: [Icon(Icons.notification_add)],
      //
      // ),
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
                          // Text(
                          //   usersData.getData("UserData", UsersData()).role.toString(),
                          //   style: TextStyle(fontSize: 28, color: Colors.black),
                          // ),
                          //  Text(
                          //   usersData.getData("userData").record.className + '( '+ usersData.getData("userData").record.section + ' )',
                          //   style: TextStyle(fontSize: 14, color: Colors.black),
                          // ),
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
      body: GetBuilder(
        init: controller,
        builder: (_){
          return CustomScrollView(
            controller: controller.scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
                floating: false,
                centerTitle: true,
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
                        color: Colors.amber,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 50,
                            ),
                            SizedBox(height: 10,),
                            Text("User Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                              ),),
                            Text("Section",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal
                              ),),
                            SizedBox(height: 20,),
                          ],
                        ),),
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
          );
        },
      ),
    );
  }

}
