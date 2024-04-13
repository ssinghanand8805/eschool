import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnladder/core/app_export.dart';

import '../common_widgets/MainBody.dart';
import '../common_widgets/custom_loader.dart';
import '../homework/HomeworkScreen.dart';
import 'controller/transport_route_controller.dart';
import 'model/transport_route_modal.dart';

class TransportRoutesPage extends StatefulWidget {
  @override
  State<TransportRoutesPage> createState() => _TransportRoutesPageState();
}

class _TransportRoutesPageState extends State<TransportRoutesPage> {
  TransportRoutesController controller = Get.put(TransportRoutesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
        label: 'Your Transport\n Route Here!',
        imageUrl: 'assets/projectImages/bus.png',
        AppbarTitle: 'Transport Route',
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
              return ListView.builder(
                itemCount: controller.transportRouteModal.length ?? 0,
                itemBuilder: (context, index) {
                  return controller.transportRouteModal.length > 0
                      ? _buildRouteCard(
                          data: controller.transportRouteModal.value[index],
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

  Widget _buildRouteCard({required TransportRoutesModal data}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
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
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                      title: 'Route Title:',
                      value: "${data.route!.routeTitle}"),
                  InfoRow(
                      title: 'Vehicle Number:',
                      value: "${data.route!.vehicleNo}"),
                  InfoRow(
                      title: 'Vehicle Model:',
                      value: "${data.route!.vehicleModel}"),
                  InfoRow(
                      title: 'Driver Name:',
                      value: "${data.route!.driverName}"),
                  InfoRow(
                      title: 'Driver Contact:',
                      value: "${data.route!.driverContact}"),
                  InfoRow(
                      title: 'Driver Licence:',
                      value: "${data.route!.driverLicence}"),
                  InfoRow(
                      title: 'Made: ', value: "${data.route!.manufactureYear}"),
                ],
              ),
            ),
          ),
        ),
        timeLine(),
      ],
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
                height: 150.0,
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
                        'Title',
                        style:  theme.textTheme.titleMedium!.copyWith(fontSize: 18,fontWeight: FontWeight.w600)
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        SizedBox(width: 8.0),
                        Text('Text with icon',style:  theme.textTheme.titleMedium!,),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 8.0),
                        Text('Text with icon',style:  theme.textTheme.titleMedium!,),
                      ],
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
                  child: Icon(Icons.location_on, size: 15),
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
