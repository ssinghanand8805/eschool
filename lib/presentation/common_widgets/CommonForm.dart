import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/button.dart';
import 'controller/CommonController.dart';

class CommonForm extends StatefulWidget {
  final Widget widgetFilterData;
  final  Widget widgetformData;
  final Function onTapAction;
  CommonForm({Key? key, required this.widgetFilterData, required this.widgetformData,required this.onTapAction }) : super(key: key);
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
            controller2.isSearchExpand.isFalse ?  GestureDetector(
              onTap: () {

                widget.onTapAction();
                // controller2.isSearchExpand.value = true;
                // controller2.update();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 32,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8.0),
                        Text('Search', style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),
                ),
              ),
            )  : Button(icon: Icons.search, onTap: () {
              // controller2.isSearchExpand.value = false;
              // controller2.update();
            }, text: 'Search'

            ),

            Expanded(child: widget.widgetformData)
          ],
        ),
      ),


    );
  }

}
