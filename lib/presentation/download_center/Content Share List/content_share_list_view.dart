import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/custom_loader.dart';
import 'content_share_list_controller.dart';

class ContentShareView extends GetView<ContentShareController> {
  ContentShareView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Content Share List',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body:  GetBuilder<ContentShareController>(
          init: controller,
        builder: (_) {
          return FutureBuilder(
            future:controller.fetchDataFuture ,
            builder: (context,snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader();
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: CustomTextField(
                      controller: controller.searchC,
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
                      columnSpacing: Get.width*0.1,
                      columns: const [
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Send To')),
                        DataColumn(label: Text('Share Date')),
                        DataColumn(label: Text('valid Upto')),
                        DataColumn(label: Text('Shared By')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Action')),
                      ],
                      rows: controller.filteredContentTypeList.value.data!.asMap().entries.map((entry) {
                        int index = entry.key;
                        return DataRow(
                          cells: [
                            DataCell(Text(entry.value.title!,
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Text(entry.value.sendTo!,
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Text(entry.value.shareDate!,
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Text(entry.value.validUpto ?? "-",
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Text(
                                '${entry.value.name!}',
                                style: theme.textTheme.bodySmall!)),
                            DataCell(Text(
                                '${entry.value.description!}',
                                style: theme.textTheme.bodySmall!)),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_red_eye, size: 15),
                                    onPressed: () {
                                      showShareContents(context);
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
              );
            }
          );
        }
      )

    );
  }

  showShareContents(context){
    showCustomBottomSheet(context:context,
      child:Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shared Content",style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            Padding(
              padding: const EdgeInsets.only(top: 3.0,bottom: 3),
              child: Container(
                height: 2,width: Get.width,
                color: Colors.grey,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
                child: Text("Fees Structure",style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),)),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: InfoRow(title: "Upload Date: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14) ,
                    value: "04/05/2024")),
                SizedBox(width: 10,),
                Expanded(child: InfoRow(title: "Valid Upto: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    value: "04/05/2024")),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: InfoRow(title: "Share Date: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    value: "04/05/2024")),
                SizedBox(width: 10,),
                Expanded(child: InfoRow(title: "Shared By: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    value: "Mohd Faheem")),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: InfoRow(title: "Send To: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    value: "Group")),
                SizedBox(width: 10,),
                Expanded(child: InfoRow(title: "Description: ",
                    style:TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                    value: "04/05/2024")),
              ],
            ),
            SizedBox(height: 8,),

            Row(
              children: [
                Text("Attachments: ",style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),),
                SizedBox(width: 20),
                customDownloadButton(
                    onPressed: () {
                      downloadFileFromAPI("${"baseUrlFromPref" + "data[index].dirPath! "+" data[index].imgName!"}",
                          "fileName"!);
                    })
              ],
            ),



          ],
        )


    );
  }


}