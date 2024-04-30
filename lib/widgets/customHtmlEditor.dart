import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

import '../theme/theme_helper.dart';

class CustomHtmlEditor extends StatelessWidget {
  final HtmlEditorController controller;
  final double height;
  final String title;

  const CustomHtmlEditor({
    Key? key,
    required this.controller,
    required this.height,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, top: 4),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SizedBox(
          height: height,
          child: HtmlEditor(
            htmlToolbarOptions: HtmlToolbarOptions(
                toolbarItemHeight: 36,
                toolbarType: ToolbarType.nativeGrid,
                textStyle: theme.textTheme.titleMedium,
                defaultToolbarButtons: [
                  const StyleButtons(),
                  const FontButtons(
                      clearAll: true,
                      strikethrough: false,
                      subscript: false,
                      superscript: false)
                ]),
            controller: controller, //required
            htmlEditorOptions: const HtmlEditorOptions(
              hint: "Please enter ...",
              shouldEnsureVisible: true,
              autoAdjustHeight: true,
              adjustHeightForKeyboard: true,
            ),
            otherOptions: const OtherOptions(),
          ),
        ),
      ],
    );
  }
}
