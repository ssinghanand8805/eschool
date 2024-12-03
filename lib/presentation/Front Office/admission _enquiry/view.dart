import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:lottie/lottie.dart';
import '../../../apiHelper/GlobalData.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/custom_loader.dart';
import 'ComonScaffold.dart';
import 'CustomScaffoldController.dart';
import 'admission_Enquiry_controller.dart';
import 'enquiry_data_modal.dart';

class AdmissionEnquiryView extends GetView<AdmissionEnquiryController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomScaffold(
      parentController: controller,
      filterFunction: filterControls,
      futureInitFunction: controller.fetchDataFuture,
      aapBarTitle: 'Admission Enquiry',
      bodyWidget: GetBuilder(
          init: controller,
          builder: (context) {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.getAdmissionEnquiryList.enquiryList!.length,
              itemBuilder: (context, index) {
                EnquiryList enqData =
                    controller.getAdmissionEnquiryList.enquiryList![index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: controller.getAdmissionEnquiryList.enquiryList!.isEmpty
                      ? Container(
                          child:
                              Lottie.asset("assets/images/no_data_found.json"),
                        )
                      : modernEnquiryCard(enqData)
                );
              },
            );
          }),
      floatingActionButton: floatingAction(context),
    );
    //   Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.green.shade100,
    //     title: Text(
    //       'Select Criteria',
    //       style: theme.textTheme.titleLarge,
    //     ),
    //     actions: [
    //       InkWell(
    //         onTap: () {
    //           filterControls(context);
    //         },
    //         child: Padding(
    //           padding: const EdgeInsets.only(right: 8.0),
    //           child:Icon(Icons.filter_alt_outlined)
    //         ),
    //       ),
    //     ],
    //   ),
    //   body: GetBuilder(
    //     init: controller,
    //     builder: (_) {
    //       return FutureBuilder(
    //         future: controller.fetchDataFuture,
    //         builder: (context,snapshot) {
    //           if (snapshot.connectionState != ConnectionState.done) {
    //             return CustomLoader();
    //           }
    //           else
    //             {
    //
    //               return Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
    //                 child: Column(
    //                   children: [
    //                     Column(
    //                       children: [
    //                 SizedBox(
    //                   height: 50,
    //                   child: ListView(
    //                      scrollDirection: Axis.horizontal,
    //                   children: [
    //                   Chip(label: Text("Class:${controller.selectedClassName.value}")),
    //                                 Chip(label: Text("Source:${controller.selectedSourceName.value}")),
    //                                 Chip(label: Text("Followup Date:${controller.fromDateC.value.text}")),
    //                                 Chip(label: Text("Next Follow Up Date:${controller.toDateC.value.text}")),
    //                                 Chip(label: Text("Status:${controller.selectedStatusName.value}")),
    //                                 ],
    //                   ),
    //                 ),
    //
    //                        SizedBox(height: 10,),
    //                         Align(
    //                             alignment: Alignment.topLeft,
    //                             child: Text("Admission Enquiry",style: theme.textTheme.titleLarge)),
    //                       ],
    //                     ),
    //
    //
    //
    //                   ],
    //                 ),
    //               );
    //             }
    //
    //         }
    //       );
    //     }
    //   ),
    //   // floatingActionButton: MyButton(
    //   //   width: 120,
    //   //   // prefixIcon: Icon(
    //   //   //   Icons.add,
    //   //   //   color: Colors.white,
    //   //   // ),
    //   //   title: 'Add enquiry',
    //   //   textStyle: TextStyle(fontSize: 14, color: Colors.white),
    //   //   color: theme.hintColor,
    //   //   onPress: () {
    //   //     addCategory(context);
    //   //   },
    //   // ),
    //   floatingActionButton: InkWell(
    //     onTap: (){
    //       addCategory(context);
    //     },
    //     child: Container(
    //       padding: EdgeInsets.all(6),
    //       decoration: BoxDecoration(
    //         color: Colors.green,
    //         shape: BoxShape.circle
    //       ),
    //         child: Icon(Icons.add,size: 40,)),
    //   ),
    //   // floatingActionButtonLocation: ,
    // );
  }


  Widget modernEnquiryCard(dynamic enqData) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
       // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade100,
              Colors.green.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section: Name and Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        enqData.name ?? "N/A",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.phone, color: Colors.blue),
                        onPressed: () {
                          // Navigate to follow-up enquiry
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () {
                          // Edit enquiry
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Delete enquiry
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 1, color: Colors.grey),

              // Enquiry Details
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Source:",
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  Text(
                    enqData.source ?? "N/A",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enquiry Date:",
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  Text(
                    enqData.date ?? "N/A",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // Follow-Up Dates
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Last Follow-Up Date",
                          style:
                          theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          enqData.followUpDate ?? "N/A",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next Follow-Up Date",
                          style:
                          theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                        Text(
                          enqData.nextDate ?? "N/A",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Status and Phone Number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [Colors.green, Colors.lightGreen],
                          ),
                        ),
                        child: Text(
                          "Active",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone No.:",
                        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        enqData.contact ?? "N/A",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  floatingAction(context) {
    return FloatingActionButton(
      onPressed: () {
        addCategory(context);
      },
      tooltip: 'Add Item',
      shape: CircleBorder(),
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),
    );
  }

  filterControls(context) {
    showCustomBottomSheet(
      context: context,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:
                    controller.getAdmissionEnquiryList.classList!.map((item) {
                  return item.toJson();
                }).toList(),
                valFrom: "class",
                label: 'Class',
                labelText: 'Class',
                onChanged: (val) {
                  if (val != null) {
                    print(val);
                    controller.classId.value = val['id'];
                    controller.selectedClassName.value = val['class'];
                    //   customScaffoldController.updateChipDataListC = {'Selected Source': controller.selectedClassName.value.obs};
                    print(controller.classId.value.toString());
                  }
                },
              )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: MyCustomSD(
                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch:
                    controller.getAdmissionEnquiryList.sourcelist!.map((item) {
                  return item.toJson();
                }).toList(),
                valFrom: "source",
                label: 'Source',
                labelText: 'Source',
                onChanged: (val) {
                  print(val);
                  if (val != null) {
                    controller.sourceId.value = val['id'];
                    controller.selectedSourceName.value = val['source'];
                    //customScaffoldController.updateChipDataListC = {'Selected Source': controller.selectedSourceName.value.obs};
                    print(controller.sourceId.value.toString());
                  }
                },
              )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: DatePickerTextField(
                  controller: controller.fromDateC.value,
                  title: 'Follow Up Date',
                  onDateSelected: (date) async {
                    controller.fromDateC.value.text =
                        await GlobalData().ConvertToSchoolDateTimeFormat(date);
                    // customScaffoldController.updateChipDataListC = {'Selected Follow Up Date': controller.fromDateC.value.text.obs};
                    controller.update();
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DatePickerTextField(
                    controller: controller.toDateC.value,
                    title: 'Next Follow Up Date',
                    onDateSelected: (date) async {
                      controller.toDateC.value.text = await GlobalData()
                          .ConvertToSchoolDateTimeFormat(date);
                      //  customScaffoldController.updateChipDataListC = {'Selected Next Follow Up Date': controller.toDateC.value.text.obs};
                      controller.update();
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: MyCustomSD(
                  hideSearch: true,
                  borderColor: Colors.grey,
                  listToSearch: controller
                      .getAdmissionEnquiryList.enquiryStatus!
                      .toJson()
                      .entries
                      .map((entry) {
                    return {
                      'id': entry.key, // The key of the map (e.g., "active")
                      'name':
                          entry.value // The value of the map (e.g., "Active")
                    };
                  }).toList(),
                  valFrom: "name",
                  label: 'Status',
                  labelText: 'Status',
                  onChanged: (val) {
                    controller.selectedSourceName.value = val['name'];
                    //  customScaffoldController.updateChipDataListC = {'Selected Status':  controller.selectedSourceName.value.obs};
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
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: MyButton(
                  width: 100,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                  ),
                  title: 'Search',
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  color: Colors.green.shade100,
                  onPress: () {
                    controller.enquiry();
                    Get.back();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  addCategory(context) {
    showCustomBottomSheet(
      context: context,
      child: Column(children: [
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
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyCustomSD(
                      labelText: 'Class',
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .getAdmissionEnquiryList.classList!
                          .map((item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: "class",
                      label: 'Class',
                      onChanged: (val) {
                        if (val != null) {
                          controller.classId.value = val['id'];
                        }
                      },
                    ),
                  )
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: DatePickerTextField(
                      controller: controller.dobC.value,
                      title: 'DOB',
                      onDateSelected: (date) async {
                        controller.dobC.value.text = await GlobalData()
                            .ConvertToSchoolDateTimeFormat(date);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
                        }),
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
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
                        }),
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
                  SizedBox(
                    width: 10,
                  ),
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
                        }),
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
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
                        }),
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: DatePickerTextField(
                      controller: controller.dateC.value,
                      title: 'Date',
                      onDateSelected: (date) async {
                        controller.dateC.value.text = await GlobalData()
                            .ConvertToSchoolDateTimeFormat(date);
                      },
                    ),
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
                              await GlobalData()
                                  .ConvertToSchoolDateTimeFormat(date);
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: MyCustomSD(
                        hideSearch: true,
                        labelText: 'Assigned',
                        borderColor: Colors.grey,
                        listToSearch: controller
                            .getAdmissionEnquiryList.stffList!
                            .map((item) {
                          return item.toJson();
                        }).toList(),
                        valFrom: "name",
                        label: 'Assigned',
                        onChanged: (val) {
                          print(val);
                          if (val != null) {
                            controller.assignedId.value = val['id'];
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MyCustomSD(
                      labelText: '',
                      hideSearch: true,
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .getAdmissionEnquiryList.reference!
                          .map((item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: "reference",
                      label: 'Reference',
                      onChanged: (val) {
                        if (val != null) {
                          controller.referenceId.value = val['id'];
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: MyCustomSD(
                      hideSearch: true,
                      labelText: '',
                      borderColor: Colors.grey,
                      listToSearch: controller
                          .getAdmissionEnquiryList.sourcelist!
                          .map((item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: "source",
                      label: 'Source',
                      onChanged: (val) {
                        print(val);
                        controller.sourceId.value = val['id'];
                      },
                    ),
                  ),
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
                  SizedBox(
                    width: 10,
                  ),
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
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                            .hasMatch(textValue)) {
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

              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 120,
                  title: 'Save',
                  textStyle: TextStyle(
                    color: Colors.white,
                  ),
                  color: Colors.green,
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
      ]),
    );
  }
}
