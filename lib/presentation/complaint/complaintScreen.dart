import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/apply_leave/uploadLeave.dart';

import '../../core/utils/common_utilities.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import '../homework/viewPdf.dart';
import 'addComplaint.dart';
import 'controller/complaintController.dart';
import 'model/complaintModal.dart';
import 'model/getComplaintData.dart';

class ComplaintsPage extends StatefulWidget {
  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  ComplaintController controller = Get.put(ComplaintController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  controller.getComplaintData();
  }


  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Applied\nComplaint!',
      imageUrl: 'assets/projectImages/leavepage.jpg',
      AppbarTitle: 'Complaint',
      widget: _buildChildWidget(),
      floatingActionButton: Container(
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          focusColor: Colors.green.shade500,
          backgroundColor: Colors.green.shade500,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddComplaintPage()),
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
              return ListView.builder(
                itemCount:
                controller.complaintDataList.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.complaintDataList.length > 0
                      ? _buildTimeTableCard(
                    data:
                    controller.complaintDataList[index],
                  )
                      : Center(
                      child: Image.asset(
                        "assets/projectImages/no_data.png",
                        height: 100,
                      ));
                },
              );
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required ComplaintData data}) {
    return CommonCard(
        title: data.complaintType!,
        newWidget: Padding(
          padding: const EdgeInsets.only(left: 8.0,bottom: 8),
          child: Column(
            children: [
              InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 13,
              ),
                  style1: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13),title: "Name", value: data.name!.capitalize!),   InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 13,
              ),
                  style1: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13),title: "Contact", value: data.contact!),
              InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 13,
              ),
                  style1: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13),title: "Complaint Date", value: Utils.formatDateString(data.date!)),

              InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 13,
              ),
                  style1: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13),title: "Description", value: data.description!),  InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
                fontSize: 13,
              ),
                  style1: theme.textTheme.bodySmall!
                      .copyWith(fontSize: 13),title: "Action Taken", value: data.actionTaken!),

            ],
          ),
        ));
  }
}
