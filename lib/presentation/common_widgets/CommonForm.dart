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
  CommonForm({Key? key, required this.widgetFilterData, required this.widgetformData,  this.widgetFilterSelectedData, required this.onTapAction }) : super(key: key);
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
                width: 100,
                title: 'Search',

                color: Colors.green,
                onPress: () {

                  widget.onTapAction();
                  controller2.isSearchExpand.value = true;
                  controller2.update();
                },
              ),
            )  : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.widgetFilterSelectedData != null ? widget.widgetFilterSelectedData! : SizedBox(),
                Button(icon: Icons.sort, onTap: () {
                  controller2.isSearchExpand.value = false;
                  controller2.update();
                }, text: 'Filter'

                ),
              ],
            ),

            Expanded(child: widget.widgetformData)
          ],
        ),
      ),


    );
  }

}
