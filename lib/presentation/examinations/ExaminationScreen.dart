import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';
import 'package:learnladder/presentation/apply_leave/uploadLeave.dart';

import '../apply_leave/model/ApplyLeave.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';

import 'controller/ExaminationController.dart';


class ApplyLeavePage extends StatefulWidget {
  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  ExaminationController controller = Get.put(ExaminationController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Applied\n Leaves!',
      imageUrl: 'assets/projectImages/leavepage.jpg',
      AppbarTitle: 'Apply Leave',
      widget: _buildChildWidget(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          focusColor: Colors.white54,
          backgroundColor: Colors.grey,
          onPressed: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveApplicationPage()),);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
            size: 50,
          ),
          shape: CircleBorder(),
        ),
      ),
    );
  }

  Widget _buildChildWidget() {
    return SizedBox();
    // return GetBuilder(
    //     init: controller,
    //     builder: (_) {
    //       return FutureBuilder(
    //           future: controller.fetchDataFuture, //controller.getData(context),
    //           builder: (context, snapshot) {
    //             if (snapshot.connectionState != ConnectionState.done) {
    //               return CustomLoader(); // CustomLoader();
    //             }
    //             else {
    //
    //               return controller.applyLeaveModelObj!.value != null ? controller.applyLeaveModelObj!.value!.resultArray!.length > 0 ? ListView.builder(
    //                 itemCount: controller.applyLeaveModelObj!.value!.resultArray?.length ?? 0,
    //                 itemBuilder: (context, index) {
    //                   return  _buildLeaveCard(
    //                       data: controller.applyLeaveModelObj!.value!.resultArray![index]
    //                   );
    //                 },
    //               ) : Center(child: Image.asset("assets/projectImages/no_data.png")) : Center(child: Image.asset("assets/projectImages/no_data.png"));
    //
    //               // return  controller.applyLeaveModelObj!.value!.resultArray!.length > 0
    //               //     ? ListView.builder(
    //               //   itemCount:  controller.applyLeaveModelObj.value.resultArray?.length ?? 0,
    //               //   itemBuilder: (context, index) {
    //               //     // return _buildLeaveCard();
    //               //
    //               //     return _buildLeaveCard(
    //               //         data: controller.applyLeaveModelObj.value
    //               //             .resultArray![index]);
    //               //   },
    //               // )
    //               //          : Center(child: Image.asset(
    //               //     "assets/projectImages/no_data.png"));
    //
    //
    //             }
    //           }
    //       );
    //     }
    // );
  }

  Widget _buildLeaveCard({required ResultArray data}) {
    print(data.applyDate);
    // return Text(data.applyDate!);
    return
        Padding(
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
              padding: EdgeInsets.symmetric(horizontal: 8,),
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
                    "Apply Date - ${data.applyDate}",
                    //'{homework.} (Code)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(title: 'From Date', value: "${data.fromDate}"),
                  InfoRow(title: 'To  Date', value: "${data.toDate}"),
                  InfoRow(title: 'Reason', value: '${data.reason}'),
                 Row(children: [
                   Text("Leave Status",style: theme.textTheme.titleMedium,),
                   Spacer(),
                   Text(
                     "${_getStatusString(data.status!)}",
                     //'{homework.} (Code)',
                     style: TextStyle(
                       color: _getStatusColor(data.status!),
                       fontWeight: FontWeight.w600,
                       fontSize: 14,
                     ),
                   ),
                 ],)
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
