import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';

import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/daily_assignment_controller.dart';
import 'model/DailyAssignment.dart';

class DailyAssignmentScreen extends StatefulWidget {
  @override
  State<DailyAssignmentScreen> createState() => _DailyAssignmentScreenState();
}

class _DailyAssignmentScreenState extends State<DailyAssignmentScreen> {
  DailyAssignmentController controller = Get.put(DailyAssignmentController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getAssignment();
  }

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
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture, //controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            } else {
              return controller.assignmentModelObj.value.dailyassignment!
                  .length >
                  0
                  ? ListView.builder(
                itemCount: controller
                        .assignmentModelObj.value.dailyassignment!.length ??
                    0,
                itemBuilder: (context, index) {
                  return  _buildAssignmentCard(
                          data: controller
                              .assignmentModelObj.value.dailyassignment![index],
                        );

                },
              ) : Center(
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/projectImages/no_data.png",

                      ),
                      Text("No data found!")
                    ],
                  ));;
            }
          },
        );
      },
    );
  }

  Widget _buildAssignmentCard({required Dailyassignment data}) {
    return CommonCardExtended(
      title: data.title!,
      leadingWidget: SizedBox(),
      subtitle: data.date!,
      newWidget: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 5, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Remark : ",
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text(data.remark!, style: theme.textTheme.titleMedium!),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Submission Date : ',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Flexible(
                    child:
                        Text('${data.date}', style: TextStyle(fontSize: 13))),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Evaluation Date: ',
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Text('${data.evaluationDate}',
                    style: theme.textTheme.titleMedium!),
              ],
            ),
            SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description: ",
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    data.description!,
                    style: theme.textTheme.titleMedium!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
