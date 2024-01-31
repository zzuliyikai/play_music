import 'dart:ui';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLogic extends GetxController {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            EasyLoading.show(status: 'loading...');
          },
          onPageFinished: (String url) {
            EasyLoading.dismiss();

          },
          onWebResourceError: (WebResourceError error) {
            EasyLoading.showToast('加载失败'.t);
            EasyLoading.dismiss();

          },
          onNavigationRequest: (NavigationRequest request) {

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.xvideos.com/'));
  }

  @override
  void onReady() {
    super.onReady();
    EasyLoading.show(status: 'loading...');
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    EasyLoading.dismiss();

  }

}
