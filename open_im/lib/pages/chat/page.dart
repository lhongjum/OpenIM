import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:open_im/mock/mock.dart';
import 'package:open_im/styles/styles.dart';

import 'logic.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: CupertinoScrollbar(
        child: ListView(
          physics: ScrollX.physics,
          children: [
            _LastMsgWidget(
              uid: 0,
              username: '魔咔啦咔',
              avatarURL: Mock.avatar,
              datetime: '19:22',
              unreadCounter: 5,
              message: '尝尝这个味道怎么样呢~',
            ),
            _LastMsgWidget(
              uid: 1,
              username: '魔咔啦咔',
              avatarURL: Mock.avatar,
              datetime: '19:22',
              unreadCounter: 5,
              message: '尝尝这个味道怎么样呢~',
            ),
            _LastMsgWidget(
              uid: 2,
              username: '魔咔啦咔',
              avatarURL: Mock.avatar,
              datetime: '19:22',
              unreadCounter: 5,
              message: '尝尝这个味道怎么样呢~',
            ),
          ],
        ),
      ),
    );
  }
}

class _LastMsgWidget extends StatelessWidget {
  const _LastMsgWidget({
    Key? key,
    required this.uid,
    required this.username,
    required this.avatarURL,
    required this.datetime,
    required this.unreadCounter,
    required this.message,
  }) : super(key: key);

  final int uid;
  final String username;
  final String avatarURL;

  final String datetime;
  final int unreadCounter;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(Mock.avatar),
      ),
      title: Text(username, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: trailingView(),
      onTap: () => ChatLogic.openMailPage(uid, username),
    );
  }

  Widget trailingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(datetime),
        unreadView(),
      ],
    );
  }

  Widget unreadView() {
    return Container(
      alignment: Alignment.center,
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.red[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        unreadCounter <= 99 ? unreadCounter.toString() : '99+',
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: avatarView(),
      title: Text('消息'),
      centerTitle: true,
      actions: actionsView(),
    );
  }

  Widget avatarView() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: GestureDetector(
        onTap: () {
          // TODO: 跳转至个人二维码页
          print('看看我的二维码');
        },
        child: CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(Mock.avatar),
        ),
      ),
    );
  }

  List<Widget> actionsView() {
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.search_rounded),
        tooltip: '查找好友',
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.add_circle_outline_rounded),
        tooltip: '搜索用户',
      ),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
