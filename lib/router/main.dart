import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:hanoi_tower/main.dart';
import 'package:hanoi_tower/screens/info_screen.dart';
import 'package:hanoi_tower/screens/play_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("generateRoute with settings:$settings");
    final args = settings.arguments;

    var route = routes.firstWhereOrNull((x) => x.routeName == settings.name);

    if (route != null) {
      return MaterialPageRoute(builder: (context) => route.widget(args));
    }
    return MaterialPageRoute(builder: (context) => routes[0].widget(args));
  }
}

class RouteBuilder {
  final String routeName;
  final Widget Function(dynamic args) widget;

  RouteBuilder(
    this.routeName,
    this.widget,
  );
}

class Routes {
  static const play = '/play';
  static const main = '/main';
  static const info = '/info';
}

final routes = [
  RouteBuilder(Routes.main, (args) => HomeScreen(title: 'Hanoi Tower Game')),
  RouteBuilder(
      Routes.play,
      (args) => PlayScreen(
            playByHuman: args?[0] ?? true,
          )),
  RouteBuilder('/info', (args) => InfoScreen())
];
