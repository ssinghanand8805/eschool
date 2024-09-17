import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class MainBody extends StatelessWidget {
  final String label;
  final String imageUrl;
  final String AppbarTitle;
  final Widget widget;
  final List<Widget>? actionWidget;
  final Widget? floatingActionButton;

  const MainBody({
    Key? key,
    required this.label,
    required this.imageUrl,
    required this.AppbarTitle,
    required this.widget,
     this.actionWidget,
     this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
     backgroundColor: Colors.green.shade100,
      appBar: AppBar(
        actions:  actionWidget?? [],
        backgroundColor: Colors.green.shade100,
        title: Text(AppbarTitle,style: theme.textTheme.titleLarge!.copyWith(fontSize: 17),),
      ),
      body: Container(

        decoration: BoxDecoration(
             color: Colors.white,
         borderRadius: BorderRadius.only(
             topRight: Radius.circular(20),
             topLeft: Radius.circular(20),
         )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  label,
               style: theme.textTheme.titleLarge!.copyWith(     fontSize: 17.0,
                 fontWeight: FontWeight.w600,)


                ),
                Image.asset(
                  imageUrl,
                  width: 150.0,
                  height: 100.0,
                ),
              ],
            ),

            Expanded(
              child: widget,
            ),
          ],
        ),
      ),
     floatingActionButton: floatingActionButton,

    );
  }
}