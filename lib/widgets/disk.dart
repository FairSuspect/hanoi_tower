import 'package:flutter/material.dart';

class Disk extends StatelessWidget {
  final Color color;
  final double radius;
  const Disk({Key? key, required this.color, required this.radius})
      : assert(radius > 0, "Radius must be positive (more than zero)"),
        assert(color != null, "Color must be non-null value"),
        super(key: key);
  static const double _height = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: _height,
      width: radius,
    );
  }
}
