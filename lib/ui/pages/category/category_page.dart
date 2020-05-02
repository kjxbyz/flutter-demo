import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_demo/common/flutter_demo_manager.dart';
import 'package:flutter_demo/common/mock/product_category.dart';
import 'package:flutter_demo/common/model/app_state.dart';
import 'package:flutter_demo/common/utils/dark_mode_util.dart';
import 'package:flutter_demo/common/utils/math_util.dart';

class CategoryPage extends StatefulWidget {
  final String headerTitle;

  const CategoryPage({Key key, this.headerTitle}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ScrollController _scrollController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double _kBottomNavigationBarHeight =
        FlutterDemoManager().kBottomNavigationBarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.headerTitle ?? "Category"),
      ),
      body: Container(
        height: height - top - kToolbarHeight - _kBottomNavigationBarHeight,
        child: Row(
          children: <Widget>[
            StoreConnector<AppState, ThemeMode>(
              converter: (store) => store.state.darkMode,
              builder: (context, darkMode) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: DarkModeUtil.isDarkMode(context, darkMode)
                          ? Colors.white12.withAlpha(7)
                          : Colors.black12.withAlpha(7),
                    ),
                  ),
                ),
                width: 88,
                height:
                    height - top - kToolbarHeight - _kBottomNavigationBarHeight,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: _ProductCategoryItem(
                      label: productCategories[index]['label'],
                      highlight: index == _currentIndex,
                    ),
                  ),
                  itemCount: productCategories.length,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height:
                    height - top - kToolbarHeight - _kBottomNavigationBarHeight,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      _ProductCategoryCard(),
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCategoryItem extends StatelessWidget {
  final String label;
  final bool highlight;

  const _ProductCategoryItem({Key key, this.label, this.highlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Container(
        margin: EdgeInsets.only(top: 19, bottom: 19),
        height: 18,
        decoration: highlight
            ? BoxDecoration(
                border: Border(
                  left: BorderSide(color: Colors.orangeAccent, width: 4),
                ),
              )
            : BoxDecoration(),
        padding:
            highlight ? EdgeInsets.only(right: 4) : EdgeInsets.only(left: 0),
        child: StoreConnector<AppState, ThemeMode>(
          converter: (store) => store.state.darkMode,
          builder: (context, darkMode) => Center(
            child: Text(
              label,
              style: TextStyle(
                color: highlight
                    ? Colors.orangeAccent
                    : DarkModeUtil.isDarkMode(context, darkMode)
                        ? Colors.white
                        : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _textStyle = TextStyle(color: Colors.black12);
    double imageSize = (MediaQuery.of(context).size.width - 88) * 0.25;
    int randomNum = MathUtil.randomWithMax(9);
    List<Widget> widgets = List.generate(
      randomNum,
      (int index) => _widget(imageSize),
    );
    if (randomNum < 3) {
      widgets.addAll(List.generate(
        ((randomNum / 3).ceil()) * 3 - randomNum,
        (int index) => Container(
          margin: EdgeInsets.only(top: 12, left: 8, right: 8),
          child: Column(
            children: <Widget>[
              Container(
                width: imageSize,
                height: imageSize,
              ),
              Container(
                padding: EdgeInsets.only(top: 12),
                child: Text(''),
              )
            ],
          ),
        ),
      ));
    }

    return Container(
        width: MediaQuery.of(context).size.width - 88,
        child: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '——',
                  style: _textStyle,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    '数字电话',
                  ),
                ),
                Text(
                  '——',
                  style: _textStyle,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: widgets,
            ),
          )
        ]));
  }

  Widget _widget(double imageSize) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Container(
            width: imageSize,
            height: imageSize,
            child: CachedNetworkImage(
              imageUrl: 'https://cdn.kjxbyz.com/logo/avatar.JPG',
              placeholder: (context, url) => Center(
                child: Container(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12),
            child: Text('data'),
          )
        ],
      ),
    );
  }
}
