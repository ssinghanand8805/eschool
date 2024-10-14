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
    print("5555555 "+controller.getChipDataList.length.toString());
    print("5555555 "+controller.getChipDataList[0].toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          aapBarTitle,
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          InkWell(
            onTap: () {
              filterFunction(context);
            },
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
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

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  // Sort the keys based on whether their corresponding values are empty or not
                                  itemCount: controller.getChipDataList.keys.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    // Get all entries from the map and split them based on whether their values are non-empty
                                    List<MapEntry<String, RxString>> sortedEntries = [
                                      ...controller.getChipDataList.entries.where((entry) => entry.value.value.isNotEmpty), // Non-empty first
                                      ...controller.getChipDataList.entries.where((entry) => entry.value.value.isEmpty),    // Empty after
                                    ];

                                    // Get the entry based on the index
                                    String key = sortedEntries[index].key;
                                    RxString rxValue = sortedEntries[index].value;

                                    // Return the widget for each entry
                                    return Obx(() {
                                      return Chip(
                                        label: Text("$key: ${rxValue.value}"),
                                      );
                                    });
                                  },
                                )
                                ,


                              ),


                            ],
                          ),

                         bodyWidget

                        ],
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

