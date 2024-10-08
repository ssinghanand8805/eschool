import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/widgets/CheckForUpdate.dart';

import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/cbse_examinations_controller.dart';
import 'model/CbseExaminations.dart';

class CbseExaminationsScreen extends StatefulWidget {
  @override
  State<CbseExaminationsScreen> createState() => _DailyAssignmentScreenState();
}

class _DailyAssignmentScreenState extends State<CbseExaminationsScreen> {
  CbseExaminationsController controller = Get.put(CbseExaminationsController());

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your CBSE Exam\nResult Here!',
      imageUrl: 'assets/projectImages/cbseexaminationpage.jpg',
      AppbarTitle: 'CBSE Exam Result',
      actionWidget: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.examScheduleRoute);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 22,
                ),
                Text(
                  "Exam Schedule",
                  style: theme.textTheme.titleMedium,
                )
              ],
            ),
          ),
        )
      ],
      widget: CustomTabView(),
    );
  }
}

class CustomTabView extends StatefulWidget {

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  CbseExaminationsController controller = Get.put(CbseExaminationsController());

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
           // padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TabBar(
              dividerHeight: 0.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(50),
              ),
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Assignment"),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Other Tab"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildChildWidget(),
                Center(child: Text("This is another tab")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader();
            } else {
              return controller.cbseResultModelObj.length > 0
                  ? ListView.builder(
                      itemCount:
                          controller.cbseResultModelObj.length ?? 0,
                      itemBuilder: (context, index) {
                        return _buildAssignmentCard(
                          data: controller.cbseResultModelObj[index],
                          index: index,
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/projectImages/no_data.png"),
                          Text("No data found!"),
                        ],
                      ),
                    );
            }
          },
        );
      },
    );
  }

  List<DataColumn> _getColumns(Exam data) {
    List<DataColumn> columns = [
      DataColumn(
        label: Text('Subject', style: theme.textTheme.titleSmall),
      )
    ];
    if (data.examData!.subjects![0].examAssessments!.examAssessment1 != null) {
      columns.add(
        DataColumn(
          label: Text(
              'Theory' +
                  " ( " +
                  data.examData!.subjects![0].examAssessments!.examAssessment1!
                      .maximumMarks! +
                  " )",
              style: theme.textTheme.titleSmall),
        ),
      );
    }
    if (data.examData!.subjects![0].examAssessments!.examAssessment2 != null) {
      columns.add(
        DataColumn(
          label: Text('Practical', style: theme.textTheme.titleSmall),
        ),
      );
    }
    if (data.examData!.subjects![0].examAssessments!.examAssessment3 != null) {
      columns.add(
        DataColumn(
          label: Text('Assignment', style: theme.textTheme.titleSmall),
        ),
      );
    }
    columns.add(
      DataColumn(
        label: Text('Total Marks', style: theme.textTheme.titleSmall),
      ),
    );
    return columns;
  }

  _gteRowsForDataTable(Exam data) {
    List<DataRow> rows = [];

    for (var i = 0; i < data.examData!.subjects!.length; i++) {
      double totalMarks = 0.0;
      List<DataCell> cells = [
        DataCell(Text(data.examData!.subjects![i].subjectName!,
            style: theme.textTheme.bodySmall))
      ];
      if (data.examData!.subjects![i].examAssessments!.examAssessment1 !=
          null) {
        if (data.examData!.subjects![i].examAssessments!.examAssessment1!.marks
                .toString() !=
            "xx") {
          totalMarks = totalMarks +
              double.parse(data.examData!.subjects![i].examAssessments!
                  .examAssessment1!.marks!);
        }

        cells.add(
          DataCell(Text(
              data.examData!.subjects![i].examAssessments!.examAssessment1!
                  .marks!,
              style: theme.textTheme.bodySmall)),
        );
      }
      if (data.examData!.subjects![i].examAssessments!.examAssessment2 !=
          null) {
        if (data.examData!.subjects![i].examAssessments!.examAssessment2!.marks
                .toString() !=
            "xx") {
          totalMarks = totalMarks +
              double.parse(data.examData!.subjects![i].examAssessments!
                  .examAssessment2!.marks!);
        }
        cells.add(
          DataCell(Text(
              data.examData!.subjects![i].examAssessments!.examAssessment2!
                  .marks!,
              style: theme.textTheme.bodySmall)),
        );
      }
      if (data.examData!.subjects![i].examAssessments!.examAssessment3 !=
          null) {
        if (data.examData!.subjects![i].examAssessments!.examAssessment3!.marks
                .toString() !=
            "xx") {
          totalMarks = totalMarks +
              double.parse(data.examData!.subjects![i].examAssessments!
                  .examAssessment3!.marks!);
        }
        cells.add(
          DataCell(Text(
              data.examData!.subjects![i].examAssessments!.examAssessment3!
                  .marks!,
              style: theme.textTheme.bodySmall)),
        );
      }
      cells.add(
        DataCell(
            Text(totalMarks.toString(), style: theme.textTheme.titleSmall)),
      );
      rows.add(DataRow(cells: cells));
      print("TOTAL MARKS $totalMarks");
    }

    return rows;
  }

  Widget _buildAssignmentCard({required Exam data, required int index}) {
    return CommonCardExtended(
        bottomTitle: true,
        title: data.name!,
        leadingWidget: SizedBox(),
        newWidget: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 5, bottom: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: false,
              headingRowHeight: 40,
              onSelectAll: (b) {
                print(b);
              },
              columns: _getColumns(data),
              rows: _gteRowsForDataTable(data),
              columnSpacing: _getColumns(data).length < 5 ? 100 : 10,
              horizontalMargin: 0,
              showCheckboxColumn: false,
              dividerThickness: 0.1,
            ),
          ),
        ),
        bottomTitleWidget: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: InfoRow(
                  title: "Total Marks",
                  value: '${data!.examObtainMarks}/${data!.examTotalMarks}',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
                Expanded(
                    child: InfoRow(
                  title: 'Percentage',
                  value: '${data!.examPercentage}%',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: InfoRow(
                  title: 'Grade',
                  value: '${data!.examGrade}+',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
                Expanded(
                    child: InfoRow(
                  title: 'Rank',
                  value: '${data!.examRank}',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
              ],
            ),
          ],
        ));
  }
}
