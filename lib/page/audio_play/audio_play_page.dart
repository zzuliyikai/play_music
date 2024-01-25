import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/cache/res_cache_manager.dart';
import 'package:play_music/localization/localization_ext.dart';

import 'audio_play_logic.dart';

const String audioPlayPage = "/audioPlay";

class AudioPlayPage extends StatelessWidget {
  const AudioPlayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AudioPlayLogic());

    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ResCacheManager.download(
                    "http://zzyikai.store/music/bencao.mp3", "mp3")
                .then((value) {
              if (value != null) {
                logic.playMusic(value);
              }
            });
          },
          child: Text("播放".t),
        ),
      ),
    );
  }
}
