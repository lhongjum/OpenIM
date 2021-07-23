import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:open_im/mock/mock.dart';
import 'package:open_im/styles/styles.dart';
import 'package:open_im/widgets/button/button.dart';

class MailPage extends StatefulWidget {
  const MailPage({Key? key}) : super(key: key);

  @override
  _MailPageState createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _msgList = [
    {
      'isMe': true,
      'avatar': Mock.avatar,
      'message': 'Heloise',
    },
    {
      'isMe': true,
      'avatar': Mock.avatar,
      'message': 'Heloise',
    },
    {
      'isMe': true,
      'avatar': Mock.avatar,
      'message': 'Heloise',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(
        uid: int.tryParse(Get.parameters['uid']!)!,
        username: Get.parameters['username']!,
      ),
      body: bodyView(),
    );
  }

  Widget bodyView() {
    return SafeArea(
      child: Column(
        children: [
          showMsgsView(),
          userActionsView(),
        ],
      ),
    );
  }

  Widget showMsgsView() {
    return Expanded(
      child: CupertinoScrollbar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: msgsView(),
        ),
      ),
    );
  }

  Widget msgsView() {
    return ListView.builder(
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemCount: _msgList.length,
      itemBuilder: (BuildContext context, int index) {
        final revIndex = _msgList.length - index - 1;
        return ChatBubbleWidget(
          isMe: _msgList[revIndex]['isMe'],
          avatar: _msgList[revIndex]['avatar'],
          message: _msgList[revIndex]['message'],
        );
      },
    );
  }

  Widget userActionsView() {
    const edgeInsets = const EdgeInsets.symmetric(horizontal: 16, vertical: 4);
    var boxDecoration = BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
    );
    var iconThemeData = IconThemeData(
      color: Colors.black,
    );
    return Container(
      height: 64,
      margin: edgeInsets,
      padding: edgeInsets,
      decoration: boxDecoration,
      child: Theme(
        data: ThemeData(
          iconTheme: iconThemeData,
        ),
        child: Row(
          children: [
            inputTextView(),
            IconButton(
              onPressed: () {
                // TODO: 发送表情功能
              },
              icon: Icon(Icons.face_outlined),
              tooltip: '选择表情',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _msgList.add({
                    'isMe': true,
                    'avatar': Mock.avatar,
                    'message': _controller.text,
                  });
                });
                _controller.text = '';
              },
              icon: Icon(Icons.flight_outlined),
              tooltip: '发送消息',
            ),
          ],
        ),
      ),
    );
  }

  Widget inputTextView() {
    var inputDecoration = InputDecoration(
      focusColor: Colors.black,
      hintText: '输入文本',
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
    return Expanded(
      child: Theme(
        data: ThemeData(
          backgroundColor: Colors.black,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionColor: Colors.white,
          ),
        ),
        child: TextField(
          maxLines: null,
          keyboardType: TextInputType.multiline,
          controller: _controller,
          decoration: inputDecoration,
        ),
      ),
    );
  }
}

class ChatBubbleWidget extends StatelessWidget {
  const ChatBubbleWidget({
    Key? key,
    required this.isMe,
    required this.avatar,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final String avatar;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(avatar),
          ),
          SizedBox(width: 12),
          msgView(),
        ],
      ),
    );
  }

  Widget msgView() {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: ColorX.bluePurple,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SelectableText(message),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  const _AppBar({
    Key? key,
    required this.uid,
    required this.username,
  }) : super(key: key);

  final int uid;
  final String username;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: BackBtn(),
      title: Text(username),
      centerTitle: true,
      actions: actionsView(),
    );
  }

  List<Widget> actionsView() {
    return [
      IconButton(
        onPressed: () {
          // TODO: 跳转至语音通话页
        },
        icon: Icon(Icons.phone),
        tooltip: '语音通话',
      ),
      IconButton(
        onPressed: () {
          // TODO: 跳转至个人信息页
        },
        icon: Icon(Icons.person),
        tooltip: '好友信息',
      ),
    ];
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
