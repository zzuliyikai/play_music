import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/page/splash_screen.dart';
import 'package:play_music/router.dart';
import 'package:play_music/utils/screen_utils.dart';

import 'localization/localization.dart';

String currentLanguage = "en";

void main() async {
  runApp(const SplashScreen());
  await Future.sync(
          () => Future.delayed(const Duration(seconds: 1))) // 此处可以加载耗时资源
      .then((value) => runApp(const MyApp()))
      .then((value) {
    ScreenUtils.init(360);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: router,
      title: '玩音乐'.t,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
      translations: Localization(),
      locale: Locale(currentLanguage),
      defaultTransition: Transition.rightToLeft,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
