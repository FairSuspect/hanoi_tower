import 'package:flutter/material.dart';

class Tower extends StatelessWidget {
  const Tower({Key key}) : super(key: key);

  static const double stickHeight = 150;
  static const double stickWidth = 20;
  static const double baseHeight = 20;
  static const double baseWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: stickHeight + baseHeight,
      child: Column(
        children: [
          _stick(Theme.of(context).accentColor),
          _base(Theme.of(context).accentColor)
        ],
      ),
    );
  }

  Widget _base(Color color) => Container(
        width: baseWidth,
        height: baseHeight,
        color: color,
      );

  Widget _stick(Color color) => Container(
        width: stickWidth,
        height: stickHeight,
        color: color,
      );
}
