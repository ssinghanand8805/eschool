import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/common_widgets/InfoRow.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/download_button.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../common_widgets/custom_loader.dart';
import '../book list/book_list_controller.dart';
import 'issueBook_view.dart';
import 'issueReturn_controller.dart';

class  IssueReturnView extends GetView< IssueReturnController> {
  IssueReturnView({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Issue Return',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: GetBuilder<IssueReturnController>(
          init: controller,
          builder: (_) {
            return FutureBuilder(
                future: controller.fetchDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CustomLoader();
                  }
                  return controller.filteredContentTypeList.value
                      .data != null && controller.filteredContentTypeList.value
                      .data!.memberList!.length > 0 ?    SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: CustomTextField(
                            controller: controller.searchC,
                            hint: 'Search.... ', title: '',
                            onChanged: (val) {
                              controller.searchContentType(val);
                              controller.update();
                            },
                          ),

                        ),
                        SizedBox(height: 8),
                        Column(
                          children: controller.filteredContentTypeList.value
                              .data!.memberList!.map((entry) {
                            return Card(
                              elevation: 1, // Higher elevation for a more prominent shadow
                              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Smoother corners
                              ),
                              color: Colors.white,
                              shadowColor: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Member id: ${entry!.libMemberId}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Library Card No.: ${entry.libraryCardNo}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Admission No: ${entry.admissionNo}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Name: ${entry.firstname}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Member Type: ${entry.memberType}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 8),
                                    Text('Phone: ${entry.guardianPhone}',
                                        style: theme.textTheme.bodySmall),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text("Issue Return",style:  theme.textTheme.bodySmall!.copyWith(color: Colors.green),),
                                        IconButton(
                                          icon: Icon(Icons.logout, size: 15,color: Colors.blue,),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => LibraryManagementPage()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )


                      ],
                    ),
                  )
                  : Text("No Data Found")
                  ;
                }
            );
          }
      ),



    );
  }


}