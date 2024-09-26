import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/myCustomsd.dart';
import '../../apiHelper/GlobalData.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_button.dart';
import '../common_widgets/controller/CommonApiController.dart';
import 'DataModal/close_homework_modal.dart';
import 'controller/add_homework_controller.dart';
import 'model/addHomework.dart';

class AddHomeWorkScreen extends StatefulWidget {
  const AddHomeWorkScreen({Key? key});

  @override
  State<AddHomeWorkScreen> createState() => _AddHomeWorkScreenState();
}

class _AddHomeWorkScreenState extends State<AddHomeWorkScreen> {
  AddHomeWorkController controller = Get.put(AddHomeWorkController());
  CommonApiController commonApiController = Get.put(CommonApiController());

  AddHomeWorkModal modal = AddHomeWorkModal();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Homework',
          style: theme.textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              // prefixIcon: Icon(
              //   Icons.add,size: 14,
              //   color: Colors.white,
              // ),
              title: 'Add Homework',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                showAddHomeWork();
              },
            ),
          ),
        ],

      ),
      body:
      GetBuilder(
          init: controller,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: MyCustomSD(
                          hideSearch: true,
                          borderColor: Colors.grey,
                          listToSearch: commonApiController.classListModelMap
                              .value,
                          valFrom: "className",
                          label: 'Class',
                          labelText: 'Class',
                          onChanged: (val) {
                            print(val);
                            if (commonApiController.classListModelMap.value
                                .length > 0) {
                              print("5555555555555");

                              commonApiController.selectedClassId.value =
                                  val['id'].toString();
                              commonApiController.selectedClassName.value =
                                  val['className'].toString();
                              commonApiController.update();
                              commonApiController.getSectionList();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Obx(() {
                          return MyCustomSD(
                            hideSearch: true,
                            borderColor: Colors.grey,
                            listToSearch: commonApiController
                                .sectionListModelMap.value,
                            valFrom: "section",
                            label: 'Section',
                            labelText: 'Section',
                            onChanged: (val) {
                              print(val);
                              if (val != null) {
                                if (commonApiController.sectionListModelMap
                                    .value.length > 0) {
                                  commonApiController.selectedSectionId.value =
                                      val['section_id'].toString();
                                  commonApiController.selectedSectionName
                                      .value = val['section'].toString();
                                  commonApiController.update();
                                  modal.subjectGroup();
                                }
                              }
                            },
                          );
                        }),
                      ),


                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.getListGroupList.value,
                        valFrom: "name",
                        label: 'Subject Group',
                        labelText: 'Subject Group',
                        onChanged: (val) {
                          print(val);
                          if (val != null) {
                            controller.updateSubjectGroupId = val['subject_group_id'];
                            modal.subject();
                          }
                        },
                      ),),
                      SizedBox(
                        width: 5,
                      ),

                      Expanded(child: MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.getSubjectList.value,
                        valFrom: "name",
                        label: 'Subject',
                        labelText: 'Subject',
                        onChanged: (val) {
                          print(val);
                          if(val!=null){
                            controller.updateSubjectId = val['id'];

                          }
                        },
                      ),)
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  Button(text: 'Search',
                      onTap: () {
                        if (controller.getSubjectGroupId.value.isEmpty &&
                            commonApiController.selectedSectionId.value
                                .isEmpty &&
                            commonApiController.selectedClassId.value.isEmpty) {
                          print("Select DropDown");
                        } else {
                          modal.homework(context);
                          modal.closeHomework(context);
                        }
                      },
                      icon: Icons.search),
                  SizedBox(
                    height: 10,
                  ),
                  // Button(
                  //     text: 'Add',
                  //     onTap: () {
                  //       showAddHomeWork();
                  //     },
                  //     icon: Icons.add),
                  Text(
                    'Homework List',
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          modal.controller.isUpcomingHomeworkList.value =
                          "Upcoming homework";
                          modal.controller.update();
                        },
                        child: Container(
                          height: 40, width: Get.width / 2.1,
                          decoration: BoxDecoration(
                            color: modal.controller.isUpcomingHomeworkList
                                .value == "Upcoming homework" ? Colors.green
                                .shade200 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Upcoming homework",
                              style: theme.textTheme.titleMedium,),
                          )),
                        ),
                      ),
                      SizedBox(width: 4,),
                      GestureDetector(
                        onTap: () {
                          modal.controller.isUpcomingHomeworkList.value =
                          "Close homework";
                          modal.controller.update();
                        },
                        child: Container(
                          height: 40, width: Get.width / 2.1,
                          decoration: BoxDecoration(
                            color: modal.controller.isUpcomingHomeworkList
                                .value == "Close homework" ? Colors.green
                                .shade200 : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text("Close homework",
                              style: theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,),
                          )),
                        ),
                      ),
                    ],
                  ),

                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Upcoming homework",
                    child: CustomTextField(
                      controller: modal.controller.searchC.value,
                      hint: "search....",
                      title: "",
                      onChanged: (val){
                        modal.controller.update();
                      },
                    ),
                  ),


                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Close homework",
                    child: CustomTextField(
                        controller: modal.controller.searchC.value,
                        hint: "search....",
                        title: "",
                      onChanged: (val){
                          modal.controller.update();
                      },
                    ),
                  ),
                  SizedBox(height: 10,),


                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Upcoming homework",
                    child: Expanded(
                      child: modal.controller.getHomeworkList.isEmpty?Center(child: Text("No data found!")):ListView.builder(
                        itemCount:  modal.controller.getHomeworkList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CloseHomeworkDataModal upcomingHomeWorkData = modal.controller.getHomeworkList[index];
                          return upcomingHomeWork(upcomingHomeWorkData);
                        },),
                    ),
                  ),
                  Visibility(
                    visible: modal.controller.isUpcomingHomeworkList ==
                        "Close homework",
                    child: Expanded(
                      child: modal.controller.getCloseHomeworkList.isEmpty?Center(child: Text("Data not found!",)):ListView.builder(
                        itemCount: modal.controller.getCloseHomeworkList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          CloseHomeworkDataModal closeHomeworkData = modal
                              .controller.getCloseHomeworkList[index];
                          return closeHomeWork(closeHomeworkData);
                        },),
                    ),)


                  // Expanded(child: MyTable())
                ],
              ),
            );
          }),
    );
  }

  void showAddHomeWork() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (BuildContext context) {
        return GetBuilder(
            init: modal.controller,
            builder: (_) {
              return Padding(
                padding: MediaQuery
                    .of(context)
                    .viewInsets,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Homework',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: MyCustomSD(
                              hideSearch: true,
                              labelText: 'Class',
                              borderColor: Colors.grey,
                              listToSearch: commonApiController
                                  .classListModelMap.value,
                              valFrom: "className",
                              label: 'Class',
                              onChanged: (val) {
                                if (commonApiController.classListModelMap.value
                                    .length > 0) {
                                  print("5555555555555");

                                  commonApiController.selectedClassId.value =
                                      val['id'].toString();
                                  commonApiController.selectedClassName.value =
                                      val['className'].toString();
                                  commonApiController.update();
                                  commonApiController.getSectionList();
                                }
                              },
                            ),),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(child: Obx(() {
                              return MyCustomSD(
                                labelText: 'Section',
                                hideSearch: true,
                                borderColor: Colors.grey,
                                listToSearch: commonApiController
                                    .sectionListModelMap.value,
                                valFrom: "section",
                                label: 'Section',
                                onChanged: (val) {
                                  if (val != null) {
                                    if (commonApiController.sectionListModelMap
                                        .value.length > 0) {
                                      commonApiController.selectedSectionId
                                          .value = val['section_id'].toString();
                                      commonApiController.selectedSectionName
                                          .value = val['section'].toString();
                                      commonApiController.update();
                                      modal.subjectGroup();
                                    }
                                  }
                                },
                              );
                            }),)
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: MyCustomSD(
                              labelText: 'Subject Group',
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch: controller.getListGroupList.value,
                              valFrom: "name",
                              label: 'Subject Group',
                              onChanged: (val) {
                                if (val != null) {
                                  controller.updateSubjectGroupId =
                                  val['subject_group_id'];
                                  modal.subject();
                                }
                              },
                            ),),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(child: MyCustomSD(
                              labelText: 'Subject',
                              hideSearch: true,
                              borderColor: Colors.grey,
                              listToSearch: controller.getSubjectList.value,
                              valFrom: "name",
                              label: 'Subject',
                              onChanged: (val) {
                                print(val);
                                // if(val!=null){
                                //   controller.updateDutyFor = val['id'];
                                //
                                // }
                                // else{
                                //   controller.updateDutyFor=0;
                                // }
                              },
                            ),),


                          ],
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 3.0),
                                  child: Text("Homework Date",
                                      style: theme.textTheme.bodySmall!
                                          .copyWith(fontSize: 14)),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  height: 43,
                                  child: TextField(
                                    style: theme.textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      hintText:
                                      DateFormat('dd/MM/yyyy').format(
                                          DateTime.now()),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                    ),
                                    readOnly: true,
                                    controller: controller.homeWorkDate.value,
                                    onTap: () async {
                                      final date = await controller.getDate(
                                          context);
                                      if (date != null) {
                                        String formattedDate = await GlobalData().ConvertToSchoolDateTimeFormat(date);
                                        controller.homeWorkDate.value.text =formattedDate;
                                        print("@@@@@@@@ " +
                                            controller.homeWorkDate.value.text);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),),
                            SizedBox(width: 5,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3.0),
                                    child: Text("Submission Date",
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(fontSize: 14)),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    height: 43,
                                    child: TextField(
                                      style: theme.textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        hintText:
                                        DateFormat('dd/MM/yyyy').format(
                                            DateTime.now()),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(5))),
                                      ),
                                      readOnly: true,
                                      controller: controller.submissionDate
                                          .value,
                                      onTap: () async {
                                        final date = await controller.getDate(
                                            context);
                                        if (date != null) {
                                          String formattedDate = await GlobalData().ConvertToSchoolDateTimeFormat(date);
                                          controller.submissionDate.value.text = formattedDate;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),


                        SizedBox(
                          height: 150,
                          child: HtmlEditor(
                            htmlToolbarOptions: HtmlToolbarOptions(
                                toolbarItemHeight: 35,
                                toolbarType: ToolbarType.nativeGrid,
                                textStyle: theme.textTheme.titleMedium,
                                defaultToolbarButtons: [
                                  const StyleButtons(),
                                  const FontButtons(
                                      clearAll: true,
                                      strikethrough: false,
                                      subscript: false,
                                      superscript: false)
                                ]),
                            controller: controller.HtmlController.value,
                            //required
                            htmlEditorOptions: const HtmlEditorOptions(
                              hint: "Please enter ...",
                              shouldEnsureVisible: true,
                              autoAdjustHeight: true,
                              adjustHeightForKeyboard: true,
                            ),
                            otherOptions: const OtherOptions(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                modal.addHomeWork(context);
                                //Navigator.of(context).pop();
                              },
                              child: Text('Save'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        );
      },
    );
  }
}


upcomingHomeWork(CloseHomeworkDataModal upcomingHomeWork) {
  return
    Padding(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Text(
                                "Class: ",
                                style: theme.textTheme.bodySmall,),
                              Text(
                                upcomingHomeWork.className.toString(),
                                style: theme.textTheme.bodySmall,),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Section.: ",
                                style: theme.textTheme.bodySmall,),
                              Text(upcomingHomeWork.section.toString(), style: theme.textTheme.bodySmall,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject Group: ",
                                  style: theme.textTheme.bodySmall,),
                                Expanded(
                                  child: Text(
                                    "Class 1",
                                    style: theme.textTheme.bodySmall,),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),

                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject.: ",
                                  style: theme.textTheme.bodySmall,),
                                Expanded(
                                  child: Text(
                                    upcomingHomeWork.subjectName.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: 8,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(

                                children: [
                                  Text(
                                    "Homework Date: ",
                                    style: theme.textTheme.bodySmall,),
                                  Text(
                                    upcomingHomeWork.homeworkDate.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ],
                              ),
                              SizedBox(width: 5,),

                              Row(
                                children: [
                                  Text(
                                    "Submission Date: ",
                                    style: theme.textTheme.bodySmall,),
                                  Text(
                                    upcomingHomeWork.submitDate.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 8,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Evaluation Date: ",
                                      style: theme.textTheme.bodySmall,),
                                    Expanded(
                                      child: Text(
                                        upcomingHomeWork.evaluationDate.toString(),
                                        style: theme.textTheme.bodySmall,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5,),

                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Created by.: ",
                                      style: theme.textTheme.bodySmall,),
                                    Expanded(
                                      child: Text(
                                        upcomingHomeWork.staffInfo.toString(),
                                        style: theme.textTheme.bodySmall,),
                                    ),
                                  ],
                                ),
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
      ),
    );
}

closeHomeWork(CloseHomeworkDataModal closeHomeworkData) {
  return
    Padding(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Text(
                                "Class: ",
                                style: theme.textTheme.bodySmall,),
                              Text(
                                closeHomeworkData.className.toString(),
                                style: theme.textTheme.bodySmall,),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Section.: ",
                                style: theme.textTheme.bodySmall,),
                              Text(closeHomeworkData.section.toString(),
                                style: theme.textTheme.bodySmall,),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject Group: ",
                                  style: theme.textTheme.bodySmall,),
                                Expanded(
                                  child: Text(
                                    "Subject ",
                                    style: theme.textTheme.bodySmall,),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5,),

                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subject.: ",
                                  style: theme.textTheme.bodySmall,),
                                Expanded(
                                  child: Text(
                                    closeHomeworkData.subjectName.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                      SizedBox(height: 8,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(

                                children: [
                                  Text(
                                    "Homework Date: ",
                                    style: theme.textTheme.bodySmall,),
                                  Text(
                                    closeHomeworkData.homeworkDate.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ],
                              ),
                              SizedBox(width: 5,),

                              Row(
                                children: [
                                  Text(
                                    "Submission Date: ",
                                    style: theme.textTheme.bodySmall,),
                                  Text(
                                    closeHomeworkData.submitDate.toString(),
                                    style: theme.textTheme.bodySmall,),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 8,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Evaluation Date: ",
                                      style: theme.textTheme.bodySmall,),
                                    Expanded(
                                      child: Text(
                                        closeHomeworkData.evaluationDate
                                            .toString(),
                                        style: theme.textTheme.bodySmall,),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5,),

                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Created by.: ",
                                      style: theme.textTheme.bodySmall,),
                                    Expanded(
                                      child: Text(
                                        closeHomeworkData.staffInfo.toString(),
                                        style: theme.textTheme.bodySmall,),
                                    ),
                                  ],
                                ),
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
      ),
    );
}
