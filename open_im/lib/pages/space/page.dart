import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suit/suit.dart';

import 'package:open_im/mock/mock.dart';
import 'package:open_im/styles/styles.dart';

class SpacePage extends StatefulWidget {
  const SpacePage({Key? key}) : super(key: key);

  @override
  _SpacePageState createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            physics: ScrollX.physics,
            children: [
              DynamicCardWidget(
                uid: 0,
                username: 'username',
                avatarURL: 'avatarURL',
                datetime: 'datetime',
                did: 'did',
                content: 'content',
                images: [
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                ],
                isLiked: true,
                likeCount: 0,
                commentCount: 0,
                forwardCount: 0,
              ),
              DynamicCardWidget(
                uid: 0,
                username: 'username',
                avatarURL: 'avatarURL',
                datetime: 'datetime',
                did: 'did',
                content: 'content',
                images: [
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                  Mock.avatar,
                ],
                isLiked: true,
                likeCount: 0,
                commentCount: 0,
                forwardCount: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DynamicCardWidget extends StatelessWidget {
  const DynamicCardWidget({
    Key? key,
    required this.uid,
    required this.username,
    required this.avatarURL,
    required this.datetime,
    required this.did,
    required this.content,
    required this.images,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
    required this.forwardCount,
  }) : super(key: key);

  final int uid;
  final String username;
  final String avatarURL;
  final String datetime;

  final String did;
  final String content;
  final List<String> images;

  final bool isLiked;

  final int likeCount;
  final int commentCount;
  final int forwardCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topView(),
          SelectableText(content),
          SizedBox(height: 8),
          showImagesView(),
          SizedBox(height: 12),
          bottomView(),
        ],
      ),
    );
  }

  Widget bottomView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _UserLikeWidget(
          isLiked: true,
          likeCount: 52,
        ),
        _UserGoToWidget(
          icon: Icons.message_rounded,
          count: 65,
          to: '/',
        ),
        _UserGoToWidget(
          icon: Icons.share_rounded,
          count: 65,
          to: '/',
        ),
      ],
    );
  }

  Widget showImagesView() {
    if (images.length <= 0) {
      return SizedBox();
    } else if (images.length == 1) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            Mock.avatar,
            height: 24.vh,
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 24.vh,
        child: ListView(
          physics: ScrollX.physics,
          scrollDirection: Axis.horizontal,
          children: List.generate(
            images.length,
            (int idx) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(images[idx]),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget topView() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(Mock.avatar),
        ),
        SizedBox(width: 12),
        metaAndActionsView(),
      ],
    );
  }

  Widget metaAndActionsView() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          metaView(),
          Text('data'),
        ],
      ),
    );
  }

  Widget metaView() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '王思若颖',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('23:58'),
        ],
      ),
    );
  }
}

class _UserGoToWidget extends StatelessWidget {
  const _UserGoToWidget({
    Key? key,
    required this.icon,
    required this.count,
    required this.to,
  }) : super(key: key);

  final IconData icon;
  final int count;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => Get.toNamed(to),
          icon: Icon(icon),
        ),
        Text(count.toString()),
      ],
    );
  }
}

class _UserLikeWidget extends StatefulWidget {
  const _UserLikeWidget({
    Key? key,
    required this.isLiked,
    required this.likeCount,
  }) : super(key: key);

  final bool isLiked;
  final int likeCount;

  @override
  _UserLikeWidgetState createState() => _UserLikeWidgetState();
}

class _UserLikeWidgetState extends State<_UserLikeWidget> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _onClick,
          icon: isLiked
              ? Icon(
                  Icons.favorite_rounded,
                  color: Colors.red[200],
                )
              : Icon(
                  Icons.favorite_outline,
                ),
        ),
        Text(likeCount.toString()),
      ],
    );
  }

  Future<void> _onClick() async {
    setState(() {
      isLiked = !isLiked;
    });
    isLiked ? likeCount++ : likeCount--;
  }
}
