import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';
import '../issue return/issueReturn_controller.dart';
import 'book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  BookListView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Book List',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<BookListController>(
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
                                elevation: 1, // Higher elevation for a more prominent shadow
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
                                    Text('Book Type: ${"entry.bookType"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Book Title: ${"entry.bookTitle"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Description: ${entry.description}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Book Number: ${"entry.bookNumbe"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('ISBN Number: ${"entry.isbnNumber"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Publisher: ${"entry.publisher"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Author: ${"entry.author"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Subject: ${"entry.subject"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Rack Number: ${"entry.rackNumber"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Qty: ${"entry.qty"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Available: ${"entry.available"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Book Price: ${"entry.bookPrice"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Post Date: ${"entry.postDate"}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                              Icons.edit, size: 15),
                                          onPressed: () {
                                            addEditContents(context);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete, size: 15),
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
          addEditContents(context);
        },
        tooltip: 'Add Item',
        shape:CircleBorder() ,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),


    );
  }


  void addEditContents(BuildContext context) {
    showCustomBottomSheet(context: context,
      child: Container(
        height: Get.height-150,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => controller.commonApiController.isClassLoading.value ?  Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  children: [
                    Text("Class"),
                    CircularProgressIndicator(),
                  ],
                ),
              ) : MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:
                controller.commonApiController.classListModelMap.value,
                valFrom: "className",
                label: 'Class',
                labelText: 'Class',
                initialValue: [
                  {
                    'parameter': 'id',
                    'value': controller.commonApiController.selectedClassId!
                  }
                ],
                onChanged: (val) {
                  if (controller.commonApiController.classListModelMap.value
                      .length >
                      0) {
                    print("5555555555555");

                    controller.commonApiController.selectedClassId.value =
                        val['id'].toString();
                    controller.commonApiController.selectedClassName.value =
                        val['className'].toString();
                    controller.commonApiController.update();
                    controller.commonApiController.getSectionList();
                  }
                },
              )),
              const SizedBox(height: 16),
          
              // Book Title
              CustomTextField(
                controller: controller.bookTypeController,
                hint: 'Book Title',
                title: 'Book Title',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.bookNumberController,
                hint: 'Book Number',
                title: 'Book Number',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.isbnNumberController,
                hint: 'ISBN Number',
                title: 'ISBN Number',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.publisherController,
                hint: 'Publisher',
                title: 'Publisher',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.authorController,
                hint: 'Author',
                title: 'Author',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.subjectController,
                hint: 'Subject',
                title: 'Subject',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.rackNumberController,
                hint: 'Rack Number',
                title: 'Rack Number',
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.quantityController,
                hint: 'Qty',
                title: 'Quantity',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.bookPriceController,
                hint: 'Book Price (\$)',
                title: 'Book Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              DatePickerTextField(
                  controller: controller.postDate.value,
                  title: 'Post date',
                  onDateSelected: (date) async {
                    controller.postDate.value.text =
                    await GlobalData().ConvertToSchoolDateTimeFormat(date);
                  }),
              const SizedBox(height: 16),
          
              CustomTextField(
                controller: controller.descriptionController,
                hint: 'Description',
                title: 'Description',
          
              ),
              const SizedBox(height: 24),
          
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Implement save functionality
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }


}