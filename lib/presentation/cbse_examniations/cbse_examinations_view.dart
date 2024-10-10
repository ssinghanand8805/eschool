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
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TabBar(
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
              labelPadding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              dividerHeight: 0.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                color: theme.primaryColorDark,
                borderRadius: BorderRadius.circular(50),
              ),
              tabs: [
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "CBSE Marks",
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("CBSE Results"),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildChildWidget(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/projectImages/no_data.png"),
                      Text("No data found!"),
                    ],
                  ),
                ),
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
                      itemCount: controller.cbseResultModelObj.length ?? 0,
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

  List<DataColumn> _getColumns(Exams data) {
    List<DataColumn> columns = [
      DataColumn(
        label: Text('Subject', style: theme.textTheme.titleSmall),
      ),
      DataColumn(
        label: Text('Obtained Marks', style: theme.textTheme.titleSmall),
      ),
      DataColumn(
        label: Text('Total Marks', style: theme.textTheme.titleSmall),
      ),
    ];

    // if (data != null) {
    //   // for (var exam in data.exams!) {
    //     for (var assessment in data.examAssessments!) {
    //       columns.add(
    //         DataColumn(
    //           label: Text(
    //             assessment.assessmentName!,
    //             style: theme.textTheme.titleSmall,
    //           ),
    //         ),
    //       );
    //     }
    //   // }
    // }

    return columns;
  }

  List<DataRow> _gteRowsForDataTable(Exams data) {
    List<DataRow> rows = [];

    if (data != null) {
      // for (var exam in data.exams!) {
      for (var assessment in data.examAssessments!) {
        for (var subject in assessment.subjects!) {
          List<DataCell> cells = [
            DataCell(Text(subject.subjectName.toString(),
                style: theme.textTheme.bodySmall!)),
            DataCell(Text(subject.marks.toString(),
                style: theme.textTheme.bodySmall!)),
            DataCell(Text(subject.maximumMarks.toString(),
                style: theme.textTheme.bodySmall!)),
          ];

          // for (var examAssessment in data.examAssessments ?? []) {
          //   var matchingSubject = examAssessment.subjects?.firstWhere(
          //         (s) => s.subjectId == subject.subjectId,
          //     orElse: () => Subjects(subjectId: 'N/A', marks: 'N/A'),
          //   );
          //
          //   if (matchingSubject?.subjectId != 'N/A') {
          //     cells.add(DataCell(Text(
          //       matchingSubject.marks ?? 'N/A',
          //       style: theme.textTheme.bodySmall!,
          //     )));
          //   } else {
          //     cells.add(DataCell(Text(
          //       'N/A',
          //       style: theme.textTheme.bodySmall!,
          //     )));
          //   }
          // }

          rows.add(DataRow(cells: cells));
        }
      }
      // }
    }

    return rows;
  }

  Widget _buildAssignmentCard({required Exams data, required int index}) {
    // print(data.);
    return CommonCardExtended(
        bottomTitle: true,
        title: data.examName.toString(),
        leadingWidget: SizedBox(),
        newWidget: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 5, bottom: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: false,
              headingRowHeight: 40,
              dataRowHeight: 40, // Assuming you want the same height for data rows
              columnSpacing: 10,
              horizontalMargin: 0,
              showCheckboxColumn: false,
              dividerThickness: 0.1,
              onSelectAll: (b) {
                print(b);
              },
              columns: _getColumns(data),
              rows: _gteRowsForDataTable(data),
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
                  value: ' ${data.totalMarks} / ${data.maxMarks}',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
                Expanded(
                    child: InfoRow(
                  title: 'Percentage',
                  value: '${data.percentage}%',
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
                  value: '${data.grade}+',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
                Expanded(
                    child: InfoRow(
                  title: 'Rank',
                  value: '${data.examRank}',
                  style: theme.textTheme.titleSmall,
                  style1: theme.textTheme.bodySmall,
                )),
              ],
            ),
          ],
        ));
  }
}
