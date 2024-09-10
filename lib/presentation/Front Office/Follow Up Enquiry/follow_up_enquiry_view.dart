import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learnladderfaculity/widgets/customTextField.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/datePickerTextField.dart';
import 'follow_up_enquiry_controller.dart';

class FollowUpEnquiryView extends GetView<FollowUpEnquiryController>{
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [

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

}