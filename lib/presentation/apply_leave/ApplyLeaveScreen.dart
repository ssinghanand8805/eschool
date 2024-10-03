import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/apply_leave/uploadLeave.dart';

import '../../core/utils/common_utilities.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/ApplyLeaveController.dart';
import 'model/ApplyLeave.dart';

class ApplyLeavePage extends StatefulWidget {
  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  ApplyLeaveController controller = Get.put(ApplyLeaveController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.image.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Applied\n Leaves!',
      imageUrl: 'assets/projectImages/leavepage.jpg',
      AppbarTitle: 'Apply Leave',
      widget: _buildChildWidget(),
      floatingActionButton: Container(
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          focusColor: Colors.green.shade600,
          backgroundColor: Colors.green.shade600,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LeaveApplicationPage()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
          shape: CircleBorder(),
        ),
      ),
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
                  return controller.applyLeaveModelObj!.value != null
                      ? controller.applyLeaveModelObj!.value!.resultArray!
                                  .length >
                              0
                          ? ListView.builder(
                              itemCount: controller.applyLeaveModelObj!.value!
                                      .resultArray?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return _buildLeaveCard(
                                    data: controller.applyLeaveModelObj!.value!
                                        .resultArray![index]);
                              },
                            )
                          : Center(
                              child: Image.asset(
                                  "assets/projectImages/no_data.png"))
                      : Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/projectImages/no_data.png",
                            ),
                            Text("No data found!")
                          ],
                        ));
                }
              });
        });
  }

  Widget _buildLeaveCard({required ResultArray data}) {
    print(data.applyDate);
    // return Text(data.applyDate!);
    return Padding(
      padding: EdgeInsets.all(12.0),
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
              padding: EdgeInsets.symmetric(
                horizontal: 8,
              ),
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: Get.width,
              child: Row(
                children: [
                  Text("Apply Date",
                      //'{homework.} (Code)',
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                  Spacer(),
                  Text(Utils.formatDateString(data.applyDate!.toString()),
                      //'{homework.} (Code)',
                      style: theme.textTheme.titleLarge!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'From Date',
                      value:
                          "${Utils.formatDateString(data.fromDate!.toString())}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'To  Date',
                      value:
                          "${Utils.formatDateString(data.toDate!.toString())}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Reason',
                      value: '${data.reason}'),
                  Row(
                    children: [
                      Text(
                        "Leave Status",
                        style:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      ),
                      Spacer(),
                      Container(
                        height: 25,
                        decoration: BoxDecoration(
                            color: _getStatusColor(data.status!),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            )),
                        child: Center(
                          child: Text(
                            " ${_getStatusString(data.status!)} ",
                            //'{homework.} (Code)',
                            style: theme.textTheme.titleSmall!
                                .copyWith(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    print(status);
    if (status.toString() == "1") {
      return Colors.green;
    } else if (status.toString() == "0") {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getStatusString(String status) {
    print(status);
    if (status.toString() == "1") {
      return "Approved";
    } else if (status.toString() == "0") {
      return "Pending";
    } else {
      return "Dis-Approved";
    }
  }
}
