import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:textfield_search/textfield_search.dart';

import '../../widgets/customTextField.dart';
import '../../widgets/myCustomsd.dart';
import 'controller/CommonUserSelectionController.dart';

class CommonUserSelection extends GetView<CommonUserSelectionController> {
  CommonUserSelection({Key? key}) : super(key: key,);

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Column(
      children: [
        MyCustomSD(
          hideSearch: true,
          borderColor: Colors.grey,
          listToSearch:
          controller.userTypeList.value,
          valFrom: "name",
          label: 'User Type',
          labelText: 'User Type',
          initialValue: [
            {
              'parameter': 'id',
              'value': controller.selectedUserType.value!
            }
          ],
          onChanged: (val) {
            if (controller.userTypeList.value
                .length >
                0) {
              print("5555555555555");

              controller.selectedUserType.value =
                  val['id'].toString();

              controller.update();
            }
          },
        ),
        SizedBox(height: 10,),
          Obx(() =>   Visibility(
            visible:  controller.selectedUserType == "group",
            child: MyCustomSD(
              hideSearch: true,
              multiSelect: true,
              borderColor: Colors.grey,
              listToSearch:
              controller.groupList.value,
              valFrom: "name",
              label: 'Group',
              labelText: 'Group',
              initialValue: [
                {
                  'parameter': 'id',
                  'value': controller.selectedGroup.value!
                }
              ],
              onChanged: (val) {
                if (controller.groupList.value
                    .length >
                    0) {
                  print("5555555555555");
                  print(jsonDecode(val));
                  var data = jsonDecode(val);
                  controller.selectedGroup.value =
                      data.map((map) => map['id'].toString()).toList();;

                  controller.update();
                }
              },
            ),
          ) ) ,
        SizedBox(height: 10,),
          Obx(() =>   Visibility(
            visible:  controller.selectedUserType == "class",
            child:  Row(
              children: [
                Expanded(
                  child: MyCustomSD(

                    hideSearch: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.classListModelMap.value,
                    valFrom: "className",
                    label: 'Class',
                    labelText: 'Class',
                    onChanged: (val) {
                      if(controller.classListModelMap.value.length > 0)
                      {
                        print("5555555555555");

                        controller.selectedClassId.value = val['id'].toString();
                        controller.selectedClassName.value = val['className'].toString();
                        controller.update();
                        controller.getSectionList();
                      }

                    },
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: MyCustomSD(
                    hideSearch: true,
                    multiSelect: true,
                    borderColor: Colors.grey,
                    listToSearch: controller.sectionListModelMap.value,
                    valFrom: "section",
                    label: 'Section',
                    labelText: 'Section',
                    onChanged: (val) {
                      print(val);
                      if(controller.sectionListModelMap.value.length > 0)
                      {


                        var data = jsonDecode(val);
                        controller.selectedClassSectionId.value =
                            data.map((map) => map['id'].toString()).toList();;

                        controller.update();

                        controller.update();

                      }

                    },
                  ),
                )
              ],
            ),
          ) ) ,
        SizedBox(height: 10,),
        Obx(() =>   Visibility(
          visible:  controller.selectedUserType == "individual",
          child:  Column(
            children: [
              MyCustomSD(

                hideSearch: true,
                borderColor: Colors.grey,
                listToSearch: controller.searchGroupList.value,
                valFrom: "name",
                label: 'Category',
                labelText: 'Category',
                onChanged: (val) {
                  if(controller.searchGroupList.value.length > 0)
                  {
                    print("5555555555555");

                    controller.selectedCategory.value = val['id'].toString();
                   controller.slectedCategoryType.value = val['name'].toString();
                    controller.getUserList();
                    controller.update();
                    //controller.getSectionList();
                  }

                },
              ),
              SizedBox(height: 10,),
              Visibility(
                visible: controller.slectedCategoryType.value != "" && controller.userList.value.length > 0,
                child: MyCustomSD(

                  hideSearch: false,
                  multiSelect: true,
                  borderColor: Colors.grey,
                  listToSearch: controller.userList.value.map((item) {
                    return item.toJson();
                  }).toList(),
                  valFrom: "name",
                  label: 'Select ' + controller.slectedCategoryType.value,
                  labelText: controller.slectedCategoryType.value,
                  onChanged: (val) {
                    if(controller.userList.value.length > 0)
                    {
                      var a= jsonDecode(val);
                      print("5555555555555${a}");

                      for(var i =0;i<a.length;i++)
                        {
                          UserItem user=     UserItem.fromJson(a[i]);
                          controller.selectedUserList.add(user);
                        }

                     // controller.selectedCategory.value = val['id'].toString();
                      // controller.selectedClassName.value = val['className'].toString();
                      controller.update();
                      //controller.getSectionList();
                    }

                  },
                ),
              ),

            ],
          ),
        ) ) ,
      ],
    );
  }

}