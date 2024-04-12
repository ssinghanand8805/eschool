import 'package:learnladder/core/app_export.dart';
import 'package:flutter/material.dart';

import '../common_widgets/MainBody.dart';

class DailyAssignmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Daily\nAssignment!',
      imageUrl: 'assets/projectImages/assignmentpage.jpg',
      AppbarTitle: 'Daily Assignment',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAssignmentCard(
            title: 'Mathematics (110)',
            remark: 'Keep hard working',
            submissionDate: '04/01/2023',
            evaluationDate: '04/10/2023',
            description:
                'the number series consists of a series of numbers in which the next term is obtained by adding or subtracting the constant term to the previous term.',
          ),
          _buildAssignmentCard(
            title: 'English (210)',
            remark: 'Keep hard working',
            submissionDate: '04/01/2023',
            evaluationDate: '04/05/2023',
            description:
                'The descriptive essay is a genre of essay that asks the student to describe something—object, person, place, experience, emotion, situation, etc.',
          ),
          _buildAssignmentCard(
            title: 'Hindi (210)',
            remark: 'Keep hard working',
            submissionDate: '04/01/2023',
            evaluationDate: '04/05/2023',
            description:
                'The descriptive essay is a genre of essay that asks the student to describe something—object, person, place, experience, emotion, situation, etc.',
          ),
          _buildAssignmentCard(
            title: 'Hindi (210)',
            remark: 'Keep hard working',
            submissionDate: '04/01/2023',
            evaluationDate: '04/05/2023',
            description:
                'The descriptive essay is a genre of essay that asks the student to describe something—object, person, place, experience, emotion, situation, etc.',
          ),
          _buildAssignmentCard(
            title: 'Hindi (210)',
            remark: 'Keep hard working',
            submissionDate: '04/01/2023',
            evaluationDate: '04/05/2023',
            description:
                'The descriptive essay is a genre of essay that asks the student to describe something—object, person, place, experience, emotion, situation, etc.',
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard({
    required String title,
    required String remark,
    required String submissionDate,
    required String evaluationDate,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(
              0.3,
              3.0,
            ),
            blurRadius: 4.0,
          ), //BoxShadow
          BoxShadow(
            color: Colors.white,
            offset: const Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: Get.width,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Remark: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text(remark, style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Submission Date: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text('$submissionDate', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Evaluation Date: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Text('$evaluationDate', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      Flexible(
                          child: Text(description,
                              style: TextStyle(fontSize: 13))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
