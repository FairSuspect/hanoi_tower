import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("О программе")),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ханойские башни",
                style: Theme.of(context).textTheme.headline2),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Ханойская башня является одной из популярных головоломок XIX века. Даны три стержня, на один из которых нанизаны восемь колец, причём кольца отличаются размером и лежат меньшее на большем. Задача состоит в том, чтобы перенести пирамиду из восьми колец за наименьшее число ходов на другой стержень. За один раз разрешается переносить только одно кольцо, причём нельзя класть большее кольцо на меньшее.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .merge(TextStyle(fontSize: 22)),
              ),
            )
          ],
        ),
      )),
    );
  }
}
