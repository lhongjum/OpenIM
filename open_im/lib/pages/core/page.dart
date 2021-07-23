import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suit/suit.dart';

import 'package:open_im/pages/chat/page.dart';
import 'package:open_im/pages/profile/profile.dart';
import 'package:open_im/pages/space/page.dart';
import 'package:open_im/styles/styles.dart';

class CorePage extends StatefulWidget {
  const CorePage({Key? key}) : super(key: key);

  @override
  _CorePageState createState() => _CorePageState();
}

class _CorePageState extends State<CorePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Adapter.initialize(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyView(),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  IndexedStack bodyView() {
    return IndexedStack(
      index: _currentIndex,
      children: [
        ChatPage(),
        SpacePage(),
        ProfilePage(),
      ],
    );
  }

  BottomNavigationBar bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: getNavBarItems(),
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
    );
  }

  List<BottomNavigationBarItem> getNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(IconX.xiaoxi, width: 32),
        label: '聊天',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(IconX.yundong, width: 32),
        label: '动态',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(IconX.wode, width: 32),
        label: '我的',
      ),
    ];
  }
}
