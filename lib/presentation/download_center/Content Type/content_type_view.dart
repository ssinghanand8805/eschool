import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../common_widgets/custom_loader.dart';
import 'content_type_controller.dart';

class ContentTypeView extends GetView<ContentTypeController> {
  ContentTypeView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Content Type List',
          style: theme.textTheme.bodyMedium,
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            CustomTextField(
              controller: controller.searchC.value,
              hint: 'Search.... ',
              title: '',
            ),
            SizedBox(height: 16.0),

            // Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Name",
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Description",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Action",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),

            // Data List Section
            Expanded(
              child: GetBuilder<ContentTypeController>(
                builder: (controller) {
                  if (controller.filteredContentTypeList.value.data == null ||
                      controller.filteredContentTypeList.value.data!.isEmpty) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount:
                    controller.filteredContentTypeList.value.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final data =
                      controller.filteredContentTypeList.value.data![index];

                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Name
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data.name ?? "",
                                  style: theme.textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              // Description
                              Expanded(
                                flex: 2,
                                child: Text(
                                  data.description ?? "",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              // Actions
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.green),
                                      onPressed: () {
                                        controller.getcontenttypebyId(
                                            context, int.parse(data.id!));
                                        addContent(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Delete"),
                                              content: Text(
                                                  "Are you sure you want to delete this item?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    controller.deletecontenttypebyId(
                                                        context,
                                                        int.parse(data.id!));
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Delete",
                                                    style:
                                                    TextStyle(color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.nameC.clear();
          controller.descriptionC.clear();
          addContent(context);
        },
        tooltip: 'Add Item',
        shape: CircleBorder(),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

    );

  }


  addContent(context){
    showCustomBottomSheet(context:context,
      child: Form(
          key: controller.formKey.value,
          child: Column(
            children: [
              Text("Add Content Type",style: theme.textTheme.bodyMedium,),
             CustomTextField(
                 controller: controller.nameC,
                 hint: "Name....",
                 title: "Name",
                 validator: (value) {
                   if (value!.isEmpty) {
                     return 'Name cannot be empty';
                   }
                   return null;
                 }
             ),
              SizedBox(height: 20,),

              CustomTextField(
                  controller: controller.descriptionC,
                  hint: "Description....",
                  title: "Description",

              ),

              SizedBox(height: 20,),

              Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 120,
                  title:'Save',textStyle: TextStyle(color: Colors.black,),
                  color:Colors.green.shade100,
                  onPress: () {
                    if(controller.formKey.value.currentState!.validate()){
                      controller.saveContentType(context);

                    }
                  },
                ),
              ),

            ],
          ),
        )
    );


  }

}