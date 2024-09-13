import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Images.dart';
import 'controller/gallery_controller.dart';
import 'model/gallery.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        backgroundColor: Colors.green.shade200,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: controller.galleryModalObj.length,
        itemBuilder: (context, index) {
          return GridItemWidget(item: controller.galleryModalObj[index]);
        },
      ),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final GalleryModal item;

  GridItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ImagesPage(id: item.id!)),
          );
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.title.toString(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: item.featureImage != null
                  ? Image.network(item.featureImage!,
                      fit: BoxFit.cover)
                  : Center(
                      child: Text(
                        item.title ?? '',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
