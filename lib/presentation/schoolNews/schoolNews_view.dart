import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/library/model/IssuedBook.dart';

import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/schoolNews_controller.dart';
import 'model/IssuedBook.dart';

class SchoolNewsPage extends StatefulWidget {
  @override
  State<SchoolNewsPage> createState() => _SchoolNewsPageState();
}

class _SchoolNewsPageState extends State<SchoolNewsPage> {
  schoolNewsController controller = Get.put(schoolNewsController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your School\nNews is Here!',
      imageUrl: 'assets/projectImages/noticepage.png',
      AppbarTitle: 'School News',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture, //controller.getData(context),
          builder: (context, snapshot) {

            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/projectImages/no_data.png",
                    ),
                    Text("No data found!")
                  ],
                ));
            // if (snapshot.connectionState != ConnectionState.done) {
            //   return CustomLoader(); // CustomLoader();
            // } else {
            //   return controller.issuedBookModelObj.value!.length > 0
            //       ? ListView.builder(
            //           itemCount:
            //               controller.issuedBookModelObj.value?.length ?? 0,
            //           itemBuilder: (context, index) {
            //             return _buildTimeTableCard(
            //                 data: controller.issuedBookModelObj.value![index]);
            //           },
            //         )
            //       : Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Image.asset(
            //             "assets/projectImages/no_data.png",
            //           ),
            //           Text("No data found!")
            //         ],
            //       ));
            // }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required SchoolNews data}) {
    print("object${data.isReturned.toString()}");
    return CommonCardExtended(
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: _getStatusColor(data.isReturned.toString())),
        title: data.bookTitle!,
        leadingWidget: SizedBox(),
        subtitle:
            data.isReturned.toString() == "0" ? "Not Returned" : "Returned",
        newWidget: _buildLeaveCard(data: data));
  }

  Widget _buildLeaveCard({required SchoolNews data}) {
    return Column(
      children: [
        InfoRow(
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            title: "Author",
            value: data.author!),
        InfoRow(
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            title: "Book No.",
            value: data.bookNo!),
        InfoRow(
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            title: "Issue Date",
            value: data.issueDate!),
        InfoRow(
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13,),
            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            title: "Author",
            value: data.returnDate == null ? "" : data.returnDate.toString()),
        InfoRow(
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
            style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
            title: "Due Return Date",
            value: data.dueReturnDate == null
                ? ""
                : data.dueReturnDate.toString()),
      ],
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains('1')) {
      return Colors.green;
    } else if (status.contains('0')) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }
}
