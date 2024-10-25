

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learnladderfaculity/core/app_export.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'custom_button.dart';


class AlertDialogue {



  show(context,
      {
        String? msg,
        String? firstButtonName,
        Function? firstButtonPressEvent,
        String?  secondButtonName,
        Function? secondButtonPressEvent,
        bool? showCancelButton,
        bool? showOkButton,
        bool? disableDuration,
        bool? checkIcon,
        List<Widget>? newWidget,
        String? title,
        String? subTitle,
      }
      ){
    var canPressOk=true;
    return WidgetsBinding.instance.addPostFrameCallback((_){

      showCupertinoModalBottomSheet(
        // isDismissible: true,
        shadow: BoxShadow(blurRadius: 0, color: newWidget==null? Colors.transparent:Colors.black12, spreadRadius: 0),
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black38,
        context: context,
        builder: (context) => newWidget!=null? ListView(
          shrinkWrap: true,
          //  physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Container(
                width: 200,
                height: 5,
                margin: const EdgeInsets.fromLTRB(0,10,0,10),
                decoration: const BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
            ),
            Container(
              decoration:  BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                  ),
                  border: Border.all(color: theme.primaryColorLight)
              ),
              child: Padding(
                padding:  EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: title!=null,
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(title.toString(),
                                  style: theme.textTheme.labelLarge,),
                                Visibility(
                                    visible: subTitle!=null,
                                    child: Text(subTitle.toString(),
                                        style: theme.textTheme.titleMedium)
                                ),
                              ],
                            ),
                          ),
                          IconButton(onPressed: (){
                            if(canPressOk)
                            {
                              canPressOk=false;
                              Navigator.pop(context);
                            }
                          }, icon: const Icon(Icons.clear,
                            color: Colors.black,))
                        ],
                      ),
                    ),


                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: newWidget,
                    ),
                  ],
                ),
              ),
            )
          ],
        ):
        ListView(
          shrinkWrap: true,
          children: [
            Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                    ),
                    border: Border.all(color: theme.primaryColorLight)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Container(
                    //     decoration: BoxDecoration(
                    //         color: AppColor.primaryColorDark,
                    //         borderRadius: BorderRadius.only(
                    //           topLeft: Radius.circular(10),
                    //           topRight: Radius.circular(10),
                    //         )
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             checkIcon?? false? Icons.check:Icons.info_outline,
                    //             color: Colors.white,
                    //           ),
                    //           SizedBox(width: 5,),
                    //           Expanded(
                    //             child: Text(alert.toString(),
                    //               style: MyTextTheme().mediumWCB),
                    //           ),
                    //         ],
                    //       ),
                    //     )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,0),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20,20,20,20),
                              child: Text(msg.toString(),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium)
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,20,0),
                            child: Row(
                              children: [
                                (showCancelButton?? false)?Expanded(
                                  child: Visibility(
                                    visible: showCancelButton?? false,
                                    child:   MyButton(
                                      color: theme.primaryColorLight,
                                      title: 'Cancel',
                                      onPress: (){
                                        if(canPressOk)
                                        {
                                          canPressOk=false;
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ),
                                ):Container(),
                                SizedBox(width: 20,),
                                (firstButtonName!=null)? Expanded(
                                  child: Visibility(
                                    visible: firstButtonName!=null,
                                    child: MyButton(
                                      color: theme.primaryColorLight,
                                      title: firstButtonName.toString(),
                                      onPress: (){
                                        if(canPressOk)
                                        {
                                          canPressOk=false;
                                          firstButtonPressEvent!();
                                        }
                                      },
                                    ),
                                  ),
                                ):Container(),

                                (showOkButton?? false)? Expanded(
                                  child: Visibility(
                                    visible: showOkButton?? false,
                                    child:   MyButton(
                                      color: theme.primaryColor,
                                      title: 'Ok',
                                      onPress: (){
                                        if(canPressOk)
                                        {
                                          canPressOk=false;
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ),
                                ):Container(),
                              ],
                            ),
                          ),



                          const SizedBox(height: 8,),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      );

    });


  }



}

alertToast(context,message){
  FocusScope.of(context).unfocus();
  Fluttertoast.showToast(
    msg: message,
  );
}



// class AlertDialogue2 {
//
//   show(context,
//       {
//
//         String? alert,
//         String? msg,
//         String? firstButtonName,
//         Function? firstButtonPressEvent,
//         String?  secondButtonName,
//         Function? secondButtonPressEvent,
//         bool? showCancelButton,
//         bool? showOkButton,
//         bool? disableDuration,
//         bool? checkIcon,
//         bool? hideIcon,
//         bool? centerTitle,
//         Widget? newWidget,
//         List<Widget>? fullScreenWidget,
//         String? title,
//         String? subTitle,
//       }
//       )  {
//     var canPressOk=true;
//     return WidgetsBinding.instance.addPostFrameCallback((_){
//
//       showGeneralDialog(
//           barrierColor: Colors.black.withOpacity(0.5),
//           transitionBuilder: (context, a1, a2, widget) {
//             return StatefulBuilder(
//                 builder: (context,setState)
//                 {
//                   return Transform.scale(
//                     scale: a1.value,
//                     child: Opacity(
//                       opacity: a1.value,
//                       child: WillPopScope(
//                         onWillPop: (){
//                           Navigator.pop(context);
//                           return Future.value(false);
//                         },
//                         child: SafeArea(
//                           child: Material(
//                             color: Colors.transparent,
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child:
//                               Container(
//                                 height: double.infinity,
//                                 width: double.infinity,
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       color: theme.primaryColorLight,
//                                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                                       border: Border.all(color: theme.primaryColorLight)
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ListView(
//                                       shrinkWrap: true,
//                                       children: [
//                                         Visibility(
//                                           visible: title!=null,
//                                           child: Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Column(
//                                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                                   children: [
//                                                     Text(title.toString(),
//                                                       style: theme.textTheme.titleMedium,),
//                                                     Visibility(
//                                                         visible: subTitle!=null,
//                                                         child: Text(subTitle.toString(),
//                                                           style: theme.textTheme.titleMedium,)
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               IconButton(onPressed: (){
//                                                 if(canPressOk)
//                                                 {
//                                                   canPressOk=false;
//                                                   Navigator.pop(context);
//                                                 }
//                                               }, icon: const Icon(Icons.clear,
//                                                 color: Colors.black,))
//                                             ],
//                                           ),
//                                         ),
//                                         ListView(
//                                           shrinkWrap: true,
//                                           physics: const NeverScrollableScrollPhysics(),
//                                           children: fullScreenWidget,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               )
//                                   :TabResponsive().wrapInTab(
//                                 context: context,
//                                 child: newWidget==null?
//                                 Container(
//                                   height: double.infinity,
//                                   width: double.infinity,
//                                   alignment: Alignment.center,
//
//                                   child: ListView(
//                                     shrinkWrap: true,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.fromLTRB(40,20,40,20),
//                                         child: Container(
//                                             decoration: const BoxDecoration(
//                                                 color: Colors.white,
//                                                 borderRadius: BorderRadius.all(Radius.circular(10))
//                                             ),
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Container(
//                                                     decoration: BoxDecoration(
//                                                         color: AppColor.primaryColor,
//                                                         borderRadius: const BorderRadius.only(
//                                                           topLeft: Radius.circular(10),
//                                                           topRight: Radius.circular(10),
//                                                         )
//                                                     ),
//                                                     child: Padding(
//                                                       padding: const EdgeInsets.all(8.0),
//                                                       child: Row(
//                                                         children: [
//                                                           Visibility(
//                                                             visible: !(hideIcon?? false),
//                                                             child: Icon(
//                                                               checkIcon?? false? Icons.check:Icons.info_outline,
//                                                               color: Colors.white,
//                                                             ),
//                                                           ),
//                                                           const SizedBox(width: 5,),
//                                                           Expanded(
//                                                             child: Text(alert.toString(),
//                                                               textAlign: (centerTitle?? false)?
//                                                               TextAlign.center
//                                                                   :TextAlign.start,
//                                                               style: const TextStyle(
//                                                                   color: Colors.white,
//                                                                   fontSize: 15
//                                                               ),),
//                                                           ),
//                                                           const SizedBox(width: 5,),
//                                                         ],
//                                                       ),
//                                                     )),
//                                                 Padding(
//                                                   padding: const EdgeInsets.fromLTRB(0,10,0,10),
//                                                   child: Column(
//                                                     children: [
//                                                       Padding(
//                                                         padding: const EdgeInsets.all(8.0),
//                                                         child: Text(msg.toString(),
//                                                           textAlign: TextAlign.start,
//                                                           style: const TextStyle(
//                                                               fontWeight: FontWeight.bold
//                                                           ),),
//                                                       ),
//                                                       Padding(
//                                                         padding: const EdgeInsets.fromLTRB(8,0,8,0,),
//                                                         child: Row(
//                                                           mainAxisAlignment: MainAxisAlignment.end,
//                                                           children: [
//                                                             Visibility(
//                                                               visible: showCancelButton?? false,
//                                                               child: TextButton(
//                                                                 style: TextButton.styleFrom(
//                                                                   foregroundColor: Colors.black,
//                                                                   padding: const EdgeInsets.all(8),
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   if(canPressOk)
//                                                                   {
//                                                                     canPressOk=false;
//                                                                     Navigator.pop(context);
//                                                                   }
//                                                                 },
//                                                                 child: Text(
//                                                                   'Cancel',
//                                                                   style: TextStyle(color: AppColor.primaryColor,
//                                                                       fontWeight: FontWeight.bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Visibility(
//                                                               visible: secondButtonName!=null,
//                                                               child: TextButton(
//                                                                 style: TextButton.styleFrom(
//                                                                   foregroundColor: Colors.black,
//                                                                   padding: const EdgeInsets.all(8),
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   if(canPressOk)
//                                                                   {
//                                                                     canPressOk=false;
//                                                                     secondButtonPressEvent!();
//                                                                   }
//                                                                 },
//                                                                 child: Text(
//                                                                   secondButtonName.toString(),
//                                                                   style: TextStyle(color: AppColor.primaryColor,
//                                                                       fontWeight: FontWeight.bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Visibility(
//                                                               visible: firstButtonName!=null,
//                                                               child: TextButton(
//                                                                 style: TextButton.styleFrom(
//                                                                   foregroundColor: Colors.black,
//                                                                   padding: const EdgeInsets.all(8),
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   if(canPressOk)
//                                                                   {
//                                                                     canPressOk=false;
//                                                                     firstButtonPressEvent!();
//                                                                   }
//                                                                 },
//                                                                 child: Text(
//                                                                   firstButtonName.toString(),
//                                                                   style: TextStyle(color: AppColor.primaryColor,
//                                                                       fontWeight: FontWeight.bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Visibility(
//                                                               visible: showOkButton?? true,
//                                                               child: TextButton(
//                                                                 style: TextButton.styleFrom(
//                                                                   foregroundColor: Colors.black,
//                                                                   padding: const EdgeInsets.all(8),
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   if(canPressOk)
//                                                                   {
//                                                                     canPressOk=false;
//                                                                     Navigator.pop(context);
//                                                                   }
//                                                                 },
//                                                                 child: Text(
//                                                                   'Ok',
//                                                                   style: TextStyle(color: AppColor.primaryColor,
//                                                                       fontWeight: FontWeight.bold),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             )),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//
//                                     :Container(
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.bgColor,
//                                       borderRadius: const BorderRadius.all(Radius.circular(20)),
//                                       border: Border.all(color: AppColor.greyLight)
//                                   ),
//                                   child: newWidget,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 });
//           },
//           transitionDuration: const Duration(milliseconds: 200),
//           barrierDismissible: true,
//           barrierLabel: '',
//           context: context,
//           pageBuilder: (context, animation1, animation2) {
//             return Container();
//           }).then((val){
//         canPressOk=false;
//       });
//
//     });
//   }
//
//
//
// }