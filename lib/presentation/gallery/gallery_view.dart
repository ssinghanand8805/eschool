import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiHelper/toastMessage.dart';
import '../../theme/theme_helper.dart';
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
        title: Text(
          "Gallery",
          style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),
        ),
        backgroundColor: Colors.green.shade100,
      ),
      body: GetBuilder(
          init: GalleryController(),
          builder: (context) {
            return controller.galleryModalObj.length > 0 ?GridView.builder(
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
            ):Ui.NoDataWidget();
          }),
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final GalleryModal item;

  GridItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return item.featureImage != null
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImagesPage(id: item.id!),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Image part
                      Container(
                        height: 200,
                        color: Colors.green.shade400,
                        child: item.featureImage != null
                            ? Image.network(
                                item.featureImage!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  );
                                },
                              )
                            : Center(
                                child: Icon(Icons.image,
                                    size: 50, color: Colors.white),
                              ),
                      ),

                      // Title part
                      Container(
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.8),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          item.title ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Ui.NoDataWidget();
  }
}
