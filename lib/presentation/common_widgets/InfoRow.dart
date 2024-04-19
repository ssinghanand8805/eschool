import 'package:flutter/material.dart';

import '../../theme/theme_helper.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;
  TextStyle? style;
  TextStyle? style1;

  InfoRow({Key? key, required this.title, required this.value,this.style,this.style1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: style == false?theme.textTheme.titleMedium:style,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: style1 == false?theme.textTheme.titleMedium!.copyWith(color: Colors.grey.shade700):style1,
            ),
          ),
        ],
      ),
    );
  }
}

