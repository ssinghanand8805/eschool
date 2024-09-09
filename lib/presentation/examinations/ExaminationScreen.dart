import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/apply_leave/uploadLeave.dart';
import 'package:lerno/presentation/examinations/model/Examination.dart';

import '../apply_leave/model/ApplyLeave.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';

import 'controller/ExaminationController.dart';


class ExaminationPage extends GetView<ExaminationController> {

  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your \nExaminations is\nhere!',
      imageUrl: 'assets/projectImages/examinationpage.jpg',
      AppbarTitle: 'Examinations',
      widget: GetBuilder(
        init: controller,
        builder: (_){
          return _buildChildWidget();
        },
      ),
    );
  }

  Widget _buildChildWidget() {

  return  GetBuilder(
      init: controller,
      builder: (_) {
        return RefreshIndicator(
          onRefresh:  controller.refreshDataVideo,
          child: FutureBuilder(
            future: controller.fetchDataFuture, //controller.getData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              } else {
                return controller.examListObj.value.examSchedule!.length>0?ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index){
                      return _buildExamCard(controller.examListObj.value.examSchedule![index]);
                    },
                    separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 0,),
                    itemCount: controller.examListObj.value.examSchedule!.length
                ):Center(
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
          ),
        );
      },
    );

  }

  Widget _buildExamCard(ExamSchedule data) {
    // return Text(data.applyDate!);
    print("DATA @@ ${data.exam}");
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.all(15),
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
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.exam.toString(),
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),),
            Text(data.exam.toString(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),),
            SizedBox(height: 10,),
            cardButtons()
          ],
        )
      ),
    );
  }



  Widget cardButtons(){
    return Row(
      children: [
        Container(
          child: Text("Exam Schedule",
            style: TextStyle(
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w600
            ),),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.red,width: 2),
            borderRadius: BorderRadius.circular(20)
          ),
        ),
        SizedBox(width: 10,),
        InkWell(
          onTap: (){
            Get.toNamed(AppRoutes.exam_result_view);
          },
          child: Container(
            child: Text("Exam Result",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
              ),),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.green,width: 2),
                borderRadius: BorderRadius.circular(20)
            ),
          ),
        ),
      ],
    );
  }
}
