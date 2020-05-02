import 'package:flutter/material.dart';

import 'package:redux/redux.dart';

import 'package:flutter_demo/ui/store/actions/actions.dart';

final darkModeReducer = combineReducers<ThemeMode>([
  TypedReducer<ThemeMode, DarkModeAction>(_setLoaded),
]);

ThemeMode _setLoaded(ThemeMode darkMode, DarkModeAction action) {
  return action.darkMode;
}