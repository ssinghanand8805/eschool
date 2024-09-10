import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/homework/controller/homework_controller.dart';
import 'package:lerno/presentation/homework/model/Homework.dart';
import 'package:flutter/material.dart';

import '../../core/utils/common_utilities.dart';
import '../common_widgets/custom_loader.dart';
import '../submit_homework/submit_homework.dart';
import 'model/StudentSubjects.dart';

class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  HomeWorkController controller = Get.put(HomeWorkController());
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(onTabChanged);
    // getSubjects();
  }

  // void getSubjects() {
  //   controller.getSubjects(context);
  //   controller.getData(context);
  // }

  @override
  void dispose() {
    _tabController.dispose();
    _tabController.removeListener(onTabChanged);
    super.dispose();
  }

  void onTabChanged() {
    // Your code here
    if (!_tabController.indexIsChanging) {
      // Your code here
      print('Tab changed to: ${_tabController.index}');
      // controller.homeworkModelObj.value.homeworklist = [];
      // controller.currentSelectedSubejectId.value =  1;
      controller.status.value = _tabController.index == 0
          ? 'pending'
          : _tabController.index == 1
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Homework'),
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () => controller.selectDate(context),
            ),
          ],
        ),
        bottom: MyTabBar(
          tabController: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
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
                      height: 35,
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
                                return CircularProgressIndicator();
                                // return DropdownButton<Subjectlist>(
                                //   value: null,
                                //   icon: Icon(Icons.keyboard_arrow_down_rounded),
                                //   onChanged: (Subjectlist? newValue) {
                                //     controller.currentSelectedSubject.value= newValue!;
                                //     controller.currentSelectedSubejectId.value = newValue!.subjectId!;
                                //
                                //   },
                                //   items: <DropdownMenuItem<Subjectlist>>[
                                //     DropdownMenuItem(
                                //       value: controller.currentSelectedSubject.value == null ? null : controller.currentSelectedSubject.value,
                                //       child: Text('All'),
                                //     ),
                                //
                                //   ],
                                // );
                              } else {
                                return DropdownButton<Subjectlist>(
                                  value: controller.currentSelectedSubject.value
                                              .subjectId ==
                                          null
                                      ? controller.studentSubjectsModelObj.value
                                          .subjectlist![0]
                                      : controller.currentSelectedSubject.value,
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                  onChanged: (Subjectlist? newValue) {
                                    controller.currentSelectedSubject.value =
                                        newValue!;
                                    // controller.update();
                                    controller.currentSelectedSubejectId.value =
                                        controller.currentSelectedSubject.value!
                                            .subjectId!;
                                    controller.update();
                                    controller.getData(
                                        selectedDate:
                                            controller.selectedDate.value);
                                  },
                                  items: <DropdownMenuItem<Subjectlist>>[
                                    // DropdownMenuItem(
                                    //   value: Subjectlist(
                                    //     subjectGroupSubjectsId: "0",
                                    //     subjectGroupClassSectionsId: "0",
                                    //     name: "All",
                                    //     code: "",
                                    //     subjectId: "0",
                                    //   ),
                                    //   child: Text('All',style: TextStyle(color: Colors.red),),
                                    // ),
                                    if (controller.studentSubjectsModelObj !=
                                            null &&
                                        controller.studentSubjectsModelObj
                                                .value !=
                                            null &&
                                        controller.studentSubjectsModelObj.value
                                                .subjectlist !=
                                            null)
                                      ...controller.studentSubjectsModelObj!
                                          .value!.subjectlist!
                                          .map<DropdownMenuItem<Subjectlist>>(
                                              (Subjectlist value) {
                                        return DropdownMenuItem<Subjectlist>(
                                          value: value,
                                          child: Text(value.name!,
                                              style: TextStyle(
                                                  color: Colors
                                                      .red)), // Assuming 'name' is the display property
                                        );
                                      }),
                                  ],
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
            // Implement your refresh logic here
            print("Refresh Called");
            await controller
                .fetchDataFutureForSubjects; // Example method to load data
            await controller.fetchDataFuture; // Example method to load data
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
                  submitButton(context,homework.id!),
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
                      title: 'Created By',
                      value:
                          '${homework.createdByName.toString()} (${homework.createdByEmployeeId.toString()})'),
                  InfoRow(
                      title: 'Evaluated By',
                      value: '${homework.evaluatedBy.toString()}'),
                  InfoRow(
                      title: 'Evaluation Date',
                      value:
                          '${Utils.formatDateString(homework.evaluationDate.toString())}'),
                  InfoRow(
                      title: 'Max Marks',
                      value: '${homework.marks.toString()}'),
                  InfoRow(
                      title: 'Marks Obtained',
                      value: '${homework.evaluationMarks.toString()}'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description  ',
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.w600)),
                      Flexible(
                          child: Text(
                        'Please submit homework before last date.',
                        style: theme.textTheme.titleMedium!,
                      )),
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

  Widget submitButton(context,String  id) {
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
          MaterialPageRoute(builder: (context) => UploadHomework( homeworkid:id)),
        );
      },
      child: Text("Submit"),
    );
  }
}

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
            child: Text(
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
