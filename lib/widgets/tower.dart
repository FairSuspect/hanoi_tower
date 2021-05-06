import 'package:flutter/material.dart';

class Tower extends StatelessWidget {
  const Tower({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Column(
        children: [
          _stick(Theme.of(context).accentColor),
          _base(Theme.of(context).accentColor)
        ],
      ),
    );
  }

  Widget _base(Color color) => Container(
        width: 100,
        height: 20,
        color: color,
      );

  Widget _stick(Color color) => Container(
        width: 20,
        height: 200,
        color: color,
      );
}
