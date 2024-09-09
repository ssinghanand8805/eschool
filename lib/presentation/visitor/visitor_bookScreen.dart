import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/visitor_book_Controller.dart';
import 'model/Visitor.dart';

class VisitorBookPage extends StatefulWidget {
  @override
  State<VisitorBookPage> createState() => _VisitorBookPageState();
}

class _VisitorBookPageState extends State<VisitorBookPage> {
  VisitorBookController controller = Get.put(VisitorBookController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Visitor\n Book Here!',
      imageUrl: 'assets/projectImages/noticepage.png',
      AppbarTitle: 'Visitor Book',
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

    return controller.visitorModelObj.value.result!.length > 0 ? ListView.builder(
      itemCount: controller.visitorModelObj.value.result!.length ,
      itemBuilder: (context, index) {
        // return _buildLeaveCard();

        return  _buildLeaveCard(
        data: controller.visitorModelObj.value.result![index],
        );
                },
              ) : Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/projectImages/no_data.png"),
                  Text("No data found!")
                ],
              ));

            }
          },
        );
      },
    );
  }

  Widget _buildLeaveCard({required Result data}) {
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
                    data.name!,
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
                  InfoRow(title: 'Purpose', value: data.purpose!),
                  InfoRow(title: 'Phone', value: data.contact!),
                  InfoRow(title: 'Id Card', value: data.idProof!),
                  InfoRow(title: 'No. of Person', value: data.noOfPeople!),
                  InfoRow(title: 'Date', value: data.date!),
                  InfoRow(title: 'In Time', value: data.inTime!),
                  InfoRow(title: 'Out Time', value: data.outTime!),
                  InfoRow(title: 'Note', value: data.note!),
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
