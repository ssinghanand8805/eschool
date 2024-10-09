import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/theme_helper.dart';

Widget CommonCardExtended(
    {required String title,
    required Widget newWidget,
    required Widget leadingWidget,
     bool? bottomTitle,
      Widget? bottomTitleWidget,
    String? subtitle,
    TextStyle? style}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(boxShadow: [
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
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: Get.width,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ListTile(leading: Icon(Icons.bookmark_added_outlined,size: 5,),title: Text(title),),
                leadingWidget,
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    title.capitalize!,
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Spacer(),
                Text(
                  subtitle ?? '',
                  style: style == false
                      ? theme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.w600, fontSize: 13)
                      : style,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 5),
            child: newWidget,
          ),
          bottomTitle == true?Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: theme.primaryColorLight,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            width: Get.width,
            child: bottomTitleWidget
          ):SizedBox(),
        ],
      ),
    ),
  );
}
