import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
import 'book_list_modal.dart';

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
                  return controller.filteredContentTypeList.value!.data!.listbook != null && controller.filteredContentTypeList.value
                      .data!.listbook!.length > 0 ? SingleChildScrollView(
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
                          children: controller.filteredContentTypeList.value.data!
                              .listbook!.map((entry) {
                            return Card(
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20), // Smoother corners
                                ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                           await  controller.getEditData(entry.id!);
                                            addEditContents(context);
                                          },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.edit, size: 18),
                                            )),
                                        GestureDetector(
                                          onTap: () async {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Confirm Delete'),
                                                  content: Text('Are you sure you want to delete this item?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        // If the user cancels the deletion
                                                        Navigator.of(context).pop(); // Close the dialog
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        // If the user confirms the deletion
                                                        controller.deleteBookDetails(context, int.parse(entry.id!));
                                                        Navigator.of(context).pop(); // Close the dialog
                                                      },
                                                      child: Text('Delete'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                        },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(Icons.delete, size: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Text(entry.bookTitle.toString(),style: theme.textTheme.bodyMedium,)),
                                        SizedBox(width: 5,),
                                       Container(
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5),
                                           color: Colors.green.shade100
                                         ),
                                         child: Padding(
                                           padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                                           child: Text("book Type", style: theme.textTheme.bodySmall,),
                                         ),
                                       )
                                      ],
                                    ),
                                    SizedBox(height: 5,),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(entry.subject.toString(),style: theme.textTheme.bodyMedium)
                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        Row(
                                          children: [
                                            Text('Rack Number: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.rackNo.toString(),style: theme.textTheme.bodySmall)
                                          ],
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5,),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Book Number: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.bookNo.toString(),style: theme.textTheme.bodySmall)
                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        Row(
                                          children: [
                                            Text('ISBN Number: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.isbnNo.toString(),style: theme.textTheme.bodySmall)
                                          ],
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Publisher: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.publish.toString(),style: theme.textTheme.bodySmall)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Author: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.author.toString(),style: theme.textTheme.bodySmall,)
                                          ],
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Qty: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.qty.toString(),style: theme.textTheme.bodySmall,)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Available: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.available.toString(),style: theme.textTheme.bodySmall,)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text('Book Price: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.perunitcost.toString(),style: theme.textTheme.bodySmall,)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Post Date: ',
                                                style: theme.textTheme.bodySmall),
                                            Text(entry.postdate.toString(),style: theme.textTheme.bodySmall,)
                                          ],
                                        )
                                      ],
                                    ),

                                    Text('Description: ${entry.description}',
                                        style: theme.textTheme.bodySmall),

                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )


                      ],
                    ),
                  ) : Text("No Data Found");
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
                listToSearch: controller.filteredContentTypeList.value.data!.listbooktype!.map((item) {
                  return item.toJson();
                }).toList(),
                // controller.commonApiController.classListModelMap.value,
                valFrom: "book_type_name",
                label: 'Book Type',
                labelText: 'Book Type',
                initialValue: [
                  {
                    'parameter': 'id',
                    'value': controller.bookTypeController.text
                  }
                ],
                onChanged: (val) {
                  if (controller.filteredContentTypeList.value.data!.listbooktype!
                      .length >
                      0) {
                    print("5555555555555");

                    controller.bookTypeId.value =
                        val['id'].toString();
                    controller.update();
                    // controller.commonApiController.selectedClassName.value =
                    //     val['className'].toString();
                    // controller.commonApiController.update();
                    // controller.commonApiController.getSectionList();
                  }
                },
              )),
              const SizedBox(height: 16),
          
              // Book Title
              CustomTextField(
                controller: controller.bookTitleController,
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
                    controller.createBook(Get.context);
                  },
                  child: controller.selectedId.value != "" ? const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ):
                  const Text(
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