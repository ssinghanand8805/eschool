import 'package:lerno/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:lerno/core/utils/common_utilities.dart';
import 'package:lerno/presentation/class_time_table/controller/class_time_table_controller.dart';
import 'package:lerno/presentation/homework/HomeworkScreen.dart';
import 'package:lerno/presentation/notice_board/model/NoticeBoard.dart';
import 'package:flutter_html/flutter_html.dart';
import '../common_widgets/CommonCard.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/viewPdf.dart';
import 'controller/fees_controller.dart';
import 'model/feesRe.dart';



class FeesReceiptScreen extends StatefulWidget {
  @override
  State<FeesReceiptScreen> createState() => _ClassTimeTableScreenState();
}

class _ClassTimeTableScreenState extends State<FeesReceiptScreen> {
  FeesController controller = Get.put(FeesController());


  @override
  void initState() {
    // TODO: implement initState

    controller.getFeesReceiptData();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Fees\n Receipt!',
      imageUrl: 'assets/projectImages/feespage.jpeg',
      AppbarTitle: 'Fees Receipt',
      widget: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FutureBuilder(
          future: controller.fetchDataFuture2, //controller.getData(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CustomLoader(); // CustomLoader();
            } else {
              return ListView.builder(
                itemCount:
                controller.feesReceiptModalObj.value.receipt!.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.feesReceiptModalObj.value.receipt!.length > 0
                      ? _buildTimeTableCard(
                    data:
                    controller.feesReceiptModalObj.value.receipt![index],
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
                },
              );
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required Receipt data}) {
    return CommonCard(
        title: data.id!,
        newWidget: Padding(
          padding: const EdgeInsets.only(left: 8.0,bottom: 8),
          child: Column(
            children: [
           InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
             fontSize: 13,
           ),
               style1: theme.textTheme.bodySmall!
                   .copyWith(fontSize: 13),title: "Fees Receipt No", value: data.feeRecieptNo!),
           InfoRow(   style: theme.textTheme.titleSmall!.copyWith(
             fontSize: 13,
           ),
               style1: theme.textTheme.bodySmall!
                   .copyWith(fontSize: 13),title: "Created Date", value: Utils.formatDateString(data.createdDate!)),
              InkWell(
                onTap: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DocumentViewerScreen(documentUrl: data.url!,)),
                  );

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("View Fees Receipt",style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 13,
                    ),),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Icon(Icons.remove_red_eye_sharp, color: Colors.blue,),
                    )
                  ],),
              ),

            ],
          ),
        ));
  }
}
