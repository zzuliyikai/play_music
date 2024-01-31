import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'web_view_logic.dart';

const String webViewPageRouterName = "/webViewPage";

class WebViewPage extends StatelessWidget {
  WebViewPage({Key? key}) : super(key: key);

  final logic = Get.put(WebViewLogic());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await logic.controller.canGoBack()) {
          // 如果WebView可以后退，则执行后退操作而不是退出应用
          await logic.controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("福利页面".t),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async{
              if (await logic.controller.canGoBack()){
                await logic.controller.goBack();
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: WebViewWidget(controller: logic.controller),
      ),
    );
  }
}
