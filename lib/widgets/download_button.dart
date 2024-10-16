import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import '../theme/theme_helper.dart';

Widget customDownloadButton({
  required VoidCallback onPressed,
  Color? backgroundColor = Colors.blue,
  Color? textColor = Colors.white,
  Color? iconColor = Colors.white,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.download,
          color: iconColor,
          size: 15,
        ),
        SizedBox(width: 8),
        Text("Download",
            style: theme.textTheme.titleSmall!
                .copyWith(fontSize: 12, color: Colors.white)),
      ],
    ),
  );

}

Future<void> downloadFileFromAPI(String fileUrl, String fileName) async {
  try {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(fileUrl));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print('File downloaded: $filePath');
    await OpenFilex.open(filePath);
  } catch (e) {
    print('Error downloading file: $e');
  }
}