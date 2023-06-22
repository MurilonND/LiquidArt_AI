import 'package:flutter/material.dart';

class LiquidArtButton extends StatefulWidget {
  const LiquidArtButton(
      {super.key,
      required this.label, this.onTap});

  final String label;
  final void Function()? onTap;

  @override
  State<LiquidArtButton> createState() => _LiquidArtButtonState();
}

class _LiquidArtButtonState extends State<LiquidArtButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4C7BBF),
            shape: const StadiumBorder()),
        onPressed: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 15, horizontal: 55),
          child:  Text(
            widget.label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
