import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Student%20Information/Student%20Details/student_details_controller.dart';
import 'package:learnladderfaculity/presentation/common_widgets/custom_loader.dart';
import 'package:learnladderfaculity/presentation/library/add%20student/add_student_controller.dart';
import 'package:lottie/lottie.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/myCustomsd.dart';
import '../../Front Office/admission _enquiry/ComonScaffold.dart';
import 'DataModal.dart';


class  AddStudentView extends GetView< AddStudentController> {
  @override
  Widget build(BuildContext context) {
    if (controller.isInit) {
      filterControls(context);
      controller.isInit = false;
    }

    return CustomScaffold(
      parentController: controller,
      filterFunction: filterControls,

      futureInitFunction: controller.fetchDataFuture,
      aapBarTitle: 'Select Criteria',
      bodyWidget: GetBuilder(
          init: controller,
          builder: (context) {
            return Obx(() => Column(
                  children: [
                    CustomTextField(
                      controller: controller.searchC.value,
                      hint: "Search by student name",
                      title: "",
                      onChanged: (val) {
                        controller.searchStuInfo(val);
                        controller.update();
                      },
                    ),
                    //SizedBox(height: 10,),
                    controller.isLoading.isTrue
                        ? CustomLoader()
                        : Container(
                            child: controller.getStudentDetailsList.length > 0
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.getStudentDetailsList.length,
                                    itemBuilder: (context, index) {
                                      StudentDetails studentData =
                                          controller
                                              .getStudentDetailsList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            controller.getStudentDetailsList
                                                    .isEmpty
                                                ? Text("No data found!")
                                                : Container(

                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: Colors.grey
                                                                .shade200)),
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade400,
                                                                  blurRadius: 2,
                                                                  offset: Offset(
                                                                      0,
                                                                      1), // Shadow position
                                                                ),
                                                              ],
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    5, 10, 5),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              1,
                                                                          bottom:
                                                                              1),
                                                                  child:
                                                                      Container(
                                                                        height: 150,
                                                                    width: 3,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .green.shade200,
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0)),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Column(
                                                                                                                                            crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
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
                                                                              child: Text(
                                                                            studentData.firstname.toString() + " (${studentData.gender})",
                                                                            maxLines: 1,
                                                                            style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w800),
                                                                          )),
                                                                          InkWell(
                                                                              onTap: () {},
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Admission No.: ",
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  Text(
                                                                                    studentData.admissionNo.toString(),
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                              )),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "Class: ",
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Text(
                                                                                studentData.classname.toString() + " (${studentData.section})",
                                                                                maxLines: 3,
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "Roll No.: ",
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Text(
                                                                                studentData.rollNo.toString(),
                                                                                maxLines: 3,
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            8,
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Text(
                                                                                "DOB: ",
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                              Text(
                                                                                studentData.dob.toString(),
                                                                                maxLines: 3,
                                                                                style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                            8,
                                                                          ),
                                                                          Row(
                                                                            children: [

                                                                              Expanded(
                                                                                child: Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      "Father Name: ",
                                                                                      style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Text(
                                                                                        studentData.fatherName.toString(),
                                                                                        maxLines: 3,
                                                                                        style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 8,
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Guardian Name: ",
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  Text(
                                                                                    studentData.guardianName.toString(),
                                                                                    maxLines: 3,
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "Guardian Mob.: ",
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  Text(
                                                                                    studentData.guardianPhone.toString(),
                                                                                    style: theme.textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              Row(
                                                                                children: [
                                                                                IconButton(onPressed: (){}, icon: Icon(Icons.reply,color: Colors.green,)),
                                                                                  IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.green,)),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                                                                                            ],
                                                                                                                                          ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                      );
                                    },
                                  )
                                : Container(
                                    child: Lottie.asset(
                                        "assets/images/no_data_found.json"),
                                  ),
                          )
                  ],
                ));
          }),
      // floatingActionButton: floatingAction(context),
    );
  }

  filterControls(context) {
    AlertDialogue().show(
      context,
      newWidget: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => controller.commonApiController.isClassLoading.value ?  Expanded(child: Material(
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Text("Class"),
                  CircularProgressIndicator(),
                ],
              ),
            )) : Expanded(
                child: MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch:
                        controller.commonApiController.classListModelMap.value,
                    valFrom: "className",
                    label: 'Class',
                    labelText: 'Class',
                    initialValue: [
                      {
                        'parameter': 'id',
                        'value': controller.commonApiController.selectedClassId!
                      }
                    ],
                    onChanged: (val) {
                      if (controller.commonApiController.classListModelMap.value
                              .length >
                          0) {
                        print("5555555555555");

                        controller.commonApiController.selectedClassId.value =
                            val['id'].toString();
                        controller.commonApiController.selectedClassName.value =
                            val['className'].toString();
                        controller.selectedClassName.value =
                            val['className'].toString();
                        controller.commonApiController.update();
                        controller.commonApiController.getSectionList();
                      }
                    },
                  ),
              )),
            SizedBox(
              width: 10,
            ),
            Obx(() => controller.commonApiController.isSectionLoading.value ?Expanded(child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Text("Section"),
                  CircularProgressIndicator(),
                ],
              ),
            )): Expanded(
              child: MyCustomSD(
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller
                        .commonApiController.sectionListModelMap.value,
                    valFrom: "section",
                    label: 'Section',
                    labelText: 'Section',
                    initialValue: [
                      {
                        'parameter': 'id',
                        'value':
                            controller.commonApiController.selectedSectionId!
                      }
                    ],
                    onChanged: (val) {
                      print(val);
                      if (controller.commonApiController.sectionListModelMap
                              .value.length >
                          0) {
                        controller.commonApiController.selectedSectionId.value =
                            val['section_id'].toString();
                        controller.commonApiController.selectedSectionName
                            .value = val['section'].toString();
                        controller.selectedSectionName.value =
                            val['section'].toString();
                        controller.commonApiController.update();
                      }
                    },
                  ),
            )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: MyButton(
            width: 100,
            title: 'Search',
            textStyle: TextStyle(
              color: Colors.black,
            ),
            color: Colors.green.shade100,
            onPress: () {
              controller.studentByClassSection();
              Get.back();
            },
          ),
        ),
      ],
    );
  }
}


