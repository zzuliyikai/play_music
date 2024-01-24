import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/page/splash_screen.dart';
import 'package:play_music/utils/ScreenUtils.dart';

import 'localization/localization.dart';

String currentLanguage = "en";

void main() async {
  runApp(const SplashScreen());
  await Future.sync(() => Future.delayed(Duration(seconds: 5))) // 此处可以加载耗时资源
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
        title: 'play music'.t,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(title: 'home'.t),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
        translations: Localization(),
        locale: Locale(currentLanguage));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'hello flutter'.t,
            ),
            TextButton(
                onPressed: () {
                  if (currentLanguage == 'en') {
                    currentLanguage = 'zh_hans';
                  } else {
                    currentLanguage = 'en';
                  }
                  setState(() {});
                },
                child: Text("switch language".t)),

            Container(
              width: 360.dp,
              height: 30.dp,
              color: Colors.red,
            )

          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
