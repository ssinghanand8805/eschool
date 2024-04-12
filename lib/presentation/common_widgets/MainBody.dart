import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class MainBody extends StatelessWidget {
  final String label;
  final String imageUrl;
  final String AppbarTitle;
  final Widget widget;
  final Widget? floatingActionButton;

  const MainBody({
    Key? key,
    required this.label,
    required this.imageUrl,
    required this.AppbarTitle,
    required this.widget,
     this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      appBar: AppBar(
        title: Text(AppbarTitle,style: theme.textTheme.titleMedium,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
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
     floatingActionButton: floatingActionButton,

    );
  }
}