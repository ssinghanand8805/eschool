import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final Function(TimeOfDay)? onTimeSelected;

  const TimePickerTextField({
    Key? key,
    required this.controller,
    required this.title,
    this.onTimeSelected,
  }) : super(key: key);

  @override
  State<TimePickerTextField> createState() => _TimePickerTextFieldState();
}

class _TimePickerTextFieldState extends State<TimePickerTextField> {
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
         // height: 43,
          child: TextField(
            style: theme.textTheme.bodySmall,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              hintText: DateFormat('HH:mm').format(DateTime.now()),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            readOnly: true,
            controller: widget.controller,
            onTap: () async {
              final time = await getTime();
              if (time != null && widget.onTimeSelected != null) {
                widget.onTimeSelected!(time);
              }
            },
          ),
        ),
      ],
    );
  }

  Future<TimeOfDay?> getTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return picked;
  }
}
