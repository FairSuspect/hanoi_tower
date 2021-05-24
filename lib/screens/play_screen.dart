import 'package:flutter/material.dart';
import 'package:hanoi_tower/router/main.dart';
import 'package:hanoi_tower/widgets/disk.dart';
import 'package:hanoi_tower/widgets/tower.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

List<DiskEntity> entities = [];
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
  // List<Key>? disksKeys = [
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  //   UniqueKey(),
  // ];
  void towerTapHandler(int id) {
    if (elevetedDisk == null) {
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

                      Navigator.of(context).pushReplacementNamed(Routes.play);
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

    hanoiTowers = [
      HanoiTower(
          disks: hanoiDisks,
          onTap: () {
            towerTapHandler(0);
          }),
      HanoiTower(
          disks: List.empty(growable: true),
          onTap: () {
            towerTapHandler(1);
          }),
      HanoiTower(
          disks: List.empty(growable: true),
          onTap: () {
            towerTapHandler(2);
          }),
    ];
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

  @override
  void dispose() {
    super.dispose();
    entities = [];
    hanoiTowers = [];
    hanoiDisks = [];
    elevetedDisk = null;
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("Play screen updated");
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
