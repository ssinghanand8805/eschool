
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Login%20Credentials%20Send/login_credentials_send_controller.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';

class LoginCredentialsSendView extends GetView<LoginCredentialsSendController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Select Criteria',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 8.0,right: 8),
        child: Column(
          children: [
            MyCustomSD(
                listToSearch: [
                  {"name": "Faheem"},{"name": "Amritash"},{"name": "Anand"}],
                valFrom: "name",
                label: "Select Class",
                borderColor: Colors.grey,
                onChanged: (val){

                }),
            MyCustomSD(
                listToSearch: [
                  {"name": "Faheem"},{"name": "Amritash"},{"name": "Anand"}],
                valFrom: "name",
                label: "Select Section",
                borderColor: Colors.grey,
                onChanged: (val){

                }),
        SizedBox(height: 10,),

        Align(
          alignment: Alignment.centerRight,
          child: MyButton(
                  width: 100,
                  title: 'Search',
                  prefixIcon: Icon(Icons.search,color: Colors.white,size: 16,),
                  textStyle: TextStyle(fontSize: 14, color: Colors.white),
                  color: theme.hintColor,
                  onPress: () async {
                   // await Get.toNamed(AppRoutes.new_messageRoute);
                  },
                ),
        ),

            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                      listToSearch: [
                        {"name": "Faheem"},{"name": "Amritash"},{"name": "Anand"}],
                      valFrom: "name",
                      label: "Message To",
                      borderColor: Colors.grey,
                      onChanged: (val){

                      }),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: MyCustomSD(
                      listToSearch: [
                        {"name": "Faheem"},{"name": "Amritash"},{"name": "Anand"}],
                      valFrom: "name",
                      label: "Notification Type",
                      borderColor: Colors.grey,
                      onChanged: (val){

                      }),
                ),
              ],
            ),

            CustomTextField(
                controller: controller.searchC.value,
                hint: 'Search...',
                title: ""),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: Get.width * 0.2,
                // dataRowHeight: 100,
                columns: [
                  DataColumn(label: Obx((){
                    return Checkbox(
                      value: controller.isMarked.value,
                      onChanged: (value) {
                        controller.isMarked.value = value!;
                        print(value);
                      },);
                  })),
                  DataColumn(label: Text('Admission No')),
                  DataColumn(label: Text('Student Name')),
                  DataColumn(label: Text('Class')),
                  DataColumn(label: Text('Date of birth')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Mobile')),
                ],
                rows: controller.data.asMap().entries.map((entry) {
                  int index = entry.key;
                  return DataRow(
                    cells: [
                      DataCell(Obx(() => Checkbox(
                    checkColor: Colors.white,
                    //fillColor: MaterialStateProperty.resolveWith(Colors.red),
                    value: controller.isMarked.value,
                    onChanged: (value) {
                      controller.isMarked.value = value!;
                      print(value);
                    },
                  ),),),
                      DataCell(Text("Admission No")),
                      DataCell(Text("Mohd Faheem")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("A")),
                      DataCell(Text("993680856")),
                    ],
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 20,),

            Align(
              alignment: Alignment.centerRight,
              child: MyButton(
                width: 80,
                title: 'Send',
                textStyle: TextStyle(fontSize: 14, color: Colors.white),
                color: theme.hintColor,
                onPress: () async {
                  // await Get.toNamed(AppRoutes.new_messageRoute);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}