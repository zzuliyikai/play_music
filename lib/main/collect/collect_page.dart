import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';

import 'collect_logic.dart';

class CollectPage extends StatelessWidget {
  const CollectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CollectLogic());

    return Center(
      child: Text("收藏".t),
    );
  }
}
