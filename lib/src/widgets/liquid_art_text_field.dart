import 'package:flutter/material.dart';

class LiquidArtTextField extends StatefulWidget {
  const LiquidArtTextField({super.key, this.maxLines = 1, required this.label, required this.hintText, required this.textController, this.enabled = true, this.onChanged, this.inputType});

  final String label;
  final String hintText;
  final bool enabled;
  final TextEditingController textController;
  final int? maxLines;
  final Function? onChanged;
  final TextInputType? inputType;

  @override
  State<LiquidArtTextField> createState() => _LiquidArtTextFieldState();
}

class _LiquidArtTextFieldState extends State<LiquidArtTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            widget.label,
            style: TextStyle(fontSize: 18, color: widget.enabled ? Colors.black : Colors.grey),
          ),
        ),
        TextField(
          keyboardType: widget.inputType,
          enabled: widget.enabled,
          controller: widget.textController,
          autocorrect: false,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.black),
              ),
              filled: true,
              hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              hintText: widget.hintText,
              fillColor: Colors.white70),
          onChanged: (value) {
            widget.onChanged != null ? widget.onChanged!(value) : null;
          },
        )
      ],
    );
  }
}
