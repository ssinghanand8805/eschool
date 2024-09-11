import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import 'admission_Enquiry_controller.dart';
import 'enquiry_data_modal.dart';

class AdmissionEnquiryView extends GetView<AdmissionEnquiryController>{
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              // prefixIcon: Icon(
              //   Icons.add,
              //   color: Colors.white,
              // ),
              title: 'Add enquiry',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                addCategory(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MyCustomSD(

                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.getAdmissionEnquiryList.classList!.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "class",
                    label: 'Class',
                    labelText: 'Class',
                    onChanged: (val) {
                      // if(controller.commonApiController.classListModelMap.value.length > 0)
                      // {
                      //   print("5555555555555");
                      //
                      //   controller.commonApiController.selectedClassId.value = val['id'].toString();
                      //   controller.commonApiController.selectedClassName.value = val['className'].toString();
                      //   controller.commonApiController.update();
                      //   controller.commonApiController.getSectionList();
                      // }

                    },
                  )
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch:controller.getAdmissionEnquiryList.sourcelist!.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "source",
                    label: 'Source',
                    labelText: 'Source',
                    onChanged: (val) {
                      print(val);
                      // if(controller.commonApiController.sectionListModelMap.value.length > 0)
                      // {
                      //
                      //
                      //   controller.commonApiController.selectedSectionId.value = val['id'].toString();
                      //   controller.commonApiController.selectedSectionName.value = val['section'].toString();
                      //
                      //   controller.commonApiController.update();
                      //
                      // }

                    },
                  )
                ),
              ],
            ),
            SizedBox(height: 10,),

            Row(
              children: [
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.fromDateC.value,
                    title: 'Follow Up Date',
                    onDateSelected: (date) {
                      controller.fromDateC.value.text =
                          DateFormat('dd/MM/yyyy').format(date);
                    },),
                ),

                SizedBox(width: 10,),
                Expanded(
                  child: DatePickerTextField(
                      controller: controller.toDateC.value,
                      title: 'Next Follow Up Date',
                      onDateSelected: (date) {
                        controller.toDateC.value.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }),
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //         child:
            //         MyCustomSD(
            //
            //           hideSearch: true,
            //           borderColor: Colors.grey,
            //           listToSearch: controller.demo,
            //           valFrom: "name",
            //           label: 'Enquiry From Date ',
            //           labelText: 'Enquiry From Date ',
            //           onChanged: (val) {
            //             // if(controller.commonApiController.classListModelMap.value.length > 0)
            //             // {
            //             //   print("5555555555555");
            //             //
            //             //   controller.commonApiController.selectedClassId.value = val['id'].toString();
            //             //   controller.commonApiController.selectedClassName.value = val['className'].toString();
            //             //   controller.commonApiController.update();
            //             //   controller.commonApiController.getSectionList();
            //             // }
            //
            //           },
            //         )
            //     ),
            //
            //     SizedBox(width: 10,),
            //
            //     Expanded(
            //         child:
            //         MyCustomSD(
            //           hideSearch: true,
            //           borderColor: Colors.grey,
            //           listToSearch:controller.demo,
            //           valFrom: "name",
            //           label: 'Enquiry To Date',
            //           labelText: 'Enquiry To Date',
            //           onChanged: (val) {
            //             print(val);
            //             // if(controller.commonApiController.sectionListModelMap.value.length > 0)
            //             // {
            //             //
            //             //
            //             //   controller.commonApiController.selectedSectionId.value = val['id'].toString();
            //             //   controller.commonApiController.selectedSectionName.value = val['section'].toString();
            //             //
            //             //   controller.commonApiController.update();
            //             //
            //             // }
            //
            //           },
            //         )
            //     ),
            //   ],
            // ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch:controller.getAdmissionEnquiryList.enquiryStatus!.toJson().entries.map((entry) {
                    return {
                    'id': entry.key,  // The key of the map (e.g., "active")
                    'name': entry.value  // The value of the map (e.g., "Active")
                    };
                    }).toList(),
                    valFrom: "name",
                    label: 'Status',
                    labelText: 'Status',
                    onChanged: (val) {
                      // if(controller.commonApiController.classListModelMap.value.length > 0)
                      // {
                      //   print("5555555555555");
                      //
                      //   controller.commonApiController.selectedClassId.value = val['id'].toString();
                      //   controller.commonApiController.selectedClassName.value = val['className'].toString();
                      //   controller.commonApiController.update();
                      //   controller.commonApiController.getSectionList();
                      // }

                    },
                  ),
                ),
                SizedBox(width: 20,),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MyButton(
                    width: 100,
                    prefixIcon: Icon(Icons.search,size: 18,),
                    title: 'Search',
                    textStyle: TextStyle(
                      color: Colors.black,
                    ),
                    color: Colors.green.shade100,
                    onPress: () {
                      //controller.studentByClassSection();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
                child: Text("Admission Enquiry",style: theme.textTheme.titleLarge)),

            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                 // EnquiryList enData = controller.getAdmissionEnquiryList.enquiryList![index];

                  return  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(
                     width: Get.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade500)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5,
                                    offset: Offset(1, 4), // Shadow position
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                    child: Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(5.0)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: 25,
                                                  width: 25,
                                                  child: Icon(Icons.person)),
                                              const SizedBox(width: 5),
                                              Expanded(
                                                  child: Text("firstname",
                                                    style: theme.textTheme.bodySmall,)),

                                              Row(
                                                children: [
                                                  Icon(Icons.edit),
                                                  SizedBox(width: 5,),
                                                  Icon(Icons.delete),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Source: ",
                                                    style: theme.textTheme.bodySmall,),
                                                  Text(
                                                    "Front office",
                                                    style: theme.textTheme.bodySmall,),
                                                ],
                                              ),
                                              SizedBox(width: 5,),

                                              Row(

                                                children: [
                                                  Text(
                                                    "Enquiry Date.: ",
                                                    style: theme.textTheme.bodySmall,),
                                                  Text(
                                                    "02/02/2024",
                                                    style: theme.textTheme.bodySmall,),
                                                ],
                                              ),


                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Last Follow Up Date: ",
                                                            style: theme.textTheme.bodySmall,),
                                                        ),
                                                        Text(
                                                          "04/02/2024",
                                                          style: theme.textTheme.bodySmall,),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),

                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Next Follow Up Date: ",
                                                            style: theme.textTheme.bodySmall,),
                                                        ),
                                                        Text("09/22/2024",
                                                          style: theme.textTheme.bodySmall,),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              SizedBox(height: 8,),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(

                                                    children: [
                                                      Text(
                                                        "	Status: ",
                                                        style: theme.textTheme.bodySmall,),
                                                      Text("Active",
                                                        style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [
                                                      Text("Phone No.: ",style: theme.textTheme.bodySmall,),
                                                      Text("8577850281",style: theme.textTheme.bodySmall,),
                                                    ],
                                                  ),



                                                ],
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  );
                },),
            )

          ],
        ),
      ),
    );
  }




  addCategory(context) {
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
                  child: CustomTextField(
                    controller: controller.nameC.value,
                    hint: "Name",
                    title: "",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.phoneC.value,
                    hint: "Phone",
                    title: "",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),


            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.emailC.value,
                    hint: "Email",
                    title: "",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.addressC.value,
                    hint: "Address",
                    title: "",
                  ),
                ),
              ],
            ),


            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.descriptionC.value,
                    hint: "Description",
                    title: "",
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    controller: controller.noteC.value,
                    hint: "Note",
                    title: "",
                  ),
                ),
              ],
            ),


            Row(
              children: [
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.dateC.value,
                    title: '',
                      onDateSelected: (date) {
                        controller.dateC.value.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      },),
                ),

                SizedBox(width: 10,),
                Expanded(
                  child: DatePickerTextField(
                    controller: controller.nextFollowUpDateC.value,
                    title: '',
                      onDateSelected: (date) {
                        controller.nextFollowUpDateC.value.text =
                            DateFormat('dd/MM/yyyy').format(date);
                      }),
                ),
              ],
            ),
            SizedBox(height: 10,),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child:
                MyCustomSD(
                  hideSearch: true,
                  labelText: '',
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: "name",
                   label: 'Assigned',
                  onChanged: (val) {

                  },
                ),),
                SizedBox(
                  width: 5,
                ),
                Expanded(child: MyCustomSD(
                  labelText: '',
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: "name",
                   label: 'Reference',
                  onChanged: (val) {
                    if (val != null) {

                    }
                  },
                ),)
              ],
            ),

            SizedBox(height: 10,),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child:
                MyCustomSD(
                  hideSearch: true,
                  labelText: '',
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: "name",
                   label: 'Source',
                  onChanged: (val) {

                  },
                ),),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: MyCustomSD(
                  labelText: '',
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch: controller.demo,
                  valFrom: "name",
                  label: 'Class',
                  onChanged: (val) {
                    if (val != null) {

                    }
                  },
                ),)
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