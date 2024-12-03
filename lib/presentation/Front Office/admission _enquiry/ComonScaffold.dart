import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/theme_helper.dart';
import '../../common_widgets/custom_loader.dart';
import 'CustomScaffoldController.dart';

class CustomScaffold extends GetView<CustomScaffoldController> {

  final void Function(BuildContext) filterFunction;
  GetxController parentController;
  String aapBarTitle;
  Widget bodyWidget;

  Widget?floatingActionButton;
  Future<void> futureInitFunction;
   CustomScaffold({Key? key,required this.parentController,this.floatingActionButton,required this.bodyWidget,required this.filterFunction,required this.futureInitFunction,required this.aapBarTitle}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Text(
          aapBarTitle,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          InkWell(
            onTap: () {
              filterFunction(context);
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child:Icon(Icons.filter_alt_outlined)
            ),
          ),
        ],
      ),
      body: GetBuilder(
          init: parentController,
          builder: (_) {
            return FutureBuilder(
                future: futureInitFunction,
                builder: (context,snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  else
                  {

                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                        child: Column(
                          children: [
                            Column(
                              children: [
                        SizedBox(
                         height: controller.getChipDataList.entries
                             .any((entry) => entry.value.value.isNotEmpty)?35:0,
                          child: controller.getChipDataList.entries
                              .any((entry) => entry.value.value.isNotEmpty)
                              ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.getChipDataList.entries
                                .where((entry) => entry.value.value.isNotEmpty)
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              // Filter entries to only include those with non-empty values
                              List<MapEntry<String, RxString>> nonEmptyEntries = controller
                                  .getChipDataList.entries
                                  .where((entry) => entry.value.value.isNotEmpty)
                                  .toList();

                              // Get the entry based on the index
                              String key = nonEmptyEntries[index].key;
                              RxString rxValue = nonEmptyEntries[index].value;

                              // Return the widget for each non-empty entry
                              return Obx(() {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: Colors.green.shade200),
                                    ),
                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("$key: ${rxValue.value}",style: theme.textTheme.titleMedium,),
                                    )),
                                  )
                                  // Chip(
                                  //   label: Text("$key: ${rxValue.value}"),
                                  // ),
                                );
                              });
                            },
                          )
                              : Container(
                          ),
                        ),
                      
                      
                      
                        ],
                            ),
                      
                           bodyWidget
                      
                          ],
                        ),
                      ),
                    );
                  }

                }
            );
          }
      ),
      // floatingActionButton: MyButton(
      //   width: 120,
      //   // prefixIcon: Icon(
      //   //   Icons.add,
      //   //   color: Colors.white,
      //   // ),
      //   title: 'Add enquiry',
      //   textStyle: TextStyle(fontSize: 14, color: Colors.white),
      //   color: theme.hintColor,
      //   onPress: () {
      //     addCategory(context);
      //   },
      // ),
      floatingActionButton: floatingActionButton,
      // floatingActionButtonLocation: ,
    );
  }
}

