import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:learnladderfaculity/widgets/button.dart';
import 'package:learnladderfaculity/widgets/custom_button.dart';

import '../../../widgets/customTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../../widgets/timePickerTextField.dart';
import 'class_timetable_controller.dart';

class AddClassTimetable extends StatefulWidget {
  const AddClassTimetable({Key? key});

  @override
  State<AddClassTimetable> createState() => _AddClassTimetableState();
}

class _AddClassTimetableState extends State<AddClassTimetable> {
  ClassTimetableController controller = Get.put(ClassTimetableController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('Add Class Time Table', style: theme.textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GetBuilder(
              init: controller,
              builder: (_) {
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
                    Text(
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
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.days.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  controller.updateIsTapped =
                                      controller.days[index].toString();
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
                    SingleChildScrollView(
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
                        rows: controller.data.asMap().entries.map((entry) {
                          int index = entry.key;
                          return DataRow(
                            cells: [
                              DataCell(
                                  MyCustomSD(
                                    borderColor: Colors.grey,
                                    label: 'Select subject',
                                    listToSearch: controller.data,
                                    valFrom: 'subject',
                                    onChanged: (value) {  },)),
                              DataCell(MyCustomSD(
                                borderColor: Colors.grey,
                                label: 'Select Teacher',
                                listToSearch: controller.data,
                                valFrom: 'section',
                                onChanged: (value) {},
                              )),
                              DataCell(
                                TimePickerTextField(
                                  controller: controller.timeFromC.value,
                                  onTimeSelected: (time) {
                                    controller.timeFromC.value.text =
                                        controller.formatTimeOfDay(time);
                                  },
                                  title: '',
                                ),
                              ),
                              DataCell(TimePickerTextField(
                                controller: controller.timeTo.value,
                                onTimeSelected: (time) {
                                  controller.timeTo.value.text =
                                      controller.formatTimeOfDay(time);
                                },
                                title: '',
                              ),),
                              DataCell(CustomTextField(
                                controller: controller.roomNumberC.value,
                                hint: 'Room No.',
                                title: '',
                                keyboardType: TextInputType.number,

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
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MyButton(
                          title: 'Save',
                        width: 80,
                        color: Colors.green.shade400,
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
