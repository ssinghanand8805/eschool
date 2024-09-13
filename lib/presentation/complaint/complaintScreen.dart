import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/apply_leave/uploadLeave.dart';

import '../../core/utils/common_utilities.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'addComplaint.dart';
import 'controller/complaintController.dart';
import 'model/complaintModal.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  ComplaintController controller = Get.put(ComplaintController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Applied\nComplaint!',
      imageUrl: 'assets/projectImages/leavepage.jpg',
      AppbarTitle: 'Complaint',
      widget: _buildChildWidget(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          focusColor: Colors.white54,
          backgroundColor: Colors.grey,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddComplaintPage()),
            );
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
    return GetBuilder(
        init: controller,
        builder: (_) {
          return FutureBuilder(
              future: controller.fetchDataFuture, //controller.getData(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return CustomLoader(); // CustomLoader();
                }
                return Text("data");
                // else {
                //   return controller.complaintModelObj!.value != null
                //       ? controller.complaintModelObj!.value!.resultArray!
                //                   .length >
                //               0
                //           ? ListView.builder(
                //               itemCount: controller.complaintModelObj!.value!
                //                       .resultArray?.length ??
                //                   0,
                //               itemBuilder: (context, index) {
                //                 return _buildLeaveCard(
                //                     data: controller.complaintModelObj!.value!
                //                         .resultArray![index]);
                //               },
                //             )
                //           : Center(
                //               child: Image.asset(
                //                   "assets/projectImages/no_data.png"))
                //       : Center(
                //           child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Image.asset(
                //               "assets/projectImages/no_data.png",
                //             ),
                //             Text("No data found!")
                //           ],
                //         ));
                // }
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
                  Text(
                    "Complaint Type",
                    //'{homework.} (Code)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    Utils.formatDateString(data.applyDate!.toString()),
                    //'{homework.} (Code)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'Description',
                      value:"${Utils.formatDateString(data.fromDate!.toString())}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'Complaint Date',
                      value: "${Utils.formatDateString(data.toDate!.toString())}"),
                  // InfoRow(
                  //     style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                  //     style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                  //     title: 'Reason',
                  //     value: '${data.reason}'),
                  Row(
                    children: [
                      Text(
                        "Complaint Status",
                        style:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 14),
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
                                .copyWith(fontSize: 14, color: Colors.white),
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
