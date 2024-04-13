import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:learnladder/presentation/common_widgets/CommonCard.dart';
import 'package:learnladder/presentation/common_widgets/MainBody.dart';

import '../common_widgets/CommonCardExtended.dart';
import 'controller/lesson_plan_controller.dart';

class LessonPlanScreen extends GetWidget<LessonPlanController> {
  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: 'Your Lesson Plan\nis here!',
        imageUrl: "assets/projectImages/lessonplanpage.jpg",
        AppbarTitle: "Lesson Plan",
        widget: CommonCardExtended(title: 'Mondy', newWidget: lessonPlan(), subtitle: '08/04/2024',leadingWidget: SizedBox()));
  }

  Widget lessonPlan(){
    return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text("Subject"),
        Text("Time"),
        Text("Syllabus"),
      ],
    );
  }
}


