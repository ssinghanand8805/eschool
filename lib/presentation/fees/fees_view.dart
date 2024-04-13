import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learnladder/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/fees_controller.dart';
import 'model/fees_modal.dart';

class FeesPage extends StatefulWidget {
  @override
  State<FeesPage> createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  FeesController controller = Get.put(FeesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: 'Your Fees Details\n is Here!',
        imageUrl: 'assets/projectImages/feespage.jpeg',
        AppbarTitle: 'Fees',
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
              return Column(
                children: [
                  _buildRouteCard(data: controller.feesDataModal.value.grandFee!),
                  ListView.builder(
                    itemCount: controller.feesDataModal.value!.studentDueFee!.length ?? 0,
                    itemBuilder: (context, index) {
                      return controller.feesDataModal.value!.studentDueFee![index].fees!.length > 0
                          ? timeLine(
                              data: controller.feesDataModal.value.studentDueFee,
                            )
                          : Center(
                              child: Image.asset(
                              "assets/projectImages/no_data.png",
                              height: 100,
                            ));
                    },
                  ),
                ],
              );
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildRouteCard({ GrandFee? data}) {
    return Column(
      children: [
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
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  width: Get.width,
                  child: Text(
                      'Grand Total',
                      style:  theme.textTheme.titleMedium!.copyWith(fontSize: 17,fontWeight: FontWeight.w600)
                  ),
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
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
              ),
              TableCell(
                child: Text(
                  'Discount',
                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
              ),
              TableCell(
                child: Text(
                  'Fine',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
              ),
              TableCell(
                child: Text(
                  'Paid',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
              ),
              TableCell(
                child: Text(
                  'Balance',
                  style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(child: Text('\$${data!.amount}',style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),)),
              TableCell(child: Text(' \$${data.amountDiscount}',style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),)),
              TableCell(child: Text(' \$${data.feeFine}',style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),)),
              TableCell(child: Text(' \$${data.amountPaid}',style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),)),
              TableCell(child: Text(' \$${data.amountRemaining}',style: theme.textTheme.titleMedium!.copyWith(fontSize: 13),)),
            ],
          ),
        ],
      ),
    );
  }
  Widget timeLine({List<StudentDueFee>? data}) {
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
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text(
                        'Class 3 Lump Sum-Admission Fees',
                        style:  theme.textTheme.titleMedium!.copyWith(fontSize: 17,fontWeight: FontWeight.w600)
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                              title: 'Fees Code',
                              value: "Admission fees"),
                          InfoRow(
                              title: 'Due Date',
                              value: "04/10/2023"),
                          InfoRow(
                              title: 'Amount',
                              value: "Rs 3000"),
                          InfoRow(
                              title: 'Fine',
                              value: "Rs 0"),
                          InfoRow(
                              title: 'Discount',
                              value: "Rs 100"),
                          InfoRow(
                              title: 'Paid Amount',
                              value: "Rs 2900"),
                          InfoRow(
                              title: 'Balance Amount ', value: "Rs 0"),
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
      itemCount: 10,
    );
  }
}
