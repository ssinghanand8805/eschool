import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../theme/theme_helper.dart';

class CommingSoon extends StatelessWidget {
  CommingSoon({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
         // backgroundColor: Colors.green.shade100,
          // title: Text(
          //   'Assessment List',
          //   style: theme.textTheme.titleLarge,
          // ),

        ),
        body: Center(child: Lottie.asset("assets/images/comingsoon.json")));
  }
}
