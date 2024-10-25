import 'package:custom_searchable_dropdown/Custom_Searchable_Dropdown.dart';
import 'package:flutter/material.dart';

import '../theme/theme_helper.dart';

class MyCustomSD extends StatefulWidget {
  final bool? enable;
  final InputDecoration? decoration;
  final ValueChanged onChanged;
  final List listToSearch;
  final String? label;
  final String? labelText;
  final String valFrom;
  final IconData? prefixIcon;
  final List? initialValue;
  final bool? hideSearch;
  final double? height;
  final Color? borderColor;
  final bool?  multiSelect;
  const MyCustomSD({
    Key? key,
    this.enable,
    this.decoration,
    this.label,
    this.labelText,
    this.prefixIcon,
    required this.listToSearch,
    this.initialValue,
    this.hideSearch,
    this.height,
    this.borderColor,
    required this.valFrom,
    required this.onChanged,
    this.multiSelect,
  }) : super(key: key);
  @override
  _MyCustomSDState createState() => _MyCustomSDState();
}

class _MyCustomSDState extends State<MyCustomSD> {
  bool obscure = false;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    print("222222222222222222${widget.listToSearch}");
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
    widget.labelText == ""?SizedBox(): Padding(
      padding: const EdgeInsets.only(left: 4.0,bottom: 3,),
      child: Text(widget.labelText ??"",
          style: theme.textTheme.bodySmall!.copyWith(fontSize: 14)),
    ),
        CustomSearchableDropDown(
          multiSelect:widget.multiSelect ?? false,
          showLabelInMenu: true,
          suffixIcon: Icon(Icons.arrow_drop_down_sharp, color: Colors.grey),
          enabled: widget.enable,
          searchBarHeight: 50,
          padding: EdgeInsets.all(0),
          initialValue: widget.initialValue,
          primaryColor: Colors.green.shade700,
          hideSearch: widget.hideSearch ?? false,
          menuHeight: widget.height ?? 80,
          menuMode: false,
          labelStyle:
              theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
          items: widget.listToSearch,
          label: widget.label ?? 'Select Name',
          dropdownItemStyle:
              theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
          dropDownMenuItems: widget.listToSearch.map((item) {
            return item[widget.valFrom];
          }).toList(),
          onChanged: (val) {
            widget.onChanged(val);
          },
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: (widget.enable ?? true) ? Colors.white : Colors.grey.shade200,
              border: Border.all(color: widget.borderColor ?? Colors.transparent)),
        ),
      ],
    );
  }
}

