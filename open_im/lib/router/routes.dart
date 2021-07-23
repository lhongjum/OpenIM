import 'package:get/get.dart';

import 'package:open_im/pages/chat/page.dart';
import 'package:open_im/pages/core/core.dart';
import 'package:open_im/pages/mail/mail.dart';
import 'package:open_im/pages/profile/profile.dart';
import 'package:open_im/pages/space/space.dart';

/// 定义路由
class Routes {
  static final List<GetPage> routes = [
    GetPage(name: Core, page: () => CorePage()),
    GetPage(name: Chat, page: () => ChatPage()),
    GetPage(name: Space, page: () => SpacePage()),
    GetPage(name: Profile, page: () => ProfilePage()),
    GetPage(name: Mail, page: () => MailPage()),
  ];

  /// App启动BottomBar导航页
  static const Core = '/';

  /// 聊天人页(第一屏)
  static const Chat = '/chat';

  /// 朋友圈页(第二屏)
  static const Space = '/space';

  /// 用户信息页(第三屏)
  static const Profile = '/profile';

  /// 聊天对话页
  static const Mail = '/chat/mail';
}
