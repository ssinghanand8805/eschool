import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';
import 'package:learnladder/presentation/apply_leave/uploadLeave.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/ApplyLeaveController.dart';

class ApplyLeavePage extends StatefulWidget {
  @override
  State<ApplyLeavePage> createState() => _ApplyLeavePageState();
}

class _ApplyLeavePageState extends State<ApplyLeavePage> {
  ApplyLeaveController controller = Get.put(ApplyLeaveController());
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
    // return GetBuilder(
    //   init: controller,
    //   builder: (_) {
    //     return FutureBuilder(
    //       future:  controller.fetchDataFuture,//controller.getData(context),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState != ConnectionState.done) {
    //           return CustomLoader(); // CustomLoader();
    //         }
    //         else {

    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildLeaveCard();

        // controller.syllabusStatusModelObj.value.subjects!.length > 0 ? _buildLeaveCard(
        // data: controller.syllabusStatusModelObj.value.subjects![index],
        // ): Center(child: Image.asset("assets/projectImages/no_data.png",height: 100,));
        //         },
        //       );;
        //
        //     }
        //   },
        // );
      },
    );
  }

  Widget _buildLeaveCard() {
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
                    "Apply Date - 04/08/2024",
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
                  InfoRow(title: 'From Date', value: "04/08/2024"),
                  InfoRow(title: 'To  Date', value: "04/08/2024"),
                  InfoRow(title: 'Reason', value: '04/08/2024'),
                 Row(children: [
                   Text("Leave Status",style: theme.textTheme.titleMedium,),
                   Spacer(),
                   Text(
                     "Pending",
                     //'{homework.} (Code)',
                     style: TextStyle(
                       color: _getStatusColor("Approved"),
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
    if (status.contains('Approved')) {
      return Colors.green;
    } else if (status.contains('Pending')) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
