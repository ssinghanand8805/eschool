import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/student_timeline_controller.dart';

class StudentTimeLinePage extends StatefulWidget {
  @override
  State<StudentTimeLinePage> createState() => _StudentTimeLinePageState();
}

class _StudentTimeLinePageState extends State<StudentTimeLinePage> {
  StudentTimeLineController controller = Get.put(StudentTimeLineController());
  @override
  Widget build(BuildContext context) {
    return MainBody(
      label: 'Your Timeline is\nHere!',
      imageUrl: 'assets/projectImages/timelinepage.jpg',
      AppbarTitle: 'Student Timeline',
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
        return timeLine();

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

  Widget timeLine() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return new Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 15, bottom: 15),
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
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text('Show Your\nConnectedness',
                          style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12.0),
                          Text(
                            '04/05/2021',
                            style: theme.textTheme.titleMedium!,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            'Groups you join appear at the bottom of your profile. Joining some shows that you want to engage in professional communities and learn the lingo. Start with your university and industry groups.',
                            style: theme.textTheme.titleMedium!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 18.0,
              child: new Container(
                height: double.infinity,
                width: 5.0,
                color: Colors.green.shade100,
              ),
            ),
            new Positioned(
              top: 0.0,
              left: 0.0,
              child: new Container(
                height: 25.0,
                width: 40.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.shade200,
                ),
                child: new Container(
                  child: Image.asset(
                    'assets/projectImages/ic_clock.jpg',
                  ),
                  margin: new EdgeInsets.all(5.0),
                  height: 15.0,
                  width: 30.0,
                ),
              ),
            )
          ],
        );
      },
      itemCount: 10,
    );
  }
}
