import 'package:flutter/material.dart';
import 'package:hanoi_tower/widgets/tower.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  List disks = List.filled(5, Key);
  @override
  void initState() {
    super.initState();
    disks.forEach((disk) {
      disk = UniqueKey();
      print(disk);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hanoi Tower"),
      ),
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
