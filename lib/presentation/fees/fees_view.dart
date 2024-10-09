import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lerno/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/fees_controller.dart';
import 'feesRe.dart';
import 'model/fees_modal.dart';

class FeesPage extends StatefulWidget {
  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  FeesController controller = Get.put(FeesController());

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {


    return MainBody(
        label: 'Your Fees Details\n is Here!',
        imageUrl: 'assets/projectImages/feespage.jpeg',
        AppbarTitle: 'Fees',
        actionWidget : [Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeesReceiptScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
               backgroundColor: Colors.yellow.shade200,
              padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: Text(
              "Fees Receipt",
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 14,),
            ),
          ),
        )
        ],
        widget: _buildChildWidget());
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
              return controller.feesDataModal.value!.studentDueFee!.length > 0
                  ? Column(
                      children: [
                        _buildRouteCard(
                            data: controller.feesDataModal.value.grandFee!),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.feesDataModal.value!
                                    .studentDueFee!.length ??
                                0,
                            itemBuilder: (context, index) {
                              return controller.feesDataModal.value!
                                          .studentDueFee![index].fees!.length >
                                      0
                                  ? timeLine(
                                      data: controller.feesDataModal.value!
                                          .studentDueFee![index].fees,
                                    )
                                  : Center(
                                      child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/projectImages/no_data.png",
                                        ),
                                        Text("No data found!")
                                      ],
                                    ));
                            },
                          ),
                        ),
                        // Expanded(
                        //   child: transportFee(
                        //     data: controller.feesDataModal.value!.transportFees!,
                        //   ),
                        // )
                      ],
                    )
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
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildRouteCard({GrandFee? data}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
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
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  height: 35,
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  width: Get.width,
                  child: Text('Grand Total',
                      style: theme.textTheme.titleMedium!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
                ),
                SizedBox(height: 12.0),
                _buildGrandTotalTable(data: data)
              ],
            ),
          ),
        ),
        //timeLine(),
      ],
    );
  }

  Widget _buildGrandTotalTable({GrandFee? data}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: [
          TableRow(
            children: [
              TableCell(
                child: Text(
                  'Amount',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  'Discount',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  'Fine',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  'Paid',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
              TableCell(
                child: Text(
                  'Balance',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                  child: Text(
                '\Rs. ${data!.amount}',
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
              )),
              TableCell(
                  child: Text(
                ' \Rs. ${data.amountDiscount}',
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
              )),
              TableCell(
                  child: Text(
                ' \Rs. ${data.feeFine}',
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
              )),
              TableCell(
                  child: Text(
                ' \Rs. ${data.amountPaid}',
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
              )),
              TableCell(
                  child: Text(
                ' \Rs. ${data.amountRemaining}',
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget timeLine({List<Fees>? data}) {
    data?.sort((a, b) => a.status!.compareTo(b.status!));
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return new Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
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
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      height: 35,
                      decoration: BoxDecoration(
                          color: data![index].status == "paid" ? theme.primaryColor : Colors.red.shade100,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text( data![index].type!,
                          style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Fees Code',
                              value: data![index].code!),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Due Date',
                              value: data![index].dueDate!),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Amount',
                              value: "Rs ${data![index].amount!}"),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Fine',
                              value: "Rs  ${data![index].fineAmount!}"),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Discount',
                              value: "Rs ${data![index].totalAmountDiscount!}"),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Paid Amount',
                              value: "Rs ${data![index].totalAmountPaid!}"),
                          InfoRow(
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 13,
                              ),
                              style1: theme.textTheme.bodySmall!
                                  .copyWith(fontSize: 13),
                              title: 'Balance Amount ',
                              value:
                                  "Rs ${data![index].totalAmountRemaining!}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // new Positioned(
            //   top: 0.0,
            //   bottom: 0.0,
            //   left: 18.0,
            //   child: new Container(
            //     height: double.infinity,
            //     width: 5.0,
            //     color: Colors.green.shade100,
            //   ),
            // ),
            // new Positioned(
            //   top: 0.0,
            //   left: 0.0,
            //   child: new Container(
            //     height: 25.0,
            //     width: 40.0,
            //     decoration: new BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.green.shade200,
            //     ),
            //     child: new Container(
            //       child: Icon(Icons.location_on, size: 15),
            //       margin: new EdgeInsets.all(5.0),
            //       height: 15.0,
            //       width: 30.0,
            //     ),
            //   ),
            // )
          ],
        );
      },
      itemCount: data!.length,
    );
  }

  Widget transportFee({List<TransportFees>? data}) {
    return ListView.builder(
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return new Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    boxShadow: [
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
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      height: 35,
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text("Transport Fee",
                          style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                              title: 'Fees Code', value: data![index].month!),
                          InfoRow(
                              title: 'Due Date', value: data![index].dueDate!),
                          InfoRow(
                              title: 'Amount',
                              value: "Rs ${data![index].amountDetail!}"),
                          InfoRow(
                              title: 'Fine',
                              value: "Rs  ${data![index].fineAmount ?? ""}"),
                          InfoRow(
                              title: 'Discount',
                              value: "Rs ${data![index].totalAmountDiscount!}"),
                          InfoRow(
                              title: 'Paid Amount',
                              value: "Rs ${data![index].totalAmountPaid!}"),
                          InfoRow(
                              title: 'Balance Amount ',
                              value:
                                  "Rs ${data![index].totalAmountRemaining!}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // new Positioned(
            //   top: 0.0,
            //   bottom: 0.0,
            //   left: 18.0,
            //   child: new Container(
            //     height: double.infinity,
            //     width: 5.0,
            //     color: Colors.green.shade100,
            //   ),
            // ),
            // new Positioned(
            //   top: 0.0,
            //   left: 0.0,
            //   child: new Container(
            //     height: 25.0,
            //     width: 40.0,
            //     decoration: new BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.green.shade200,
            //     ),
            //     child: new Container(
            //       child: Icon(Icons.location_on, size: 15),
            //       margin: new EdgeInsets.all(5.0),
            //       height: 15.0,
            //       width: 30.0,
            //     ),
            //   ),
            // )
          ],
        );
      },
      itemCount: data!.length,
    );
  }
}
