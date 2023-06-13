import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  MyButton(
      {super.key,
      this.enable = true,
      required this.label,
      required this.onTap});

  bool enable;
  final String label;
  final Function onTap;

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
            color: widget.enable ? const Color(0xFF4C7BBF) : Colors.grey,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(
            widget.label,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      onTap: () {
        if(widget.enable) {
          widget.onTap();
        }
      },
    );
  }
}
