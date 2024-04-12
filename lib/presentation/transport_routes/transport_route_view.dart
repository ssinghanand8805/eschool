import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/transport_route_controller.dart';

class TransportRoutesPage extends StatefulWidget {
  @override
  State<TransportRoutesPage> createState() => _TransportRoutesPageState();
}

class _TransportRoutesPageState extends State<TransportRoutesPage> {
  TransportRoutesController controller = Get.put(TransportRoutesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getData();
  }
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Transport\n Route Here!',
      imageUrl: 'assets/projectImages/noticepage.png',
      AppbarTitle: 'Transport Route',
      widget: _buildChildWidget(),


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
                    "Maxwell",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InfoRow(title: 'Purpose', value: "Parent Teacher Meeting"),
                  InfoRow(title: 'Phone', value: "08958565457"),
                  InfoRow(title: 'Id Card', value: '0884555'),
                  InfoRow(title: 'No. of Person', value: '4'),
                  InfoRow(title: 'Date', value: '04/08/2024'),
                  InfoRow(title: 'In Time', value: '10:30 pm'),
                  InfoRow(title: 'Out Time', value: '11:30 am'),
                  InfoRow(title: 'Note', value: ''),
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
