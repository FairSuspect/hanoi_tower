import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hanoi_tower/router/main.dart';
import 'package:hanoi_tower/widgets/disk.dart';
import 'package:hanoi_tower/widgets/tower.dart';

class PlayScreen extends StatefulWidget {
  final bool playByHuman;
  const PlayScreen({Key? key, this.playByHuman = true}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

List<Widget> disks = List.empty(growable: true);
bool moving = false;
DiskEntity selectedDisk = DiskEntity(
    widget: Container(), tower: Key('1'), lastTower: Key('1'), radius: 0);

List<Tower> towers = [];
List<HanoiTower> hanoiTowers = [];
List<HanoiDisk> hanoiDisks = [];
HanoiDisk? elevetedDisk;

class _PlayScreenState extends State<PlayScreen> {
  List<Color> diskColorList = [
    Colors.red,
    Colors.lightGreen,
    Colors.cyan,
    Colors.deepOrange,
    Colors.brown
  ];
  bool isPlaying = true;
  // List<Key>? disksKeys = [
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  // ];
  void towerTapHandler(int id) {
    if (elevetedDisk == null) {
      if (hanoiTowers[id].disks.length != 0)
        setState(() {
          elevetedDisk = hanoiTowers[id].disks.removeLast();
        });
    } else {
      if (hanoiTowers[id].disks.length == 0 ||
          hanoiTowers[id].disks.last.radius > elevetedDisk!.radius) {
        setState(() {
          elevetedDisk!.lastTowerId = id;
          hanoiTowers[id].disks.add(elevetedDisk!);

          elevetedDisk = null;
          if (hanoiTowers[2].disks.length == diskColorList.length) {
            isPlaying = false;
            _winDialog();
          }
        });
      } else {
        setState(() {
          towerTapHandler(elevetedDisk!.lastTowerId);
        });
      }
    }
  }

  void _winDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Победа!"),
              content: Text("Сыграть еще раз или вернуться в главное меню?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil((route) => !Navigator.of(context).canPop());
                    },
                    child: Text("В главное меню")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      Navigator.of(context).pushReplacementNamed(Routes.play,
                          arguments: [widget.playByHuman]);
                    },
                    child: Text("Заново")),
              ],
            ));
  }

  @override
  void initState() {
    super.initState();
    // hanoiDisks = diskColorList.map((e) => HanoiDisk(color: e)).toList();
    for (int i = diskColorList.length - 1; i >= 0; --i)
      hanoiDisks.add(HanoiDisk(
          color: diskColorList[i], radius: (i + 2) * 20, lastTowerId: 0));
    isPlaying = true;
    hanoiTowers = [
      HanoiTower(
          disks: hanoiDisks,
          onTap: widget.playByHuman
              ? () {
                  towerTapHandler(0);
                }
              : () {}),
      HanoiTower(
          disks: List.empty(growable: true),
          onTap: widget.playByHuman
              ? () {
                  towerTapHandler(1);
                }
              : () {}),
      HanoiTower(
          disks: List.empty(growable: true),
          onTap: widget.playByHuman
              ? () {
                  towerTapHandler(2);
                }
              : () {}),
    ];
    if (!widget.playByHuman) {
      computerPlay();
    }
    // towers = [
    //   Tower(
    //       key: UniqueKey(),
    //       onTap: () {
    //         setState(() {});
    //       }),
    //   Tower(
    //       key: UniqueKey(),
    //       onTap: () {
    //         setState(() {});
    //       }),
    //   Tower(
    //       key: UniqueKey(),

    //       onTap: () {
    //         setState(() {});
    //       }),
    // ];
    // disksKeys!.forEach((key) {
    //   // key = UniqueKey();
    //   var radius = (diskColorList.length + 1) * 20.0;
    //   entities.add(DiskEntity(
    //       radius: radius,
    //       lastTower: towers.first.key!,
    //       tower: towers.first.key!,
    //       widget: Disk(
    //           key: key, color: diskColorList.removeLast(), radius: radius)));
    // });
  }

  bool _canPlaceDisk(int towerId, HanoiDisk disk) {
    if (hanoiTowers[towerId].disks.length == 0) return true;
    if (hanoiTowers[towerId].disks.last.radius > disk.radius) return true;
    return false;
  }

  bool _shouldElevate(int towerId) {
    for (int i = 0; i < hanoiTowers.length; ++i) {
      if (i != towerId) {
        if (_canPlaceDisk(i, _lastDisk(towerId))) return true;
      }
    }

    return false;
  }

  HanoiDisk _lastDisk(int towerId) {
    if (hanoiTowers[towerId].disks.length == 0)
      return HanoiDisk(color: Colors.black, radius: -1, lastTowerId: -1);
    return hanoiTowers[towerId].disks.last;
  }

// double _lastDiskRadius(int towerId)
// {
//   if()
//   hanoiTowers[randomNumber].disks.last.radius
// }
  int lastNumber = -1;
  int randomNumber = 0;

  void computerPlay() async {
    while (isPlaying) {
      await Future.delayed(Duration(milliseconds: 100));
      randomNumber = Random().nextInt(3);
      if (randomNumber != lastNumber) {
        if (elevetedDisk != null) {
          if (_canPlaceDisk(randomNumber, elevetedDisk!)) {
            towerTapHandler(randomNumber);
            lastNumber = randomNumber;
          }
        } else {
          if (_shouldElevate(randomNumber)) {
            towerTapHandler(randomNumber);
            lastNumber = randomNumber;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    hanoiTowers = [];
    hanoiDisks = [];
    elevetedDisk = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hanoi Tower"),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            elevetedDisk != null
                ? Disk(color: elevetedDisk!.color, radius: elevetedDisk!.radius)
                : Container(height: diskHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: hanoiTowers
                  .map((e) => Tower(onTap: e.onTap, disks: e.disks))
                  .toList(),
            ),
            Container()
          ],
        )),
      ),
    );
  }
}

class DiskEntity {
  Widget widget;
  Key tower;
  Key lastTower;
  double radius;
  DiskEntity(
      {required this.widget,
      required this.tower,
      required this.lastTower,
      required this.radius});
}

class HanoiDisk {
  Color color;
  double radius;
  int lastTowerId;
  HanoiDisk(
      {required this.color, required this.radius, required this.lastTowerId});
}

class HanoiTower {
  List<HanoiDisk> disks;
  void Function() onTap;
  HanoiTower({required this.disks, required this.onTap});
}
