import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:learnladderfaculity/presentation/academics/Promote%20Student/promote_student_controller.dart';

import '../../../theme/theme_helper.dart';

class PromoteStudentView extends GetView<PromoteStudentController> {
  PromoteStudentView({Key? key})
      : super(
          key: key,
        );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(
          'Assign Class Teacher',
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          // Padding(
          // padding: const EdgeInsets.only(right: 8.0),
          // child: MyButton(
          // width: 120,
          // prefixIcon: Icon(Icons.add,color: Colors.white,),
          // title: 'Add',
          // textStyle: TextStyle(fontSize:18,color: Colors.white),
          // color: theme.hintColor,
          // onPress: () {
          // addAssignClassTeacher(context);
          // },
          // ),
          // ),
        ],
      ),
    );
  }
}
