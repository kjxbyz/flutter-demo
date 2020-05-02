import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_demo/common/mock/dark_modes.dart';
import 'package:flutter_demo/common/model/app_state.dart';
import 'package:flutter_demo/ui/store/actions/actions.dart';

class DarkMode extends StatefulWidget {
  final String headerTitle;

  const DarkMode({Key key, this.headerTitle}) : super(key: key);

  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "DarkMode"),
      ),
      body: StoreConnector<AppState, ThemeMode>(
        converter: (store) => store.state.darkMode,
        builder: (context, darkMode) => Container(
          margin: EdgeInsets.only(left: 6, right: 6),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) =>
                RadioListTile<ThemeMode>(
              groupValue: darkMode,
              title: Text(darkModes[index]["title"]),
              value: darkModes[index]["mode"],
              onChanged: (value) {
                StoreProvider.of<AppState>(context)
                    .dispatch(DarkModeAction(darkMode: value));
              },
            ),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: darkModes.length,
          ),
        ),
      ),
    );
  }
}
