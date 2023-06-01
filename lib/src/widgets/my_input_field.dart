import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  MyInputField({super.key, required this.label, required this.initialInput});

  String label;
  String initialInput;

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        TextField(
          autocorrect: false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              filled: true,
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              hintText: widget.initialInput,
              fillColor: Colors.white70),
        )
      ],
    );
  }
}
