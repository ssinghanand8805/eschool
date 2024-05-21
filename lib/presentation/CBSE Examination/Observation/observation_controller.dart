import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/myCustomsd.dart';

class ObservationController extends GetxController{

  Rx<TextEditingController> observationC = TextEditingController().obs;
  Rx<TextEditingController> observationDescriptionC = TextEditingController().obs;

  List demo = [
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
    {
      'name':"faheem"
    },
  ];

  Rx<TextEditingController> marksC = TextEditingController().obs;

  double numberCounter = 0.0;

  RxList<TextEditingController> controllers = <TextEditingController>[].obs;
  buildCustomTextFields() {
    List<Widget> textFields = [];
    for (int i = 0; i < controllers.length; i++) {
      textFields.add(
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyCustomSD(
                        listToSearch: demo,
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
                          controller: marksC.value,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            numberCounter = double.tryParse(value) ?? 0.0;
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,left: 8),
                    child: IconButton(
                      icon: Icon(Icons.delete_forever, size: 18),
                      onPressed: () {
                        controllers.removeAt(i);
                      },
                    ),
                  ),
                ],
              ),

            ],
          )
      );
    }
    return Column(children: textFields);
  }

  List<Map<String, dynamic>> data = [
    {
      'studentId': 18001,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Joe Black',
      'approvedId': 9000,
    },
    {
      'studentId': 18002,
      'class': 'Class 4',
      'section': 'A',
      'subjectGroup': 'Class 1st Subject Group',
      'subject': 'Hindi (230)',
      'homeworkDate': DateTime(2024, 4, 5),
      'submissionDate': DateTime(2024, 4, 9),
      'evaluationDate': DateTime(2024, 4, 9),
      'createdBy': 'Kirti Singh',
      'approvedId': 9000,
    },
    // Add more data as needed
  ];

  Rx<TextEditingController> searchC = TextEditingController().obs;

}