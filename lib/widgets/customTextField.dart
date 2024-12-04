import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final bool? readOnly;
  VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  ValueChanged<String>? onChanged;
  final maxLine;
  final TextInputType? keyboardType;

  CustomTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.title,
       this.readOnly = false,
      this.onTap,
      this.onChanged,
      this.validator,
      this.maxLine,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == ''?Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SizedBox(),
        ):Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4, top: 3),
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green.shade50, // Border color
              width: 0.5, // Border width
            ),
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: TextFormField(
            readOnly: readOnly!,
            maxLines: maxLine,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey),
              filled: true, // For background color
              fillColor: Colors.white, // Background color
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0, // Adjusts the left-right padding
                vertical: 10.0, // Adjusts the top-bottom padding
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Rounded borders inside
                borderSide: BorderSide.none, // No border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Rounded borders when focused
                borderSide: BorderSide(
                  color: Colors.green.shade400, // Focused border color
                  width: 2.0, // Border width when focused
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Rounded borders when enabled
                borderSide: BorderSide(
                  color: Colors.green.shade200, // Border color when not focused
                ),
              ),
            ),
            onTap: onTap,
            onChanged: onChanged,
            validator: validator,
            keyboardType: keyboardType,
          ),
        )
      ],
    );
  }
}
