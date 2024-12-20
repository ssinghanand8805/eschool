import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

import '../chat/RecentChatScreen.dart';
import '../chat/binding/recentchat.dart';
import '../chat/controller/RecentChatController.dart';
import '../common_widgets/commingsoon.dart';
import '../dashboard/binding/dashboard_binding.dart';
import '../dashboard/controller/dashbord_controller.dart';
import '../dashboard/dashboard_screen.dart';
import '../dashboard_chart/dashboard_chart_controller.dart';
import '../dashboard_chart/screens/dash_board_screen.dart';
import '../settings/settingBinding.dart';
import '../settings/settingController.dart';
import '../settings/settingsview.dart';

class NavigationScreen extends StatefulWidget {
  final IconData iconData;
  final int index;

  NavigationScreen(this.iconData,this.index) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return getWidgetsByIndex(widget.index);
  }

  getWidgetsByIndex(index)
  {
     if(index == 0)
    {
      Get.delete<DashboardChartController>();
      dashBordBinding().dependencies();
    return DashBoardScreen();
    }
   else if(index == 1)
      {
        Get.delete<DashboardController>();
        dashBordBinding().dependencies();
        return DashboardScreen();
      }
    else if(index == 2)
      {
        Get.delete<RecentChatController>();
        RecentChatBinding().dependencies();
        return RecentChatScreen();
      }
     else if(index == 3)
     {
       Get.delete<SettingController>();
       SettingBinding().dependencies();
       return SettingView();
     }


  }

}