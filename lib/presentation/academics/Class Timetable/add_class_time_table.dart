import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/button.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';

import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../../widgets/timePickerTextField.dart';
import '../../common_widgets/CommonForm.dart';
import '../../common_widgets/controller/CommonApiController.dart';
import '../../common_widgets/custom_loader.dart';
import 'SubjectGroup.dart';
import 'class_timetable_controller.dart';

class AddClassTimetable extends StatefulWidget {
  const AddClassTimetable({Key? key});

  @override
  State<AddClassTimetable> createState() => _AddClassTimetableState();
}

class _AddClassTimetableState extends State<AddClassTimetable> {
  ClassTimetableController controller = Get.put(ClassTimetableController());
  CommonApiController commonApiController =
  Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Add Class Time Table', style: theme.textTheme.bodyLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GetBuilder(
            init: controller,
            builder: (_) {

              return CommonForm(
                  widgetFilterSelectedData: Row(
                    children: [
                      Text("Class :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                      Text(commonApiController.selectedClassName.value + " ( " + commonApiController.selectedSectionName.value + " )",
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
                      SizedBox(width: 20),

                    ],
                  ),
                  widgetFilterData: Column(
                    children: [
                      Obx( () => MyCustomSD(

                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: commonApiController.classListModelMap.value,
                        valFrom: "className",
                        label: 'Class',
                        labelText: 'Class',
                        onChanged: (val) {
                          if(commonApiController.classListModelMap.value.length > 0)
                          {
                            print("5555555555555");

                            commonApiController.selectedClassId.value = val['id'].toString();
                            commonApiController.selectedClassName.value = val['className'].toString();
                            commonApiController.update();
                            commonApiController.getSectionList();
                          }

                        },
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Obx( () => MyCustomSD(
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: commonApiController.sectionListModelMap.value,
                        valFrom: "section",
                        label: 'Section',
                        labelText: 'Section',
                        onChanged: (val) {
                          print(val);
                          if(commonApiController.sectionListModelMap.value.length > 0)
                          {


                            commonApiController.selectedSectionId.value = val['id'].toString();
                            commonApiController.selectedSectionName.value = val['section'].toString();

                            commonApiController.update();
                            controller.getSubjectGroup();

                          }

                        },
                      )),
                      SizedBox(
                        height: 5,
                      ),
                      MyCustomSD(
                        labelText: 'Subject Group',
                        hideSearch: true,
                        borderColor: Colors.grey,
                        listToSearch: controller.subjectGroupList.value.map((item) {
                          return item.toJson();
                        }).toList(),
                        valFrom: "name",
                        label: 'Subject Group',
                        onChanged: (val) {
                          if(val != null)
                            {
                              controller.selectedSubjectGroupId.value = val['id'];
                              controller.update();
                            }

                         // print(val['id']);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ),
                  widgetformData: Column(
                    children:[
                      SizedBox(height: 10,),
                      Expanded(child: commonApiController.isLoadingStudentList.isTrue ? CustomLoader() :   getForm() ?? Container())
                    ]
                    ,),
                  onTapAction: controller.getCreateListData);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyCustomSD(
                    hideSearch: true,
                    labelText: 'Class',
                    borderColor: Colors.grey,
                    listToSearch: controller.lesson,
                    valFrom: "name",
                    label: 'Class',
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Section',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.lesson,
                    valFrom: "name",
                    label: 'Section',
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyCustomSD(
                    labelText: 'Subject Group',
                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.lesson,
                    valFrom: "name",
                    label: 'Subject Group',
                    onChanged: (val) {
                      print(val);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Button(icon: Icons.search, onTap: () {}, text: 'Search'),
                  SizedBox(
                    height: 10,
                  ),

                ],
              );
            }),
      ),
    );
  }


  getForm()
  {
    return controller.isSelectedClassSubject.isFalse ? SizedBox(): SingleChildScrollView(
      child:
      Column(children: [  Text(
        "Select parameter to generate time table\nquickly",
        style: theme.textTheme.bodyMedium,
      ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: TimePickerTextField(
                controller: controller.startTimeC.value,
                onTimeSelected: (time) {
                  controller.startTimeC.value.text =
                      controller.formatTimeOfDay(time);
                },
                title: 'Period Start Time',
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: CustomTextField(
                controller: controller.durationC.value,
                hint: 'duration (minute)',
                title: 'Duration (minute)',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: controller.intervalC.value,
                hint: 'interval (minute)',
                title: 'Interval (minute)',
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: CustomTextField(
                controller: controller.roomNoC.value,
                hint: 'room no.',
                title: 'Room No.',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 60,
          width: Get.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.days.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      controller.updateIsTapped =
                          controller.days[index].toString();
                      controller.updateSelectedDay(controller.days[index].toString());
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.getIsTapped ==
                              controller.days[index].toString()
                              ? theme.disabledColor
                              : Colors.green.shade100),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8),
                        child: Center(
                            child: Text(
                                controller.days[index].toString(),
                                style: theme.textTheme.titleSmall)),
                      ),
                    ),
                  ));
            },
          ),
        ),
        Obx(() {
          var records = controller.getRecordsForSelectedDay();

          // If records is null or empty, add a default record
          if (records == null || records.isEmpty) {
            records = [
              Record(
                subjectGroupSubjectId: "0", // default or empty values
                staffId: "0",
                timeFrom: '',
                timeTo: '',
                roomNo: '',
              )
            ];
          }
         return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 0.0,
              dataRowMinHeight: 20,
              columnSpacing: Get.width * 0.1,
              dataRowMaxHeight: 80,
              columns: const [
                DataColumn(label: Text('Subject')),
                DataColumn(label: Text('Teacher')),
                DataColumn(label: Text('Time From')),
                DataColumn(label: Text('Time To')),
                DataColumn(label: Text('Room No.')),
                DataColumn(label: Text('Action')),
              ],
              rows: records.asMap().entries.map((entry) {
                int index = entry.key;
                print("rrrrrrrr${entry.value.subjectGroupSubjectId}");
                return DataRow(
                  cells: [
                    DataCell(
                        MyCustomSD(
                          borderColor: Colors.grey,
                          label: 'Select subject',
                          listToSearch: controller.timeTableList.value.subject!
                              .map((item) {
                            return item.toJson();
                          }).toList(),
                          valFrom: 'name',
                          initialValue: [{ 'parameter': 'id','value':entry.value.subjectGroupSubjectId}],
                          onChanged: (value) {
                            if(value != null)
                              {
                                entry.value.subjectGroupSubjectId = value['id'];
                                controller.timeTableList.refresh();

                                // Debug log
                                print("Updated subjectGroupSubjectId: ${entry.value.subjectGroupSubjectId}");
                              }


                          },)),
                    DataCell(MyCustomSD(
                      borderColor: Colors.grey,
                      label: 'Select Teacher',
                      listToSearch: controller.timeTableList.value.staff!.map((
                          item) {
                        return item.toJson();
                      }).toList(),
                      valFrom: 'name',
                      initialValue: [{ 'parameter': 'id','value':entry.value.staffId}],
                      onChanged: (value) {
                        if(value != null)
                        {
                          entry.value.staffId = value['id'];
                        }
                      },
                    )),
                    DataCell(
                      TimePickerTextField(
                        controller: TextEditingController(
                            text: controller.formatTimeForDisplay(entry!.value!.timeFrom!)
                        ),
                        onTimeSelected: (time) {
                          // controller.timeFromC.value.text =
                          //     controller.formatTimeOfDay(time);
                          entry.value.timeFrom = controller.formatTimeOfDay(time);
                        },
                        title: '',
                      ),
                    ),
                    DataCell(TimePickerTextField(
                      controller: TextEditingController(
                          text: controller.formatTimeForDisplay(entry!.value!.timeTo!)
                      ),
                      onTimeSelected: (time) {
                        // controller.timeFromC.value.text =
                        //     controller.formatTimeOfDay(time);
                        entry.value.timeTo = controller.formatTimeOfDay(time);
                      },
                      title: '',
                    ),),
                    DataCell(CustomTextField(
                      controller: TextEditingController(
                          text: entry.value.roomNo // Use existing value if available
                      ),
                      hint: 'Room No.',
                      title: '',
                      keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Update the record with the new value
                          entry.value.roomNo = value;
                        }

                    )),
                    DataCell(
                      Row(
                        children: [
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
          );
        }),
        Align(
          alignment: Alignment.bottomRight,
          child: MyButton(
            title: 'Save',
            width: 80,
            color: Colors.green.shade400,
            onPress: () {

              controller.saveDayWiseRecords();
            },
          ),
        )]),
    );
  }
}
