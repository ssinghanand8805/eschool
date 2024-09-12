import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import 'controller/gallery_controller.dart';

class GalleryPage extends StatefulWidget {
  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  GalleryController controller = Get.put(GalleryController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Saved\nImages are Here!',
      imageUrl: 'assets/projectImages/librarypage.jpg',
      AppbarTitle: 'Images',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
  return Text("data");
  }





}
