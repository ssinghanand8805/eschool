
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/gallery_controller.dart';
import 'model/gallery.dart';
import 'model/images.dart';

class ImagesPage extends StatefulWidget {
  final String id;
  ImagesPage({required this.id});
  @override
  _ImagesPageState createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  GalleryController controller = Get.put(GalleryController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGalleryDetailById(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Images"),
        backgroundColor: Colors.green.shade200,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: controller.PageContentsModalObj.length,
        itemBuilder: (context, index) {
          return GridItemWidget(item: controller.PageContentsModalObj[index]);
        },
      ),
    );
  }
}



class GridItemWidget extends StatelessWidget {
  final PageContents item;

  GridItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.green,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.id.toString(),
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: item.image != null
                ? Image.network(item.image!, fit: BoxFit.cover)
                : Center(
              child: Text(
                item.imgName ?? '',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}