import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:flutter_demo/common/utils/dark_mode_util.dart';
import 'package:flutter_demo/common/model/app_state.dart';
import 'package:flutter_demo/common/flutter_demo_manager.dart';
import 'package:flutter_demo/common/mock/bottom_tabs.dart';
import 'package:flutter_demo/l10n/flutter_demo_localizations.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentIndex = 0;
  final GlobalKey _key = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    AppState _appState = StoreProvider.of<AppState>(context).state;
    List<Map<String, dynamic>> _bottomTabs = _appState.bottomTabs;
    ThemeMode _darkMode = _appState.darkMode;

    List<BottomNavigationBarItem> _items = [];
    _bottomTabs.asMap().forEach((index, item) {
      _items.add(BottomNavigationBarItem(
        title: Text(
          _getTitle(item["title"]),
          style: TextStyle(
            color: _currentIndex == index
                ? _theme.accentColor
                : DarkModeUtil.isDarkMode(context, _darkMode)
                ? Colors.white38
                : Colors.black38,
          ),
        ),
        icon: Icon(
          IconData(item["icon"], fontFamily: 'MaterialIcons'),
          color: DarkModeUtil.isDarkMode(context, _darkMode)
              ? Colors.white38
              : Colors.black38,
        ),
        activeIcon: Icon(
          IconData(item["icon"], fontFamily: 'MaterialIcons'),
          color: _theme.accentColor,
        ),
      ));
    });

    List<Widget> _pages = [];
    _bottomTabs.forEach((Map<String, dynamic> item) {
      Map<String, dynamic> element = tabsWithWidget.firstWhere(
              (Map<String, dynamic> ele) => ele['title'] == item['title']);
      _pages.add((element["widget"] as Function)(_getTitle(element["title"])));
    });

    return StoreConnector<AppState, List<Map<String, dynamic>>>(
      converter: (store) => store.state.bottomTabs,
      builder: (context, bottomTabs) {
        return Scaffold(
          body: PageView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            children: _pages,
          ),
          bottomNavigationBar: Opacity(
            opacity: 1.0,
            child: BottomNavigationBar(
              key: _key,
              selectedFontSize: 12,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                _controller.jumpToPage(index);
                FlutterDemoManager()
                  ..kBottomNavigationBarHeight =
                      _key.currentContext.size.height;
              },
              type: BottomNavigationBarType.fixed,
              items: _items,
            ),
          ),
        );
      },
    );
  }

  String _getTitle(String title) {
    FlutterDemoLocalizations _localizations = FlutterDemoLocalizations.of(context);
    switch(title) {
      case 'tabSamplesTitle':
        return _localizations.tabSamplesTitle;
      case 'tabCategoriesTitle':
        return _localizations.tabCategoriesTitle;
      case 'tabWebViewTitle':
        return _localizations.tabWebViewTitle;
      case 'tabSettingsTitle':
        return _localizations.tabSettingsTitle;
    }
  }
}
