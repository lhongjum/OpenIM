import 'package:fk_user_agent/fk_user_agent.dart';

class UserAgent {
  static Future<Map<String, String?>> init() async {
    await FkUserAgent.init();

    return {
      'userAgent': FkUserAgent.userAgent,
      'webViewUserAgent': FkUserAgent.webViewUserAgent,
    };
  }
}
