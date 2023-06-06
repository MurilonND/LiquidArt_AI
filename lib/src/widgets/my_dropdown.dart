import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  MyDropDown({Key? key, required this.dropValue, required this.hintText, required this.values, required this.items, required this.onChanged})
      : super(key: key);
  String? dropValue;
  final String hintText;
  final List<String> items;
  final List<String> values;
  final Function onChanged;


  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: const Icon(Icons.expand_more),
          value: widget.dropValue,
          hint: Text(
            widget.hintText,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          items: List.generate(
            widget.items.length,
            (index) => DropdownMenuItem(
              value: widget.values[index],
              child: Text(widget.items[index]),
            ),
          ),
          onChanged: (value) {
            widget.onChanged(value);
          },
        ),
      ),
    );
  }
}
