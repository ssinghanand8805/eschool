import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/custom_loader.dart';

import 'gallery_controller.dart';

class  GalleryView extends GetView< GalleryController> {
  GalleryView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Gallery',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<GalleryController>(
          init: controller,
          builder: (_) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: CustomTextField(
                            controller: controller.searchC,
                            hint: 'Search.... ', title: '',
                            onChanged: (val) {
                              controller.searchContentType(val);
                              controller.update();
                            },
                          ),

                        ),
                        SizedBox(height: 8),
                        Column(
                          children: controller.filteredContentTypeList.value
                              .data!.map((entry) {
                            return Card(
                              elevation: 1,
                              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Smoother corners
                              ),
                              color: Colors.white,
                              shadowColor: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title: ${"entry.bookType"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('URL: ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                              Icons.edit, size: 15),
                                          onPressed: () {
                                           // addEditContents(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.close, size: 15),
                                          onPressed: () {

                                          },
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )


                      ],
                    ),
                  );
                }
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
         // addEditContents(context);
        },
        tooltip: 'Add Item',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

    );
  }


}