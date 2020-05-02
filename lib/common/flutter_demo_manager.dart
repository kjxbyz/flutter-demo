class FlutterDemoManager {
  double kBottomNavigationBarHeight;

  // 单例公开访问点
  factory FlutterDemoManager() => _flutterDemoManager();

  // 静态私有成员，没有初始化
  static FlutterDemoManager _instance;

  // 私有构造函数
  FlutterDemoManager._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static FlutterDemoManager _flutterDemoManager() {
    if (_instance == null) {
      _instance = FlutterDemoManager._();
    }
    return _instance;
  }

}