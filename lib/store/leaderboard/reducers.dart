import 'package:hanoi_tower/models/leaderboard.dart';
import 'package:redux/redux.dart';

import 'actions.dart' as Actions;

// final leaderboardReducer = combineReducers([
//   Reducer<Leaderboard, Actions.SetLeaderboard>(_setLeaderboard),
// ]);
final leaderboardReducer = _setLeaderboard;

Leaderboard? _setLeaderboard(state, action) {
  Leaderboard.saveToLocalStorage(action.leaderboard);
  return action.leaderboard;
}
