import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';
import 'package:lerno/presentation/library/model/IssuedBook.dart';

import '../common_widgets/CommonCardExtended.dart';
import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../daily_assignment/model/student_Subject.dart';
import '../homework/HomeworkScreen.dart';
import '../homework/viewPdf.dart';
import 'controller/classWork_controller.dart';
import 'model/classWork.dart';

class ClassWorkView extends StatefulWidget {
  @override
  State<ClassWorkView> createState() => _ClassWorkViewState();
}

class _ClassWorkViewState extends State<ClassWorkView> {
  ClassWorkController controller = Get.put(ClassWorkController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Class Work'),
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () => controller.selectDate(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  // Access the formatted date from the controller
                  return Text(
                    "Date: ${controller.formattedDate}",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 14),
                  );
                }),
                Container(
                  height: 35,
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(50)),
                  child: GetBuilder(
                    init: controller,
                    builder: (_) => FutureBuilder(
                        future: controller.fetchDataFutureForSubjects,
                        builder: (_, snanpshot) {
                          if (snanpshot.connectionState !=
                              ConnectionState.done) {
                            return CircularProgressIndicator();
                          } else {
                            return DropdownButton<Subjectlist>(
                              value: controller.currentSelectedSubject.value
                                          .subjectId ==
                                      null
                                  ? controller.studentSubjectsModelObj.value
                                      .subjectlist![0]
                                  : controller.currentSelectedSubject.value,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              onChanged: (Subjectlist? newValue) {
                                controller.currentSelectedSubject.value =
                                    newValue!;
                                // controller.update();
                                controller.currentSelectedSubejectId.value =
                                    controller.currentSelectedSubject.value!
                                        .subjectId!;
                                controller.update();
                                controller.getData(
                                    selectedDate:
                                        controller.selectedDate.value);
                              },
                              items: <DropdownMenuItem<Subjectlist>>[
                                if (controller.studentSubjectsModelObj !=
                                        null &&
                                    controller.studentSubjectsModelObj.value !=
                                        null &&
                                    controller.studentSubjectsModelObj.value
                                            .subjectlist !=
                                        null)
                                  ...controller.studentSubjectsModelObj!.value!
                                      .subjectlist!
                                      .map<DropdownMenuItem<Subjectlist>>(
                                          (Subjectlist value) {
                                    return DropdownMenuItem<Subjectlist>(
                                      value: value,
                                      child: Text(value.name!,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors
                                                  .red)), // Assuming 'name' is the display property
                                    );
                                  }),
                              ],
                            );
                          }
                        }),
                  ),
                ),
              ],
            ),
            Expanded(child: _buildChildWidget()),
          ],
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
              return controller.classWorkModelObj.length > 0
                  ? ListView.builder(
                      itemCount: controller.classWorkModelObj.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildTimeTableCard(
                                data: controller.classWorkModelObj[index]),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/projectImages/no_data.png"),
                        Text("No data found")
                      ],
                    ));
            }
          },
        );
      },
    );
  }

  Widget _buildTimeTableCard({required ClassWorkList data}) {
    return CommonCardExtended(
        title: data.subjectName.toString(),
        leadingWidget: SizedBox(),
        newWidget: _buildLeaveCard(data: data));
  }

  Widget _buildLeaveCard({required ClassWorkList data}) {
    final String htmlContent = data.description!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Classwork Date", style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),),
              Text(data.classworkDate ??""),
            ],),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DocumentViewerScreen(documentUrl: data.document.toString(),)),
              );

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Document", style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),),
                Text(data.document ??""),
                Icon(Icons.remove_red_eye_sharp, color: Colors.blue,)
              ],),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Description",style: theme.textTheme.titleSmall!.copyWith(fontSize: 14),),
              Flexible(
                //padding: const EdgeInsets.all(8.0),
                child: Html( data: "${data.description}"),),
              //  Html( data: "${data.description}"),
            ],
          ),
        ],
      ),
    );
  }
}
