import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../admission _enquiry/admission_Enquiry_controller.dart';
import 'follow_up_enquiry_controller.dart';

class FollowUpEnquiryView extends GetView<FollowUpEnquiryController>{
  @override
  Widget build(BuildContext context) {
    AdmissionEnquiryController admissionEnquiryController = Get.put(AdmissionEnquiryController());
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
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
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
                                  controller.getFollowUpList.enquiryData != null ? Expanded(child: Text(controller.getFollowUpList.enquiryData!.name.toString(),style: theme.textTheme.bodySmall,)):Container(),
                                ],
                              )
                            ],
                          ),
                        ),

                        Expanded(
                          child: MyCustomSD(
                            labelText: "Status",
                              listToSearch: controller.getFollowUpList.enquiryStatus!.toJson().entries.map((entry) {
                                return {
                                  'id': entry.key,  // The key of the map (e.g., "active")
                                  'name': entry.value  // The value of the map (e.g., "Active")
                                };
                              }).toList(),
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
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.followUpDateC.value,
                    hint: "Follow Up Date",
                    title: "Follow Up Date",
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.followUpDateC.value,
                    hint: "Next Follow Up Date",
                    title: "Next Follow Up Date",
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.followUpDateC.value,
                    hint: "Response",
                    title: "Response",
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.followUpDateC.value,
                    hint: "Note...",
                    title: "Note",
                  ),
                )
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


            Align(
              alignment: Alignment.topLeft,
                child: Text("Follow Up (Jack)",style: theme.textTheme.bodyMedium,)),
            SizedBox(height: 10,),

            timeLine()

            

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


  Widget timeLine() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return new Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 15, bottom: 15),
              child: Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(
                          0.3,
                          3.0,
                        ),
                        blurRadius: 4.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text(
                          "pickupPoint",
                          style:  theme.textTheme.titleMedium!.copyWith(fontSize: 18,fontWeight: FontWeight.w600)
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.location_on,),
                        SizedBox(width: 8.0),
                        Text("Distance(km)"),
                        SizedBox(width: 8.0),
                        Text("destinationDistance",style:  theme.textTheme.titleMedium!,),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 8.0),
                        Text("Pickup Time"),
                        SizedBox(width: 8.0),
                        Text("pickupTime",style:  theme.textTheme.titleMedium!,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            new Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 18.0,
              child: new Container(
                height: double.infinity,
                width: 5.0,
                color: Colors.green.shade100,
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              child: new Container(
                height: 25.0,
                width: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade200,
                ),
                child: new Container(
                  child: Icon(Icons.location_on, size: 15),
                  margin: new EdgeInsets.all(5.0),
                  height: 15.0,
                  width: 30.0,
                ),
              ),
            )
          ],
        );
      },

    );
  }

}