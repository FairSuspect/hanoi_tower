import 'package:flutter/cupertino.dart';
import 'package:hanoi_tower/models/leaderboard.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'leaderboard/reducers.dart';

class AppState {
  final Leaderboard? leaderboard;

  AppState({required this.leaderboard});
  AppState.initialState() : leaderboard = Leaderboard.fromLocalStorage();
}

AppState appStateReducer(dynamic state, action) {
  return AppState(leaderboard: leaderboardReducer(state.leaderboard, action));
  // users: usersReducer(state.users, action));
}

// final Store<AppState> store = Store<AppState>(appStateReducer,
//     initialState: AppState.initialState(), middleware: [thunkMiddleware]);
final Store store =
    Store(leaderboardReducer, initialState: Leaderboard.fromLocalStorage());
