import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/homework/HomeworkScreen.dart';

import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import 'controller/exam_schedule_controller.dart';
import 'model/Examschedule.dart';

class ExamScheduleScreen extends StatefulWidget {
  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {

  ExamScheduleController controller = Get.put(ExamScheduleController());
  @override

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your CBSE Exam\nSchedule is Here!',
      imageUrl: 'assets/projectImages/cbseexaminationpage.jpg',
      AppbarTitle: ' Exam Schedule',
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
              return controller.examScheduleModelObj.value.result != null && controller.examScheduleModelObj.value.result!
                  .length >
                  0
                  ? ListView.builder(
                itemCount: controller
                    .examScheduleModelObj.value.result!.length ??
                    0,
                itemBuilder: (context, index) {
                  return  _buildAssignmentCard(
                    data: controller
                        .examScheduleModelObj.value,
                    index: index
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

  Widget _buildAssignmentCard({required ExamSchedule data, required int index}) {
    return CommonCardExtended(
      title: data.result![index].name!,
      leadingWidget: SizedBox(),
      newWidget: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 5, bottom: 10),
        child:DataTable(
          showBottomBorder: false,
          headingRowHeight: 40,
          onSelectAll: (b) {
            print(b);
          },
          columns: [
            DataColumn(
                label: Text('Subject',
                  style: theme.textTheme.titleSmall)),
            DataColumn(label: Text('Date',
                style: theme.textTheme.titleSmall)),
            DataColumn(label: Text('Start \nTime',
                style: theme.textTheme.titleSmall)),
            DataColumn(label: Text('Duration \n(Minutes)',
                style: theme.textTheme.titleSmall)),
            DataColumn(label: Text('Room',
                style: theme.textTheme.titleSmall)),
          ],
          rows: data.result![index].timeTable
              !.map(
                (data) =>    DataRow(
                onSelectChanged: (val){},
                cells: [
                  DataCell(Text(data.subjectName.toString(),
                    style: theme.textTheme.bodySmall)),
                  DataCell(Text(data.date.toString(),
                    style: theme.textTheme.bodySmall)),
                  DataCell(Text(data.timeFrom.toString(),
                    style: theme.textTheme.bodySmall)),
                  DataCell(Text(data.duration.toString(),
                    style: theme.textTheme.bodySmall,)),
                  DataCell(Text(data.roomNo.toString(),
                    style: theme.textTheme.bodySmall,)),
                ]),
          )
              .toList(),
          columnSpacing: 25,
          horizontalMargin: 0,
          showCheckboxColumn: false,
          dividerThickness: 0.1,
        ),
      ),

    );
  }
}
