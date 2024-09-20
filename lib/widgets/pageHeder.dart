import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/login_screen/controller/login_controller.dart';
import '../presentation/school_url/controller/pageHeaderController.dart';

class PageHeader extends StatelessWidget {
  PageHeader({Key? key}) : super(key: key);
  PageHeaderController controller = Get.put(PageHeaderController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.3,
      child: Obx(() => controller.schoolImageUrl == ""
          ? Image.asset('assets/projectImages/friendship.png')
          : Image.network(controller.schoolImageUrl.toString(), height: 30)),
    );
  }
}
