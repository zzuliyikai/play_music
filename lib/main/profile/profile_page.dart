import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';

import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileLogic());

    return Center(
      child: Text("我的".t),
    );
  }
}
