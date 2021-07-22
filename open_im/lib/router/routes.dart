import 'package:get/get.dart';

import 'package:open_im/pages/core/core.dart';
import 'package:open_im/pages/home/home.dart';

/// 定义路由
class Routes {
  static final List<GetPage> routes = [
    GetPage(name: Core, page: () => CorePage()),
    GetPage(name: Home, page: () => HomePage()),
  ];


  /// App启动BottomBar导航页
  static const Core = '/';

  /// 首页(第一屏)
  static const Home = '/home';
}
