import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/student_timeline_controller.dart';
import 'model/TimeLine.dart';

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
    return GetBuilder(
      init: StudentTimeLineController(),
      builder: (_) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDataFuture;
            print("object");
          },
          child: FutureBuilder(
            future: controller.fetchDataFuture, //controller.getData(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CustomLoader(); // CustomLoader();
              } else {
                return controller.timeLineModelObj.value!.length > 0
                    ? timeLine(controller.timeLineModelObj.value!)
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
          ),
        );
      },
    );
  }

  Widget timeLine(List<TimeLine> data) {
    return ListView.builder(
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
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text(data[index].title!,
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
                            data[index].date!,
                            style: theme.textTheme.titleMedium!,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            data[index].description!,
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
                color: theme.primaryColor,
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
                  color: theme.primaryColor,
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
      itemCount: data.length,
    );
  }
}
