import 'package:flutter/material.dart';
import 'package:hanoi_tower/widgets/tower.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Tower(), Tower(), Tower()],
        )),
      ),
    );
  }
}
