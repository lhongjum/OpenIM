import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:open_im/global/global.dart';
import 'package:open_im/router/router.dart';
import 'package:open_im/styles/styles.dart';
import 'package:open_im/tools/i18n/i18n.dart';

import 'init.dart';
import 'preview.dart';

class Core extends StatefulWidget {
  const Core({Key? key}) : super(key: key);

  @override
  _CoreState createState() => _CoreState();
}

class _CoreState extends State<Core> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initializeLate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: I18n.delegates,
      supportedLocales: I18n.supportedLocales,
      debugShowCheckedModeBanner: false,
      enableLog: !kReleaseMode,
      builder: Preview.builder,
      locale: Preview.locale(context),
      getPages: RouterX.routes,
      initialRoute: RouterX.initRoute,
      theme: ThemeX.lightGlobal,
      title: AppMeta.name,
    );
  }
}
