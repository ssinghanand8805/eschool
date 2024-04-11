import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget CommonCardExtended({
  required String title,required Widget newWidget,required Widget leadingWidget,required String subtitle
}) {
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
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 2),
            height: 30,
            decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            width: Get.width,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ListTile(leading: Icon(Icons.bookmark_added_outlined,size: 5,),title: Text(title),),
                leadingWidget,
                Text(title,style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),),
                Spacer(),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 5),
            child: newWidget,
          ),
        ],
      ),
    ),
  );
}