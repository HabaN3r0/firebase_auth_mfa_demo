import 'package:flutter/material.dart';
// typedef CustomCallback = void Function(String message);

class OwlTextButton extends StatefulWidget {
  final String title;
  final double fontSize;
  final Color fontColor;
  final VoidCallback onPressed;
  const OwlTextButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.fontSize,
      this.fontColor = Colors.blue});

  @override
  State<OwlTextButton> createState() => _OwlTextButtonState();
}

class _OwlTextButtonState extends State<OwlTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(color: widget.fontColor, fontSize: widget.fontSize),
        ));
  }
}
