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

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("播放详情".t),
        ),
        body: Center(
          child: Column(
            children: [
              TextButton(
                onPressed: () {

                  logic.playMusic(logic.musicItem.url);
                  // ResCacheManager.download(logic.musicItem.url, "mp3")
                  //     .then((value) {
                  //   if (value != null) {
                  //     logic.playMusic(value);
                  //   }
                  // });
                },
                child: Text("播放".t),
              ),
              TextButton(
                  onPressed: () {
                    logic.pauseMusic();
                  },
                  child: Text("暂停".t))
            ],
          ),
        ),
      ),
    );
  }
}
