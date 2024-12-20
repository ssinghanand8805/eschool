import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_button.dart';
import 'controller/CommonController.dart';

class CommonForm extends StatefulWidget {
  final Widget widgetFilterData;
  final  Widget widgetformData;
  final  Widget? widgetFilterSelectedData;
  final Function onTapAction;
  final bool isFilterLoading;
  CommonForm({Key? key, required this.widgetFilterData, required this.widgetformData,  this.widgetFilterSelectedData, required this.onTapAction,this.isFilterLoading = false }) : super(key: key);
  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  CommonController controller2 =
  Get.put(CommonController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx( () =>  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller2.isSearchExpand.isFalse?   widget.widgetFilterData : SizedBox(),
            controller2.isSearchExpand.isFalse ?  Align(
              alignment: Alignment.topRight,
              child: MyButton(
                isLoading: widget.isFilterLoading,
                width: 100,
                title: 'Search',

                color: Colors.green,
                onPress: () {

                  widget.onTapAction();
                  controller2.isSearchExpand.value = true;
                  controller2.update();
                },
              ),
            )  :
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                widget.widgetFilterSelectedData != null ? widget.widgetFilterSelectedData! : SizedBox(),
                  SizedBox(
                    width: 100,
                    child: MyButton(title: "Filter",

                      color: Colors.green,
                      isLoading:widget.isFilterLoading,
                      prefixIcon: Icon(Icons.sort),
                      onPress: () {
                        controller2.isSearchExpand.value = false;
                        controller2.update();
                      },),
                  ),
                ],
              ),
            ),

            Expanded(child: widget.widgetformData)
          ],
        ),
      ),


    );
  }

}
