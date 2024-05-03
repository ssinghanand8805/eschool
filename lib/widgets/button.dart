import 'package:flutter/material.dart';

import '../theme/theme_helper.dart';

class CustomImageButton extends StatelessWidget {
  final String imagePath;
  final String name;
  final VoidCallback onPressed;

  const CustomImageButton({
    required this.imagePath,
    required this.name,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: Image.asset(
              imagePath,
              width: 32.0,
              height: 32.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

Widget Button(
    {required IconData icon,
      required VoidCallback onTap,
      required String text}) {
  return GestureDetector(
    onTap: onTap,
    child: Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 30,
       width: 100,
        decoration: BoxDecoration(
          color: Colors.green.shade200,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 17,
              ),
              SizedBox(width: 8.0),
              Text(text, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    ),
  );
}