import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import 'follow_up_enquiry_controller.dart';

class FollowUpEnquiryView extends GetView<FollowUpEnquiryController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Follow Up Admission Enquiry',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              // prefixIcon: Icon(
              //   Icons.add,
              //   color: Colors.white,
              // ),
              title: 'Add follow up',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addFollowUp(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Summary",style: theme.textTheme.bodyMedium,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Assigned: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                  Expanded(child: Text(" James Deckar (9004)",style: theme.textTheme.bodySmall,)),
                                ],
                              )
                            ],
                          ),
                        ),

                        Expanded(
                          child: MyCustomSD(
                            labelText: "Status",
                              listToSearch: controller.demo,
                              valFrom: 'name',
                              onChanged: (val){
                          
                              }),
                        )

                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Enquiry Date: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("10/10/2024",style: theme.textTheme.bodySmall)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text("Last Follow Up Date: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("10/10/2024",style: theme.textTheme.bodySmall)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Next Follow Up Date: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("10/10/2024",style: theme.textTheme.bodySmall)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text("Phone: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("858587857",style: theme.textTheme.bodySmall)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Reference: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("Partner School",style: theme.textTheme.bodySmall)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Text("Source: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                            Text("Front Office",style: theme.textTheme.bodySmall)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Email: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text("demo@gmail.com",style: theme.textTheme.bodySmall)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Text("Address: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text("Front Office Address",style: theme.textTheme.bodySmall)
                              ],
                            )
                          ],
                        ),
                    SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Number Of Child: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text("5",style: theme.textTheme.bodySmall)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Text("Description: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text("Description Address",style: theme.textTheme.bodySmall)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 5,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Note: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text("Note Address",style: theme.textTheme.bodySmall)
                              ],
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Text("Created By: ",style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey),),
                                Text(" Joe Black (9000)",style: theme.textTheme.bodySmall)
                              ],
                            )
                          ],
                        ),
                    SizedBox(height: 10,),


                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  addFollowUp(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Admission Enquiry",
              style: theme.textTheme.bodyMedium,
            ),
            Row(
              children: [
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.followUpDateC.value,
                    title: 'Follow Up Date',
                    onDateSelected: (date) {
                      controller.followUpDateC.value.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    },),
                ),

                SizedBox(width: 10,),
                Expanded(
                  child: DatePickerTextField(
                      controller: controller.nextFollowUpDateC.value,
                      title: 'Next Follow Up Date',
                      onDateSelected: (date) {
                        controller.nextFollowUpDateC.value.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                        controller: controller.responseC.value,
                        hint: 'Response',
                        title: 'Response')),
                SizedBox(width: 10,),
                Expanded(
                    child:CustomTextField(
                    controller: controller.noteC.value,
                    hint: 'Response',
                    title: 'Note'))
              ],
            ),
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
          ],
        )
      ],
    );
  }

}