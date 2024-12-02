import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import 'package:lottie/lottie.dart';
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
  BookListView({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          'Book List',
          style: theme.textTheme.bodyMedium,
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
                  return controller.filteredContentTypeList.value!.data!
                                  .listbook !=
                              null &&
                          controller.filteredContentTypeList.value.data!
                                  .listbook!.length >
                              0
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: CustomTextField(
                                controller: controller.searchC,
                                hint: 'Search.... ',
                                title: '',
                                onChanged: (val) {
                                  controller.searchContentType(val);
                                  controller.update();
                                },
                              ),
                            ),
                            SizedBox(height: 8),
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.filteredContentTypeList
                                    .value.data!.listbook!.length,
                                itemBuilder: (context, index) {
                                  return BookListingCard(
                                    entry: controller.filteredContentTypeList
                                        .value.data!.listbook![index],
                                    onEdit: () async {
                                      await controller.getEditData(int.parse(
                                          controller
                                              .filteredContentTypeList
                                              .value
                                              .data!
                                              .listbook![index]
                                              .id!));
                                      addEditContents(context);
                                    },
                                    onDelete: () {
                                      controller.deleteBookDetails(
                                        context,
                                        int.parse(controller
                                            .filteredContentTypeList
                                            .value
                                            .data!
                                            .listbook![index]
                                            .id!),
                                      );
                                      Navigator.of(context);
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(
                          child:
                              Lottie.asset("assets/images/no_data_found.json"),
                        );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addEditContents(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }

  void addEditContents(BuildContext context) {
    showCustomBottomSheet(
      context: context,
      child: Container(
        height: Get.height - 150,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => controller.commonApiController.isClassLoading.value
                  ? Material(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Class"),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : MyCustomSD(
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .filteredContentTypeList.value.data!.listbooktype!
                          .map((item) {
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
                        if (controller.filteredContentTypeList.value.data!
                                .listbooktype!.length >
                            0) {
                          print("5555555555555");

                          controller.bookTypeId.value = val['id'].toString();
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
                  child: controller.selectedId.value != ""
                      ? const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
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

class BookListingCard extends StatelessWidget {
  final dynamic entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookListingCard(
      {Key? key,
      required this.entry,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Header
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade500, Colors.green.shade600],
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        entry.bookTitle.toString().capitalizeFirst!,
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Text(
                        entry.subject.toString(),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Book Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                icon: Icons.book_outlined,
                                label: 'ISBN',
                                value: entry.isbnNo.toString(),
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                icon: Icons.person_outline,
                                label: 'Author',
                                value: entry.author.toString(),
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                icon: Icons.print_outlined,
                                label: 'Publisher',
                                value: entry.publish.toString(),
                              ),
                            ],
                          ),
                        ),

                        // Right Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              _buildDetailRow(
                                icon: Icons.location_on_outlined,
                                label: 'Rack',
                                value: entry.rackNo.toString(),
                                isRightAligned: true,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                icon: Icons.storage_outlined,
                                label: 'Quantity',
                                value: entry.qty.toString(),
                                isRightAligned: true,
                              ),
                              const SizedBox(height: 8),
                              _buildDetailRow(
                                icon: Icons.check_circle_outline,
                                label: 'Available',
                                value: entry.available.toString(),
                                isRightAligned: true,
                                valueColor: Colors.green.shade700,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Description
                    const SizedBox(height: 16),
                    Text(
                      'Description: ${entry.description}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Container(
                color: Colors.grey.shade100,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Added on: ${entry.postdate}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      children: [
                        _buildActionButton(
                          icon: Icons.edit,
                          color: Colors.blue,
                          onPressed: onEdit,
                        ),
                        const SizedBox(width: 8),
                        _buildActionButton(
                          icon: Icons.delete,
                          color: Colors.red,
                          onPressed: onDelete,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isRightAligned = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment:
          isRightAligned ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: isRightAligned
          ? [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: valueColor ?? Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                color: Colors.grey.shade600,
                size: 20,
              ),
            ]
          : [
              Icon(
                icon,
                color: Colors.grey.shade600,
                size: 20,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    value,
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: valueColor ?? Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
    );
  }

  // Reusable action button
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        iconSize: 20,
        //padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
