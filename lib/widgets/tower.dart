import 'package:flutter/material.dart';
import 'package:hanoi_tower/screens/play_screen.dart';
import 'package:hanoi_tower/widgets/disk.dart';

class Tower extends StatefulWidget {
  final void Function() onTap;
  final List<HanoiDisk> disks;
  // static _TowerState of(BuildContext context) => context.ancestorStateOfType(const TypeMatcher<_TowerState>());

  const Tower({Key? key, required this.onTap, required this.disks})
      : super(key: key);

  static const double stickHeight = 150;
  static const double stickWidth = 20;
  static const double baseHeight = 20;
  static const double baseWidth = 120;

  @override
  _TowerState createState() => _TowerState();
}

class _TowerState extends State<Tower> {
  // List<DiskEntity> _disks = [];
  @override
  void initState() {
    super.initState();
    // _disks = entities.where((element) => element.tower == widget.key).toList();
  }

  @override
  void setState(void Function() fn) {
    super.setState(fn);
    widget.onTap();
  }

  // List<DiskEntity> get _disks =>
  //     entities.where((element) => element.tower == widget.key).toList();
  @override
  Widget build(BuildContext context) {
    // _disks = entities.where((element) => element.tower == widget.key).toList();
    // print("_disks: $_disks; tower with key: ${widget.key}}");
    return InkWell(
      child: Container(
        height: Tower.stickHeight + Tower.baseHeight,
        child: Column(
          children: [
            _stick(Theme.of(context).accentColor),
            _base(Theme.of(context).accentColor)
          ],
        ),
      ),
      onTap: widget.onTap,
      // onTap: () {
      //   setState(() {
      //     print(
      //         "Tap on ${widget.key}, selectedDisk: ${selectedDisk.widget.key}, selectedDisk.tower: ${selectedDisk.tower}, it's == Key(''): ${selectedDisk.tower == Key('')}");
      //     if (selectedDisk.tower == Key('')) {
      //       if (_disks.length == 0) {
      //         selectedDisk.tower = widget.key!;
      //         print("placed on empty tower");
      //         return;
      //       }
      //       if (selectedDisk.radius < _disks.last.radius) {
      //         selectedDisk.tower = widget.key!;
      //         print("placed");
      //       } else {
      //         print("returned to sender (${selectedDisk.lastTower})");
      //         selectedDisk.tower = selectedDisk.lastTower;
      //         towers
      //             .firstWhere((element) => element.key == selectedDisk.tower)
      //             .onTap();
      //       }
      //     } else {
      //       selectedDisk = _disks.last;
      //       selectedDisk.lastTower = selectedDisk.tower;
      //       selectedDisk.tower = Key('');
      //       print("selectedDisk().tower: ${selectedDisk.tower}");
      //     }
      //     print("selectedDisk.tower: ${selectedDisk.tower}");
      //     widget.onTap();
      //   });
      // },
    );
  }

  Widget _base(Color color) => Container(
        width: Tower.baseWidth,
        height: Tower.baseHeight,
        color: color,
      );

  Widget _stick(Color color) => Container(
        height: Tower.stickHeight,
        width: Tower.baseWidth,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: Tower.stickWidth,
                height: Tower.stickHeight,
                color: color,
              ),
            ),
            Center(
              child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: widget.disks
                      .map((e) => Disk(color: e.color, radius: e.radius))
                      .toList()),
            )
          ],
        ),
      );
}
