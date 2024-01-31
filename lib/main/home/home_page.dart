import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/page/music_list/music_list_page.dart';
import 'package:play_music/utils/screen_utils.dart';
import 'package:play_music/widget/banner_widget.dart';

import '../../../cache/res_cache_manager.dart';
import '../../page/audio_play/audio_detail_page.dart';
import 'home_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(HomeLogic());

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            height: kToolbarHeight,
          ),
          BannerWidget(width: Get.width, height: 160.dp, list: logic.list),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed(musicListPageRouterName);
                  },
                  child: Text("每日推荐".t)),
              Text("歌单".t),
              Text("排行榜".t),
              Text("有声书".t),
            ],
          ),
        ],
      ),
    );
  }
}
