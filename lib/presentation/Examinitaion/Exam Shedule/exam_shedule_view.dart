import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/widgets/alert_dialogue.dart';
import 'package:learnladderfaculity/widgets/myCustomsd.dart';

import '../../../theme/theme_helper.dart';
import '../../../widgets/customTextField.dart';
import '../../../widgets/custom_button.dart';
import '../../CBSE Examination/Exam Schedule/exam_schedule_controller.dart';

class ExamScheduleView extends GetView<ExamScheduleController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Exam Schedule',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyButton(
              width: 120,
              prefixIcon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              title: 'Add',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              color: theme.hintColor,
              onPress: () {
                //addMarksGrade(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  addExamSchedule(context){
    // AlertDialogue().show(
    //   context,
    //   newWidget: [
    //     Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           "Add Marks Grade",
    //           style: theme.textTheme.bodyMedium,
    //         ),
    //         MyCustomSD(
    //             listToSearch: controller.demo,
    //             borderColor: Colors.grey,
    //             valFrom: "name",
    //             label: "Select Exam Type",
    //             onChanged: (val){
    //
    //             }),
    //         Row(
    //           children: [
    //             Expanded(
    //               child: CustomTextField(
    //                 controller: controller.gradeNameC.value,
    //                 hint: "Grade Name",
    //                 title: "",
    //               ),
    //             ),
    //             SizedBox(width: 10,),
    //             Expanded(
    //               child: CustomTextField(
    //                 controller: controller.percentUpToC.value,
    //                 hint: "Percent Upto",
    //                 title: "",
    //                 keyboardType: TextInputType.number,
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //         Row(
    //           children: [
    //             Expanded(
    //               child: CustomTextField(
    //                 controller: controller.percentFromC.value,
    //                 hint: "Percent From ",
    //                 title: "",
    //                 keyboardType: TextInputType.number,
    //               ),
    //             ),
    //             SizedBox(width: 10,),
    //
    //             Expanded(
    //               child: CustomTextField(
    //                 controller: controller.gradePointC.value,
    //                 hint: "Grade Point ",
    //                 title: "",
    //                 keyboardType: TextInputType.number,
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //         CustomTextField(
    //           controller: controller.descriptionC.value,
    //           hint: "Description",
    //           maxLine: 3,
    //           title: "",
    //         ),
    //
    //
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Align(
    //           alignment: Alignment.bottomRight,
    //           child: MyButton(
    //             width: 120,
    //             title: 'Save',
    //             textStyle: TextStyle(
    //               color: Colors.black,
    //             ),
    //             color: Colors.green.shade100,
    //             onPress: () {},
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }


}