
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/button.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import 'observation_controller.dart';

class ObservationView extends GetView<ObservationController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Observation List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addObservation(context);
              },
            ),
          ),
        ],
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Column(
              children: [
                CustomTextField(
                  controller: controller.searchC.value,
                  hint: "Search...",
                  title: "",
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: Get.width*0.15,
                    // dataRowHeight: 100,
                    columns: const [
                      DataColumn(label: Text('Observation')),
                      DataColumn(label: Text('Parameter Description')),
                      DataColumn(label: Text('Parameter')),
                      DataColumn(label: Text('Maximum Mark')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows: controller.data.asMap().entries.map((entry) {
                      int index = entry.key;
                      return DataRow(
                        cells: [
                          DataCell(Text(entry.value['class'],
                              style: theme.textTheme.bodySmall!)),
                          DataCell(Text("erform certain behaviours or activities without telling them what methods or behaviours to choose.")),
                          DataCell(Text("A")),
                          DataCell(Text("A")),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, size: 15),
                                  onPressed: () {
                                    //editHomework(index);
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
            ),
          );
        }
      ),
    );
  }

  addObservation(context){
    AlertDialogue().show(context,
        newWidget: [
          GetBuilder(
            init: controller,
            builder: (_) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              Text(
                "Add Observation",
                style: theme.textTheme.bodyMedium,
              ),
              CustomTextField(
                controller: controller.observationC.value,
                hint: "Observation",
                title: "",
              ),
              CustomTextField(
                controller: controller.observationDescriptionC.value,
                hint: "Observation Description",
                title: "",
              ),


              SizedBox(height: 10,),
                    Button(
                      icon: Icons.add,
                      onTap: () {
                        controller.controllers.add(TextEditingController());
                      },
                      text: 'Add More',
                    ),

              Row(
                children: [
                  Expanded(
                    child: MyCustomSD(
                        listToSearch: controller.demo,
                        valFrom: 'name',
                        label: "Parameter",
                        borderColor: Colors.grey,
                        onChanged: (val){

                        }),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          border: Border.all()
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Max Marks",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none, // Make border invisible
                                borderRadius: BorderRadius.circular(8.0), // Optional: Add border radius
                              ),
                              contentPadding: EdgeInsets.only(bottom: 5,left: 10)
                          ),
                          controller: controller.marksC.value,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            controller.numberCounter = double.tryParse(value) ?? 0.0;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              controller.buildCustomTextFields(),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 120,
                  title: 'Save',
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  color: Colors.green.shade100,
                  onPress: () {},
                ),
              ),
                      ]);
            }
          )
        ]);
  }

}