import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:play_music/cache/res_cache_manager.dart';
import 'package:play_music/model/music_item.dart';

class MusicListLogic extends GetxController {
  List<MusicItem> musicList = [];

  @override
  void onReady() {
    super.onReady();

    ResCacheManager.download("http://117.50.174.22:80/musicJson", ".txt")
        .then((value) {
      // 读取文件中左右的数据
      if (value != null) {
        final file = File(value);
        String musicListJson = file.readAsStringSync();

        List<dynamic> jsonStringList = jsonDecode(musicListJson);

        musicList.clear();
        int index = 0;
        musicList = jsonStringList.map((jsonMap) {
          jsonMap['preview'] =
              'http://117.50.174.22:80/beautiful/${(index % 13) + 1}.jpg';
          index++;
          return MusicItem.fromJson(jsonMap);
        }).toList();
        update();
      }
    });
  }
}
