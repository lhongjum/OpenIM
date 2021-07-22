import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:open_im/widgets/monitor/monitor.dart';

class ListenWidget extends StatelessWidget {
  const ListenWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  void _onPaused() {
    print('离开App');
  }

  Future<void> _onResumed() async {
    final res = await Clipboard.getData(Clipboard.kTextPlain);
    if (res == null) return;

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return MonitorWidget(
      child: child,
      onPaused: _onPaused,
      onResumed: _onResumed,
    );
  }
}
