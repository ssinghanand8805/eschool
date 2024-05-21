import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/CBSE%20Examination/Print%20Marksheet/print_marksheet_controller.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';

class PrintMarksheetView extends GetView<PrintMarksheetController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.green.shade100,
       title: Text(
         'Select Criteria',
         style: theme.textTheme.titleLarge,
       ),
     ),
     body: Padding(
       padding: const EdgeInsets.only(left: 8.0,right: 8),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             children: [
               Expanded(
                 child: MyCustomSD(
                     listToSearch: controller.demo,
                     valFrom: 'name',
                     label: "Class",
                     borderColor: Colors.grey,
                     onChanged: (val){

                     }),
               ),
               SizedBox(width: 10,),
               Expanded(
                 child: MyCustomSD(
                     listToSearch: controller.demo,
                     valFrom: 'name',
                     label: "Section",
                     borderColor: Colors.grey,
                     onChanged: (val){

                     }),
               )
             ],
           ),
           MyCustomSD(
               listToSearch: controller.demo,
               valFrom: 'name',
               label: "Template",
               borderColor: Colors.grey,
               onChanged: (val){

               }),

           SizedBox(height: 20,),
           Text("Student List",style: theme.textTheme.bodyLarge,),

           SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: DataTable(
               columnSpacing: Get.width*0.1,
               // dataRowHeight: 100,
               columns:  [
                 DataColumn(label: Obx(() =>
                     Checkbox(
                       checkColor: Colors.white,
                       //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                       value: controller.isChecked.value,
                       onChanged: (value) {
                         controller.isChecked.value = value!;
                         print(value);
                       },
                     ),)),
                 DataColumn(label: Text('Admission No')),
                 DataColumn(label: Text('Student Name')),
                 DataColumn(label: Text('Father Name')),
                 DataColumn(label: Text('Date of Birth')),
                 DataColumn(label: Text('Mobile No.')),
                 DataColumn(label: Text('Gender')),
                 DataColumn(label: Text('Action')),
               ],
               rows: controller.data.asMap().entries.map((entry) {
                 int index = entry.key;
                 return DataRow(
                   cells: [
                     DataCell(Obx(() =>
                         Checkbox(
                           checkColor: Colors.white,
                           //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                           value: controller.isChecked.value,
                           onChanged: (value) {
                             controller.isChecked.value = value!;
                             print(value);
                           },
                         ),)),
                 DataCell(Text("12345")),
                 DataCell(Text("12345")),
                 DataCell(Text("12345")),
                 DataCell(Text("12345")),
                 DataCell(Text("12345")),
                 DataCell(Text("12345")),
                     DataCell(
                       Row(
                         children: [
                           IconButton(
                             icon: Icon(Icons.download, size: 15),
                             onPressed: () {
                               //editHomework(index);
                             },
                           ),
                           IconButton(
                             icon: Icon(Icons.mail, size: 15),
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
     ),
   );
  }

}