import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Send%20Sms/send_sms_controller.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';

class SendSmsView extends GetView<SendSmsController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Send Sms',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 140,
              prefixIcon: Icon(
                Icons.add,
                size: 14,
                color: Colors.white,
              ),
              title: 'Message To',
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              color: Colors.green,
              onPress: () async {
                messageTo(context);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomSD(
                listToSearch: controller.demo,
                borderColor: Colors.grey,
                valFrom: 'name',
                label: "Select Sms Template",
                onChanged: (val) {}),
            CustomTextField(
                controller: controller.titleC.value, hint: "Title", title: ''),
            SizedBox(
              height: 10,
            ),
            Text(
              "Send Through :",
              style: theme.textTheme.titleMedium,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: controller.SendThrough.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => CheckboxListTile(
                    title: Text(
                      controller.SendThrough[index],
                      style: theme.textTheme.bodySmall,
                    ),
                    value: controller.checkBoxSendThroughState[index],
                    onChanged: (bool? value) {
                      if (value != null) {
                        controller.toggleSendThroughCheckbox(index, value);
                      }
                    },
                  ),
                );
              },
            ),
            CustomTextField(
                controller: controller.templateId.value,
                hint: "Template ID",
                title: ''),
            CustomTextField(
                maxLine: 5,
                controller: controller.messageC.value,
                hint: "Message",
                title: ''),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: MyButton(
                  width: 100,
                  title: 'Send Email',
                  textStyle: TextStyle(fontSize: 14, color: Colors.white),
                  color: Colors.green,
                  onPress: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  messageTo(context) {
    showCustomBottomSheet(
        context: context,
        child: GetBuilder(
            init: controller,
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: SizedBox(
                        width: Get.width,
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller.groups.length,
                          itemBuilder: (context, index) {
                            var ddd = controller.groups[index];
                            return Obx(() => InkWell(
                              onTap: () {
                                controller.updateSelectedData =
                                    ddd.toString();
                                print("hhhhhhh" +
                                    controller.getSelectedData.toString());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: controller.getSelectedData
                                        .toString() ==
                                        controller.groups[index]
                                            .toString()
                                        ? Colors.green.shade200
                                        : Colors.black12,
                                  ),
                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(controller.groups[index]
                                            .toString(),style: theme.textTheme.titleMedium,),
                                      )),
                                ),
                              ),
                            ));
                          },
                        ),
                      ),
                    )
                  ]),
                  Text(
                    "Message To",
                    style: theme.textTheme.titleMedium,
                  ),
                  controller.getSelectedData == "Group"
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.roles.length,
                      itemBuilder: (context, index) {
                        return Obx(() => CheckboxListTile(
                          title: Text(controller.roles[index],style: theme.textTheme.titleMedium,),
                          value: controller.checkboxStates[index],
                          onChanged: (bool? value) {
                            if (value != null) {
                              controller.toggleCheckbox(index, value);
                            }
                          },
                        ));
                      })
                      : controller.getSelectedData == "Individual"
                      ? Column(
                    children: [
                      MyCustomSD(
                          listToSearch: [
                            {"name": "Faheem"},
                            {"name": "Amritash"},
                            {"name": "Anand"}
                          ],
                          valFrom: "name",
                          label: "Select",
                          borderColor: Colors.grey,
                          onChanged: (val) {}),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 8,
                            child: CustomTextField(
                                controller: controller.searchC.value,
                                hint: "Search",
                                title: ''),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: MyButton(
                                width: 100,
                                title: 'Add',
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white),
                                color: Colors.green.shade100,
                                onPress: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          Text(
                                            "Mohd Faheem(10123)",
                                            style: theme
                                                .textTheme.bodySmall,
                                          )
                                        ],
                                      ),
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                      : controller.getSelectedData == "Class"
                      ? Column(
                    children: [
                      MyCustomSD(
                          listToSearch: [
                            {"name": "Faheem"},
                            {"name": "Amritash"},
                            {"name": "Anand"}
                          ],
                          valFrom: "name",
                          label: "Message To",
                          borderColor: Colors.grey,
                          onChanged: (val) {}),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Obx(
                                () => CheckboxListTile(
                              title:
                              Text(controller.section[index],style: theme.textTheme.titleMedium,),
                              value: controller
                                  .checkBoxSectionState[index],
                              onChanged: (bool? value) {
                                if (value != null) {
                                  controller
                                      .toggleSectionCheckbox(
                                      index, value);
                                }
                              },
                            ),
                          );
                        },
                      )
                    ],
                  )
                      : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                          controller: controller.messageToC.value,
                          hint: "Message.....",
                          maxLine: 5,
                          title: '')
                  ),
                  Obx(
                        () => Column(
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Send Now',
                              groupValue: controller.selectedOption.value,
                              onChanged: (String? value) {
                                controller.selectedOption.value = value!;
                                controller.selectedTime =
                                null; // Reset selected time
                              },
                            ),
                            Text('Send Now',style: theme.textTheme.titleMedium,),
                            Radio<String>(
                              value: 'Schedule',
                              groupValue: controller.selectedOption.value,
                              onChanged: (String? value) {
                                controller.selectedOption.value = value!;

                                print(controller.selectedOption.toString());
                              },
                            ),
                            Text('Schedule',style: theme.textTheme.titleMedium,),
                          ],
                        ),
                        if (controller.selectedOption.value == 'Schedule')
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text("Schedule Date Time",style: theme.textTheme.bodyMedium,),
                              DatePickerTextField(
                                controller: controller.titleC.value,
                                title: 'Schedule Date Time',
                              ),
                              if (controller.selectedTime != null)
                                Text(
                                  'Selected time: ${controller.selectedTime!.value.format(context)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MyButton(
                      width: 120,
                      title: 'Submit',
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                      color: Colors.green,
                      onPress: () {},
                    ),
                  ),
                ],
              );
            }));
  }
}
