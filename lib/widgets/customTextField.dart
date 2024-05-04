import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
   VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;


   CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.title,
     this.onTap,
    this.onChanged,
     this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        Container(
          // height: 43,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green.shade50,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(),
            ),
            onTap:onTap,
            onChanged: onChanged,
              validator: validator

          ),
        ),
      ],
    );
  }
}
