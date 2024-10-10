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
          height: 43,
          child: TextField(
            style: theme.textTheme.bodySmall,
            decoration: InputDecoration(
              hintText: DateFormat('dd/MM/yyyy').format(DateTime.now()),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
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
