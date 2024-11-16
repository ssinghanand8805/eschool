import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function(DateTime)? onDateSelected;

  const DatePickerTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.onDateSelected,
  }) : super(key: key);

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0,top: 4),
          child: Text(
           widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(

          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green.shade50, // Border color
              width: 0.5, // Border width
            ),
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), // Shadow color
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 2), // Shadow position
              ),
            ],
          ),
          child: TextField(
            style: theme.textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
              hintStyle: TextStyle(color: Colors.grey),
              filled: true, // For background color
              fillColor: Colors.white, // Background color
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.0, // Adjusts the left-right padding
                vertical: 10.0, // Adjusts the top-bottom padding
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(15.0), // Rounded borders inside
                borderSide: BorderSide.none, // No border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(15.0), // Rounded borders when focused
                borderSide: BorderSide(
                  color: Colors.green.shade400, // Focused border color
                  width: 2.0, // Border width when focused
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(15.0), // Rounded borders when enabled
                borderSide: BorderSide(
                  color: Colors.green.shade200, // Border color when not focused
                ),
              ),
            ),
            // decoration: InputDecoration(
            //   hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
            //   border: OutlineInputBorder(
            //     borderSide: BorderSide(color: Colors.green),
            //     borderRadius: BorderRadius.all(Radius.circular(12)),
            //   ),
            // ),
            readOnly: true,
            controller: widget.controller,
            onTap: () async {
              final date = await getDate();
              if (date != null && widget.onDateSelected != null) {
                widget.onDateSelected!(date);
              }
            },
          ),
        ),
      ],
    );
  }

  Future<DateTime?> getDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(DateTime.now().year + 1),

    );
    return picked;
  }
}
