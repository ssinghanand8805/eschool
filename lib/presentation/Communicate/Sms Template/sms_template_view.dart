import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Sms%20Template/sms_template_controller.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';

class SmsTemplateView extends GetView<SmsTemplateController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'SMS Template List',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 80,
              prefixIcon: Icon(
                Icons.add,size: 14,
                color: Colors.white,
              ),
              title: 'add',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () async {
                addSmsTemplate(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTextField(
              controller: controller.searchC.value,
              hint: "Search...",
              title: ''),
          SizedBox(height: 20,),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: Get.width*0.2,
              //dataRowHeight: 100,
              columns: const [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Message')),
                DataColumn(label: Text('Action')),
              ],
              rows: controller.data.asMap().entries.map((entry) {
                int index = entry.key;
                return DataRow(
                  cells: [
                    DataCell(Text(entry.value['class'],
                        style: theme.textTheme.bodySmall!)),
                    DataCell(
                        Text("Games that are played on school sports days can be wide and varied. They can include ")),
                    DataCell(
                        Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 15,),
                            Icon(Icons.delete),
                          ],
                        )
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


  addSmsTemplate(context){
    AlertDialogue().show(context, newWidget: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Add Email Template",
          style: theme.textTheme.bodyMedium,
        ),
        CustomTextField(
          controller: controller.titleC.value,
          hint: "Title",
          title: "",
        ),


        SizedBox(
          height: 15,
        ),

        CustomTextField(
          controller: controller.messageC.value,
          hint: "Message",
          title: "",
          maxLine: 3,
        ),



        SizedBox(
          height: 15,
        ),
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
      ])
    ]);
  }
}