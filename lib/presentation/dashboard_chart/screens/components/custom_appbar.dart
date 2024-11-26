import 'package:flutter/material.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/profile_info.dart';
import 'package:learnladderfaculity/presentation/dashboard_chart/screens/components/search_field.dart';

import '../../constants/constants.dart';
import '../../constants/responsive.dart';


class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu,color: textColor.withOpacity(0.5),),
          ),
        Expanded(child: SearchField()),
        ProfileInfo()
      ],
    );
  }
}
