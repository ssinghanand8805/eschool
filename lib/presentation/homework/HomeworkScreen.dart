import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/homework/controller/homework_controller.dart';
import 'package:lerno/presentation/homework/model/Homework.dart';
import 'package:flutter/material.dart';
import 'package:lerno/presentation/homework/viewPdf.dart';
import 'package:readmore/readmore.dart';

import '../../core/utils/common_utilities.dart';
import '../common_widgets/custom_loader.dart';
import '../submit_homework/submit_homework.dart';
import 'model/StudentSubjects.dart';
import 'package:html/parser.dart'; // to parse HTML documents

class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with SingleTickerProviderStateMixin {
  HomeWorkController controller = Get.put(HomeWorkController());
  @override
  void initState() {
    super.initState();
    controller.tabController = TabController(vsync: this, length: 3);
    controller.tabController.addListener(onTabChanged);
    // getSubjects();
  }

  // void getSubjects() {
  //   controller.getSubjects(context);
  //   controller.getData(context);
  // }

  @override
  void dispose() {
    controller.tabController.dispose();
    controller.tabController.removeListener(onTabChanged);
    super.dispose();
  }

  void onTabChanged() {
    // Your code here
    if (!controller.tabController.indexIsChanging) {
      // Your code here
      print('Tab changed to: ${controller.tabController.index}');
      // controller.homeworkModelObj.value.homeworklist = [];
      // controller.currentSelectedSubejectId.value =  1;
      controller.status.value = controller.tabController.index == 0
          ? 'pending'
          : controller.tabController.index == 1
              ? 'submitted'
              : 'evaluated';
      controller.getData(selectedDate: controller.selectedDate.value);
      print('#############: ${controller.homeworkModelObj.value.homeworklist}');
      // controller.update();
    } else {
      controller.homeworkModelObj.value.homeworklist = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Homework',
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),
            ),
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () => controller.selectDate(context),
            ),
          ],
        ),
        bottom: MyTabBar(
          tabController: controller.tabController,
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          HomeworkTabContent(status: 'Pending'),
          HomeworkTabContent(status: 'Submitted'),
          HomeworkTabContent(status: 'Evaluated'),
          // HomeworkTabContent(status: 'All'),
        ],
      ),
    );
  }
}

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController _tabController;

  MyTabBar({Key? key, required TabController tabController})
      : _tabController = tabController,
        super(key: key);
  HomeWorkController controller = Get.put(HomeWorkController());

  String dropdownValue = 'All';
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final tabTextStyle = TextStyle(
          fontSize: isSmallScreen ? 14.0 : 18.0,
          fontWeight: FontWeight.bold,
        );

        return Theme(
            data: Theme.of(context).copyWith(
              tabBarTheme: TabBarTheme(
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade500,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            child: Container(
                color: Colors.green.shade50,
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: 'Pending',
                        ),
                        Tab(
                          text: 'Submitted',
                        ),
                        Tab(
                          text: 'Evaluated',
                        ),
                      ],
                      labelStyle: tabTextStyle,
                      unselectedLabelStyle: tabTextStyle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 33,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(50)),
                      child: GetBuilder(
                        init: controller,
                        builder: (_) => FutureBuilder(
                            future: controller.fetchDataFutureForSubjects,
                            builder: (_, snanpshot) {
                              if (snanpshot.connectionState !=
                                  ConnectionState.done) {
                                return SizedBox(
                                  width: 20.0,
                                  height: 20.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                );
                              } else {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                                  ),
                                  child: DropdownButton<Subjectlist>(
                                    value: controller.currentSelectedSubject.value.subjectId == null
                                        ? controller.studentSubjectsModelObj.value.subjectlist![0]
                                        : controller.currentSelectedSubject.value,
                                    icon: Icon(Icons.keyboard_arrow_down_rounded),
                                    isExpanded: true,
                                    onChanged: (Subjectlist? newValue) {
                                      if (newValue != null) {
                                        controller.currentSelectedSubject.value = newValue;
                                        controller.currentSelectedSubejectId.value = newValue.subjectId!;
                                        controller.update();
                                        controller.getData(selectedDate: controller.selectedDate.value);
                                      }
                                    },
                                    items: (controller.studentSubjectsModelObj.value?.subjectlist ?? [])
                                        .map<DropdownMenuItem<Subjectlist>>((Subjectlist value) {
                                      return DropdownMenuItem<Subjectlist>(
                                        value: value,
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                                          ),
                                          child: Text(
                                            value.name ?? '',
                                            style: TextStyle(color: Colors.red),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );

                            }
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ])));
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class HomeworkTabContent extends GetWidget<HomeWorkController> {
  final String status;

  const HomeworkTabContent({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller
                .fetchDataFutureForSubjects;
            await controller.fetchDataFuture;
          },
          child: FutureBuilder(
            future: controller.fetchDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader();
              } else if (controller.homeworkModelObj.value.homeworklist !=
                      null &&
                  controller.homeworkModelObj.value.homeworklist?.length == 0) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/projectImages/no_data.png",
                    )),
                    Text("No data found"),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount:
                      controller.homeworkModelObj.value.homeworklist?.length ??
                          0,
                  itemBuilder: (context, index) {
                    return HomeworkCard(
                      status: status,
                      homework: controller
                          .homeworkModelObj.value.homeworklist![index],
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}

class HomeworkCard extends GetView<HomeWorkController> {
  final String status;
  final Homeworklist homework;

  const HomeworkCard({Key? key, required this.status, required this.homework})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: controller.tabController.index == 0
          ? Container(
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
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    width: Get.width,
                    child: Row(
                      children: [
                        Text(
                            "${homework.subjectName.toString()} (${homework.subjectCode.toString()})",
                            //'{homework.} (Code)',
                            style: theme.textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600)),
                        Spacer(),
                        statusButton(status),
                        SizedBox(
                          width: 5,
                        ),
                        controller.tabController.index == 0
                            ? submitButton(context, homework.id!)
                            : SizedBox(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoRow(
                            title: 'Homework Date',
                            value: Utils.formatDateString(
                                homework.homeworkDate.toString())),
                        InfoRow(
                            title: 'Submission Date',
                            value: Utils.formatDateString(
                                homework.submitDate.toString())),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentViewerScreen(
                                        documentUrl: homework.document!,
                                      )),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Document   "),
                              Flexible(
                                  child: Text(
                                homework.document.toString(),
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              )),
                              Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                        // InfoRow(
                        //     title: 'Evaluated By',
                        //     value: '${homework.evaluatedBy.toString()}'),
                        // InfoRow(
                        //     title: 'Evaluation Date',
                        //     value:
                        //         '${Utils.formatDateString(homework.evaluationDate.toString())}'),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description  ',
                                style: theme.textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            Expanded(
                              child: ReadMoreText(
                                parse(homework.description).body!.text,
                                trimMode: TrimMode.Line,
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimCollapsedText: 'Show more',
                                trimExpandedText: 'Show less',
                                moreStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // Flexible(
                            //     child: Text(
                            //  homework.description.toString(),
                            //   style: theme.textTheme.titleMedium!,
                            // )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : controller.tabController.index == 1
              ? Container(
                  decoration: BoxDecoration(
                      boxShadow: [
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
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        width: Get.width,
                        child: Row(
                          children: [
                            Text(
                                "${homework.subjectName.toString()} (${homework.subjectCode.toString()})",
                                //'{homework.} (Code)',
                                style: theme.textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            Spacer(),
                            statusButton(status),
                            SizedBox(
                              width: 5,
                            ),
                            controller.tabController.index == 0
                                ? submitButton(context, homework.id!)
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                                title: 'Homework Date',
                                value: Utils.formatDateString(
                                    homework.homeworkDate.toString())),
                            InfoRow(
                                title: 'Submission Date',
                                value: Utils.formatDateString(
                                    homework.submitDate.toString())),
                            InfoRow(
                                title: 'Student Submit Message',
                                value: Utils.formatDateString(
                                    homework.studentSubmitMessage.toString())),
                            InfoRow(
                                title: 'Student Submit file',
                                value: Utils.formatDateString(
                                    homework.studentSubmitFileName.toString())),
                            InfoRow(
                                title: 'Student Submit File',
                                value: Utils.formatDateString(
                                    homework.studentSubmitFileName.toString())),

                            // InfoRow(
                            //     title: 'Evaluated By',
                            //     value: '${homework.evaluatedBy.toString()}'),
                            // InfoRow(
                            //     title: 'Evaluation Date',
                            //     value:
                            //         '${Utils.formatDateString(homework.evaluationDate.toString())}'),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description  ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                Expanded(
                                  child: ReadMoreText(
                                    homework.description.toString(),
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.blue,
                                    trimCollapsedText: 'Read more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Flexible(
                                //     child: Text(
                                //  homework.description.toString(),
                                //   style: theme.textTheme.titleMedium!,
                                // )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      boxShadow: [
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
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        width: Get.width,
                        child: Row(
                          children: [
                            Text(
                                "${homework.subjectName.toString()} (${homework.subjectCode.toString()})",
                                style: theme.textTheme.titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600)),
                            Spacer(),
                            statusButton(status),
                            SizedBox(
                              width: 5,
                            ),
                            controller.tabController.index == 0
                                ? submitButton(context, homework.id!)
                                : SizedBox(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InfoRow(
                                title: 'Homework Date',
                                value: Utils.formatDateString(
                                    homework.homeworkDate.toString())),
                            InfoRow(
                                title: 'Submission Date',
                                value: Utils.formatDateString(
                                    homework.submitDate.toString())),

                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DocumentViewerScreen(
                                            documentUrl: homework.document!,
                                          )),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Document"),
                                  Text(homework.document.toString()),
                                  Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                            // InfoRow(
                            //     title: 'Evaluated By',
                            //     value: '${homework.evaluatedBy.toString()}'),
                            // InfoRow(
                            //     title: 'Evaluation Date',
                            //     value:
                            //         '${Utils.formatDateString(homework.evaluationDate.toString())}'),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description  ',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(fontWeight: FontWeight.w600)),
                                Expanded(
                                  child: ReadMoreText(
                                    homework.description.toString(),
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                // Flexible(
                                //     child: Text(
                                //  homework.description.toString(),
                                //   style: theme.textTheme.titleMedium!,
                                // )),
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

  Widget statusButton(String status) {
    Color color;
    switch (status) {
      case 'Pending':
        color = Colors.orange.shade300;
        break;
      case 'Submitted':
        color = Colors.orange;
        break;
      case 'Evaluated':
        color = Colors.green;
        break;
      default:
        color = Colors.grey;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      onPressed: () {},
      child: Text(status, style: theme.textTheme.titleMedium),
    );
  }

  Widget submitButton(context, String id) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.grey.shade400,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UploadHomework(homeworkid: id)),
        );
      },
      child: Text("Submit"),
    );
  }
}

// ignore: must_be_immutable
class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  TextStyle? style;
  TextStyle? style1;

  InfoRow(
      {Key? key,
      required this.title,
      required this.value,
      this.style,
      this.style1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: style == false ? theme.textTheme.titleMedium : style,
            ),
          ),
          Expanded(
            flex: 4,
            child: value.isEmpty
                ? Text(
                    "------------",
                    style: style1 == false
                        ? theme.textTheme.titleMedium!
                            .copyWith(color: Colors.grey.shade700)
                        : style1,
                  )
                : Text(
                    value,
                    style: style1 == false
                        ? theme.textTheme.titleMedium!
                            .copyWith(color: Colors.grey.shade700)
                        : style1,
                  ),
          ),
        ],
      ),
    );
  }
}
