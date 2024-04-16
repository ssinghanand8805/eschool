import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';
import 'package:learnladder/presentation/hostel_rooms/model/Hostel.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/hostel_room_controller.dart';

class HostelRoomsPage extends StatefulWidget {
  @override
  State<HostelRoomsPage> createState() => _HostelRoomsPageState();
}

class _HostelRoomsPageState extends State<HostelRoomsPage> {
  HostelRoomsController controller = Get.put(HostelRoomsController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Hostel\n Room Here!',
      imageUrl: 'assets/projectImages/hostelpage.jpg',
      AppbarTitle: 'Hostel Room',
      widget: _buildChildWidget(),


    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future:  controller.fetchDataFuture,//controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            }
            else {

              return controller.hostelListModelObj.value.hostelarray!.length > 0 ? ListView.builder(
                itemCount: controller.hostelListModelObj.value.hostelarray!.length ,
                itemBuilder: (context, index) {
                  // return _buildLeaveCard();

                  return  _buildLeaveCard(
                    data: controller.hostelListModelObj.value.hostelarray![index],
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
                  ));

            }
          },
        );
      },
    );
  }

  Widget _buildLeaveCard({required Hostelarray data}) {
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
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    data.hostelName!,
                    //'{homework.} (Code)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  data.assign == 1 ? Text("Assigned") : SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'Room Type', value: data.roomType!),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'Room no.', value: data.roomNo!),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'No. of Bed', value: data.noOfBed!),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                      title: 'Cost per Bed', value: data.costPerBed!)
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
