import 'package:flutter/material.dart';

class OwlButton extends StatefulWidget {
  final Widget child;
  final bool status;
  final VoidCallback? onPressed;
  final double elevation;
  final Color foregroundColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color disabledBackgroundColor;
  final Color disabledForegroundColor;
  final Size fixedSize;
  final double radius;
  const OwlButton({
    super.key,
    required this.child,
    this.status = true,
    this.onPressed,
    required this.elevation,
    this.foregroundColor = const Color(0xFF1971C2),
    this.backgroundColor = const Color(0xFFE7F5FF),
    this.borderColor = const Color(0xFF1971C2),
    this.disabledBackgroundColor = const Color(0xFFC3C9CD),
    this.disabledForegroundColor = const Color(0xFF5E6E7A),
    this.radius = 8,
    required this.fixedSize,
  });

  @override
  State<OwlButton> createState() => _OwlButtonState();
}

class _OwlButtonState extends State<OwlButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius)),
            side: BorderSide(color: widget.borderColor),
            foregroundColor: widget.foregroundColor,
            backgroundColor: widget.backgroundColor,
            disabledBackgroundColor: widget.disabledBackgroundColor,
            disabledForegroundColor: widget.disabledForegroundColor,
            elevation: widget.elevation,
            fixedSize: widget.fixedSize),
        onPressed: widget.status ? widget.onPressed : null,
        child: widget.child);
  }
}
