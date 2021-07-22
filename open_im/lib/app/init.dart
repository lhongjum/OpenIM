import 'package:open_im/tools/notify/notify.dart';

/// 应用启动前的准备
Future<void> initialize() async {

}

/// 应用启动后的准备
Future<void> initializeLate() async {
  AppNotify.init();
}
