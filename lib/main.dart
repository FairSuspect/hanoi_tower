import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hanoi_tower/router/main.dart';
import 'package:hanoi_tower/store/main.dart';
import 'services/localstorage.dart';

void main() async {
  runApp(MyApp());
  await localStorage.ready;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // routes: routes.map((e) => {e.routeName : e.widget}).to,
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        // initialRoute: Routes.main,
        // home: HomeScreen(title: 'Hanoi Tower Game'),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int get highScore => store.state?.highScore ?? 0;

  String get localStorageKey => 'leaderboard';

  void _newGamePressed() {
    Navigator.of(context).pushNamed(Routes.play);
  }

  void _computerGamePressed() {
    Navigator.of(context).pushNamed(Routes.play, arguments: [false]);
  }

  void _exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Hanoi Tower", style: Theme.of(context).textTheme.headline1),
            ElevatedButton.icon(
                onPressed: _newGamePressed,
                icon: Icon(Icons.play_arrow),
                label: Text("Новая игра")),
            ElevatedButton.icon(
                onPressed: _computerGamePressed,
                icon: Icon(Icons.computer),
                label: Text("Игра компьютера")),
            ElevatedButton.icon(
                onPressed: _exit,
                icon: Icon(Icons.exit_to_app),
                label: Text("Выход")),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
