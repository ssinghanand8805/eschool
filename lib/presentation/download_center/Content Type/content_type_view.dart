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
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              title:'Add Content',textStyle: TextStyle(color: Colors.white),
              color:theme.hintColor,
              onPress: () {
                addContent(context);
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return FutureBuilder(
            future: controller.fetchDataFuture,
            builder: (context,snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              }
              return controller.filteredContentTypeList.value.data != null && controller.filteredContentTypeList.value.data!.length > 0 ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: CustomTextField(
                      controller: controller.searchC.value,
                      hint: 'Search.... ', title: '',
                      onChanged: (val) {
                        controller.searchContentType(val);
                        controller.update();
                      },
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: Get.width*0.2,
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: controller.filteredContentTypeList.value.data!.asMap().entries.map((entry) {
                        int index = entry.key;
                        return DataRow(
                          cells: [
                            DataCell(Text(entry.value.name!,
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Center(
                              child: Text(entry.value.description!,
                                  style: theme.textTheme.bodySmall!),
                            )),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 15),
                                    onPressed: () {
                                     //editHomework(index);
                                      controller.getcontenttypebyId(context,int.parse(entry.value.id!));
                                      // if(controller.contentTypeId == int.parse(entry.value.id!))
                                      //   {
                                          addContent(context);
                                        // }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, size: 15),
                                    onPressed: () {
                                      print("Delete leave");
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),

                ],
              ):
              Center(child: Text("No Data")) ;
            }
          );
        }
      ),

    );

  }


  addContent(context){
    AlertDialogue().show(context,
      newWidget: [
        Form(
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
      ],
      
    );
  }

}