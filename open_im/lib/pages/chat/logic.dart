import 'package:get/get.dart';

import 'package:open_im/router/router.dart';

class ChatLogic {
  static Future<void> openMailPage(int uid, String username) async {
    await Get.toNamed(
      Routes.Mail,
      parameters: {
        'uid': uid.toString(),
        'username': username,
      },
    );
  }
}
