import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lerno/core/app_export.dart';

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
              return controller.transportRouteModal.value!.pickupPoint!.length>0? ListView(
                children: [
                  _buildRouteCard(
                    data: controller.transportRouteModal.value!.route!,
                  ),
                  timeLine( data: controller.transportRouteModal.value!.pickupPoint!)
                  // ListView.builder(
                  //   itemCount: controller.transportRouteModal.value.pickupPoint!.length ?? 0,
                  //   itemBuilder: (context, index) {
                  //     return controller.transportRouteModal.value.pickupPoint!.length > 0
                  //         ? timeLine( data: controller.transportRouteModal.value!.pickupPoint![index])
                  //         : Center(
                  //             child: Image.asset(
                  //             "assets/projectImages/no_data.png",
                  //             height: 100,
                  //           ));
                  //   },
                  // ),
                ],
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
              ;
            }
          },
        );
      },
    );
  }

  Widget _buildRouteCard({required RouteData data}) {
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
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Route Title:',
                      value: "${data.routeTitle}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Vehicle Number:',
                      value: "${data.vehicleNo}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Vehicle Model:',
                      value: "${data.vehicleModel}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Driver Name:',
                      value: "${data.driverName}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Driver Contact:',
                      value: "${data.driverContact}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Driver Licence:',
                      value: "${data.driverLicence}"),
                  InfoRow(
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 13),
                      style1: theme.textTheme.bodySmall!.copyWith(fontSize: 13),
                      title: 'Made: ', value: "${data.manufactureYear}"),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  Widget timeLine({required List<PickupPoint> data}) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length,
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
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      width: Get.width,
                      child: Text(
                        data[index].pickupPoint!,
                        style:  theme.textTheme.titleMedium!.copyWith(fontSize: 15,fontWeight: FontWeight.w600)
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.location_on,),
                        SizedBox(width: 8.0),
                        Text("Distance(km)"),
                        SizedBox(width: 8.0),
                        Text(data[index].destinationDistance!,style:  theme.textTheme.titleMedium!,),
                      ],
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        SizedBox(width: 8.0),
                        Text("Pickup Time"),
                        SizedBox(width: 8.0),
                        Text(data[index].pickupTime!,style:  theme.textTheme.titleMedium!,),
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

    );
  }
}
