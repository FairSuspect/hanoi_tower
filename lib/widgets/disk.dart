import 'package:flutter/material.dart';

const double diskHeight = 15;

class Disk extends StatelessWidget {
  final Color color;
  final double radius;
  const Disk({Key? key, required this.color, required this.radius})
      : assert(radius > 0, "Radius must be positive (more than zero)"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: diskHeight,
      width: radius,
    );
  }
}
