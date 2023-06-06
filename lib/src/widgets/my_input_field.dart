import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  const MyInputField({super.key, required this.label, required this.initialInput, required this.textController});

  final String label;
  final String initialInput;
  final TextEditingController textController;

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
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            widget.label,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        TextField(
          controller: widget.textController,
          autocorrect: false,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.black),
              ),
              filled: true,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              hintText: widget.initialInput,
              fillColor: Colors.white70),
        )
      ],
    );
  }
}
