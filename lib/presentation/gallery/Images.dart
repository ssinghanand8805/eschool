import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/theme/theme_controller.dart';

import '../../apiHelper/GlobalData.dart';
import '../../theme/theme_helper.dart';
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
    return GetBuilder(
      init: ThemeController(),
      builder: (context1) {
        return Scaffold(
          appBar: AppBar(


            title: Text(
              "Images",
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),
            ),
            backgroundColor: theme.primaryColor,
          ),
          body: GetBuilder(
              init: GalleryController(),
              builder: (context) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: controller.PageContentsModalObj.length,
                  itemBuilder: (context, index) {
                    return GridItemWidget(
                        item: controller.PageContentsModalObj[index]);
                  },
                );
              }),
        );
      }
    );
  }
}

class GridItemWidget extends StatelessWidget {
  final PageContents item;

  GridItemWidget({required this.item});

  void navigateToImageGallery(BuildContext context, List<String> imageUrls) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGalleryPage(imageUrls: imageUrls),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String baseUrlFromPref = GlobalData().baseUrlValueFromPref;

    final String imageUrl =
        "${baseUrlFromPref}${item.dirPath}/${item.imgName}";

    final List<String> imageUrls = [imageUrl];
    return InkWell(
      onTap: () {
        navigateToImageGallery(context, imageUrls);
      },
      child: Card(
          child: ImagePage(
              imageUrl:
              "${baseUrlFromPref}${item.dirPath}/${item.imgName}")),
    );
  }
}

class ImageGalleryPage extends StatelessWidget {
  final List<String> imageUrls;
  final PageContents? item;

  ImageGalleryPage({required this.imageUrls, this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(item?.imgName ?? ""),
      ),
      body: PageView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Center(
            child: Image.network(
              imageUrls[index],
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
            ),
          );
        },
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  final String imageUrl;

  ImagePage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          imageUrl,
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
        ),
      ),
    );
  }
}
