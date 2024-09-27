import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import '../../../apiHelper/GlobalData.dart';
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
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children: [
                Column(
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
                                if(val!=null){
                                  print(val);
                                  controller.classId.value = val['id'];
                                  print(controller.classId.value.toString());
                                }

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
                                if(val!=null){
                                  controller.sourceId.value = val['id'];
                                  print(controller.sourceId.value.toString());
                                }

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
                            onDateSelected: (date) async {
                              controller.fromDateC.value.text =
                                  await GlobalData().ConvertToSchoolDateTimeFormat(date);
                            },),
                        ),

                        SizedBox(width: 10,),
                        Expanded(
                          child: DatePickerTextField(
                              controller: controller.toDateC.value,
                              title: 'Next Follow Up Date',
                              onDateSelected: (date) async {
                                controller.toDateC.value.text =
                                    await GlobalData().ConvertToSchoolDateTimeFormat(date);

                              }),
                        ),
                      ],
                    ),
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
                              controller.enquiry();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Admission Enquiry",style: theme.textTheme.titleLarge)),
                  ],
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.getAdmissionEnquiryList.enquiryList!.length,
                    itemBuilder: (context, index) {
                      EnquiryList enqData = controller.getAdmissionEnquiryList.enquiryList![index];

                      return  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: controller.getAdmissionEnquiryList.enquiryList!.isEmpty?Text("No data found!"):
                        Container(
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
                                                      child: Text(enqData.name.toString(),
                                                        style: theme.textTheme.bodySmall,)),

                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          Get.toNamed(AppRoutes.follow_up_enquiry);
                                                        },
                                                          child: Icon(Icons.phone)),
                                                      SizedBox(width: 10,),
                                                      Icon(Icons.edit),
                                                      SizedBox(width: 10,),
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
                                                        enqData.source.toString(),
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
                                                        enqData.date.toString(),
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
                                                              enqData.followUpDate.toString(),
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
                                                            Text(enqData.nextDate.toString(),
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
                                                          Text(enqData.contact.toString(),style: theme.textTheme.bodySmall,),
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
          );
        }
      ),
    );
  }




  addCategory(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Form(
          key: controller.addEnquiryFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Admission Enquiry",
                style: theme.textTheme.bodyMedium,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.nameC.value,
                      hint: "Name",
                      title: "Name:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Name is required!';
                          }
                          return null;
                        }
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: MyCustomSD(
                      labelText: 'Class',
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller.getAdmissionEnquiryList.classList!.map((item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: "class",
                      label: 'Class',
                      onChanged: (val) {
                        if (val != null) {
                          controller.classId.value = val['id'];
                        }
                      },
                    ),)



                ],
              ),


              Row(
                children: [
                  Expanded(
                    child: DatePickerTextField(
                      controller: controller.dobC.value,
                      title: 'DOB',
                      onDateSelected: (date) async {
                        controller.dobC.value.text =
                        await GlobalData().ConvertToSchoolDateTimeFormat(date);
                      },),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextField(
                        controller: controller.lastSchoolC.value,
                        hint: "Enter Last School",
                        title: "Last School:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Name is required!';
                          }
                          return null;
                        }
                    ),
                  ),

                ],
              ),

              Row(
                children: [

                  Expanded(
                    child: CustomTextField(
                        controller: controller.lastClassC.value,
                        hint: "Enter Last Class",
                        title: "Last Class:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Name is required!';
                          }
                          return null;
                        }
                    ),
                  ),

                  SizedBox(width: 10,),
                  Expanded(
                    child: CustomTextField(
                        controller: controller.mother_fatherC.value,
                        hint: "Enter Father/Mother Name",
                        title: "Father/Mother Name:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Name is required!';
                          }
                          return null;
                        }
                    ),
                  )

                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.phoneC.value,
                      hint: "Phone",
                      title: "Phone:",
                      keyboardType: TextInputType.number,
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return 'Phone no is required!';
                        }

                        if (textValue.length != 10) {
                          return 'Phone no must be exactly 10 digits!';
                        }

                        // You can add additional validation to check if it contains only digits
                        if (!RegExp(r'^[0-9]+$').hasMatch(textValue)) {
                          return 'Phone no must contain only digits!';
                        }

                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextField(
                        controller: controller.occupationC.value,
                        hint: "Occupation",
                        title: "Occupation:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Address is required!';
                          }
                          return null;
                        }
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.addressC.value,
                      hint: "Address",
                      title: "Address:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Address is required!';
                          }
                          return null;
                        }
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextField(
                        controller: controller.discriptionC.value,
                        hint: "Description",
                        title: "Description:",
                        validator: (textValue) {
                          if (textValue == null || textValue.isEmpty) {
                            return 'Address is required!';
                          }
                          return null;
                        }
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.noteC.value,
                      hint: "Note",
                      title: "Note:",
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: DatePickerTextField(
                      controller: controller.dateC.value,
                      title: 'Date',
                      onDateSelected: (date) async {
                        controller.dateC.value.text =
                        await GlobalData().ConvertToSchoolDateTimeFormat(date);
                      },),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Expanded(
              child: DatePickerTextField(
              controller: controller.nextFollowUpDateC.value,
                  title: 'Next Follow up date',
                  onDateSelected: (date) async {
                    controller.nextFollowUpDateC.value.text =
                    await GlobalData().ConvertToSchoolDateTimeFormat(date);
                  }),
                  ),
                  SizedBox(width: 10,),

                  Expanded(child:
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: MyCustomSD(
                      hideSearch: true,
                      labelText: 'Assigned',
                      borderColor: Colors.grey,
                      listToSearch: controller.getAdmissionEnquiryList.stffList!.map((item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: "name",
                      label: 'Assigned',
                      onChanged: (val) {
                        print(val);
                        if(val!=null){
                          controller.assignedId.value = val['id'];
                        }

                      },
                    ),
                  ),),
                ],
              ),

              SizedBox(height: 5,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: MyCustomSD(
                    labelText: '',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.getAdmissionEnquiryList.reference!.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "reference",
                    label: 'Reference',
                    onChanged: (val) {
                      if (val != null) {
                        controller.referenceId.value = val['id'];
                      }
                    },
                  ),),

                  SizedBox(width: 10,),

                  Expanded(child:
                  MyCustomSD(
                    hideSearch: true,
                    labelText: '',
                    borderColor: Colors.grey,
                    listToSearch: controller.getAdmissionEnquiryList.sourcelist!.map((item) {
                      return item.toJson();
                    }).toList(),
                    valFrom: "source",
                    label: 'Source',
                    onChanged: (val) {
                      print(val);
                      controller.sourceId.value = val['id'];
                    },
                  ),),
                ],
              ),


              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.numberOfChildC.value,
                      hint: "No of child",
                      title: "No of child:",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10,),

                  Expanded(
                    child: CustomTextField(
                      controller: controller.emailC.value,
                      hint: "Email",
                      title: "Email:",
                      validator: (textValue) {
                        if (textValue == null || textValue.isEmpty) {
                          return 'Email is required!';
                        }

                        // Regular expression to validate an email address
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(textValue)) {
                          return 'Enter a valid email address!';
                        }

                        return null;
                      },
                    ),
                  ),



                ],
              ),




              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Expanded(
              //       child: MyCustomSD(
              //       labelText: '',
              //       hideSearch: true,
              //       borderColor: Colors.grey,
              //       listToSearch: controller.getAdmissionEnquiryList.classList!.map((item) {
              //         return item.toJson();
              //       }).toList(),
              //       valFrom: "class",
              //       label: 'Class',
              //       onChanged: (val) {
              //         if (val != null) {
              //           controller.classId.value = val['id'];
              //         }
              //       },
              //     ),)
              //   ],
              // ),

              // CustomTextField(
              //   controller: controller.descriptionC.value,
              //   hint: "Description",
              //   title: "",
              //   maxLine: 3,
              // ),

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
                  onPress: () async {
                    if (controller.addEnquiryFormKey.currentState!.validate()) {
                      await controller.addAdmissionEnquiry(context);
                    }

                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }


}