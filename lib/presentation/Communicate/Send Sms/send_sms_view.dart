import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/Communicate/Send%20Sms/send_sms_controller.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import '../../../widgets/myCustomsd.dart';
import '../../common_widgets/CommonUserSelection.dart';
import '../../common_widgets/controller/CommonUserSelectionController.dart';

class SendSmsView extends GetView<SendSmsController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CommonUserSelectionController());
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Send Sms',
          style: theme.textTheme.bodyMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => MyCustomSD(
                  listToSearch: controller.bookList.value,
                  borderColor: Colors.grey,
                  valFrom: 'title',
                  labelText: "Select SMS Template",
                  label: "Select Sms Template",
                  onChanged: (val) {
                    if(val != null)
                      {
                        controller.selectedSmsTemplate.value = val;
                        controller.titleC.value.text = val['title'];
                        controller.templateId.value.text = val['template_id'];
                        controller.messageC.value.text = val['message'];
                        print(
                            "selected sms template ${controller.selectedSmsTemplate.value}");
                      }

                  })),
              CustomTextField(
                  controller: controller.titleC.value,
                  hint: "Title",
                  title: 'Title'),
              SizedBox(
                height: 10,
              ),
              Text(
                "Send Through : ",
                style: theme.textTheme.titleSmall,
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
                readOnly: true,

                  controller: controller.templateId.value,
                  hint: "Template ID",
                  title: 'Template ID'),
              CustomTextField(
                  maxLine: 5,
                  controller: controller.messageC.value,
                  hint: "Message",
                  title: ''),
              SizedBox(
                height: 10,
              ),
              CommonUserSelection(),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: MyButton(
                    width: 100,
                    title: 'Send SMS',
                    textStyle: TextStyle(fontSize: 14, color: Colors.white),
                    color: Colors.green,
                    onPress: () {
                      controller.sendMessage();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
