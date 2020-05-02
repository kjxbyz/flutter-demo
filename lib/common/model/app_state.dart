import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_demo/common/mock/bottom_tabs.dart';

part 'app_state.g.dart';

@JsonSerializable()
class AppState {
  final int counter;
  final ThemeMode darkMode;
  final List<Map<String, dynamic>> bottomTabs;
  final String localeName;

  AppState({
    this.counter = 0,
    this.darkMode = ThemeMode.system,
    this.bottomTabs = tabs,
    this.localeName = '',
  });

  AppState copyWith({
    int counter,
    bool darkMode,
    List<Map<String, dynamic>> bottomTabs,
    String localeName,
  }) =>
      AppState(
        counter: counter ?? this.counter,
        darkMode: darkMode ?? this.darkMode,
        bottomTabs: bottomTabs ?? this.bottomTabs,
        localeName: localeName ?? this.localeName,
      );

  static AppState fromJson(dynamic json) => json == null
      ? AppState()
      : _$AppStateFromJson(json as Map<String, dynamic>);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  @override
  String toString() {
    return this.toJson().toString();
  }
}

var initialState = AppState();
