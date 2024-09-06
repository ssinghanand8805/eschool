import 'package:flutter/material.dart';
import 'package:learnladderfaculity/core/app_export.dart';

class MyButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? elevation;
  final double? width;
  final Function? onPress;
  final Color? color;
  final bool? animate;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  const MyButton(
      {Key? key,
        required this.title,
        this.onPress,
        this.color,
        this.height,
        this.textStyle,
        this.elevation,
        this.animate,
        this.suffixIcon,
        this.prefixIcon,
        this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: TextButton(
            style: TextButton.styleFrom(
              shadowColor: theme.primaryColor,
              padding: const EdgeInsets.all(6),
              elevation: elevation ?? 0,
              foregroundColor: Colors.black,
              backgroundColor: color ?? theme.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              onPress!();
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [

                        prefixIcon ?? Container(),
                        Visibility(
                          visible: prefixIcon != null,
                          child: const SizedBox(
                            width: 2,
                          ),
                        ),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: textStyle ?? theme.textTheme.bodySmall!,
                        ),
                        Visibility(
                          visible: suffixIcon != null,
                          child: const SizedBox(
                            width: 2,
                          ),
                        ),
                        suffixIcon ?? Container(),


                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
