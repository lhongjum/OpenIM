import 'package:flutter/material.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () => Navigator.of(context).pop(),
      tooltip: '返回',
    );
  }
}
