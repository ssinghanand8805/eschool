import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/myCustomsd.dart';
import '../common_widgets/CommonForm.dart';
import '../common_widgets/controller/CommonApiController.dart';
import '../common_widgets/custom_loader.dart';

class CommonFilter extends StatefulWidget {
  final Function onTapAction;
  final Widget? widgetMain;
  const CommonFilter({Key? key, required this.onTapAction,required this.widgetMain}) : super(key: key);


  @override
  State<CommonFilter> createState() => _CommonFilterState();
}

class _CommonFilterState extends State<CommonFilter> {
  CommonApiController commonApiController =
  Get.put(CommonApiController());
  @override
  Widget build(BuildContext context) {
    return CommonForm(
        widgetFilterSelectedData: Row(
          children: [
            Text("Class :  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
            Text(commonApiController.selectedClassName.value + " ( " + commonApiController.selectedSectionName.value + " )",
                style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
            SizedBox(width: 20),

          ],
        ),
        widgetFilterData: Column(
          children: [
            Obx( () => MyCustomSD(

              hideSearch: true,
              borderColor: Colors.grey,
              listToSearch: commonApiController.classListModelMap.value,
              valFrom: "className",
              label: 'Class',
              labelText: 'Class',
              onChanged: (val) {
                if(commonApiController.classListModelMap.value.length > 0)
                {
                  print("5555555555555");

                  commonApiController.selectedClassId.value = val['id'].toString();
                  commonApiController.selectedClassName.value = val['className'].toString();
                  commonApiController.update();
                  commonApiController.getSectionList();
                }

              },
            )),
            SizedBox(
              height: 10,
            ),
            Obx( () => MyCustomSD(
              hideSearch: true,
              borderColor: Colors.grey,
              listToSearch: commonApiController.sectionListModelMap.value,
              valFrom: "section",
              label: 'Section',
              labelText: 'Section',
              onChanged: (val) {
                print(val);
                if(commonApiController.sectionListModelMap.value.length > 0)
                {


                  commonApiController.selectedSectionId.value = val['id'].toString();
                  commonApiController.selectedSectionName.value = val['section'].toString();
                  commonApiController.update();

                }

              },
            )),
            SizedBox(
              height: 10,
            ),

          ],
        ),
        widgetformData: Column(
          children:[
            SizedBox(height: 10,),
            Expanded(child: commonApiController.isLoadingStudentList.isTrue ? CustomLoader() :   widget.widgetMain ?? Container())
          ]
          ,),
        onTapAction: widget.onTapAction);
  }
}
