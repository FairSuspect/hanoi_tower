import 'package:hanoi_tower/services/localstorage.dart';

class Leaderboard {
  /// Лучший результат `highScore`
  int highScore;

  Leaderboard({this.highScore});

  static String localStorageKey = 'leaderboard';

  static Leaderboard fromLocalStorage() {
    var json = localStorage.getItem(localStorageKey);
    print("got $json");
    return Leaderboard.fromJson(json ?? Map<String, dynamic>());
  }

  static void saveToLocalStorage(Leaderboard model) {
    localStorage.setItem(localStorageKey, model?.toJson() ?? null);
    print("saved to local storage (${model?.toJson()})");
  }

  Leaderboard.fromJson(Map<String, dynamic> json) {
    highScore = json['highScore'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["highScore"] = highScore;
    return map;
  }
}
