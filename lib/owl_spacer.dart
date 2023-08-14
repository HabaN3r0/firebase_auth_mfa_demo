import 'package:flutter/material.dart';

class OwlSpacer extends StatelessWidget {
  final double height;
  final double width;
  const OwlSpacer({
    Key? key,
    this.height = 0,
    this.width = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return width == 0
        ? SizedBox(height: height)
        : height == 0
            ? SizedBox(width: width)
            : SizedBox(height: height, width: width);
  }
}
