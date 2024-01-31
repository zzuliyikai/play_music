import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/utils/screen_utils.dart';
import '../../widget/audio_play_widget.dart';
import '../../widget/rotating_image_widget.dart';
import 'audio_detail_logic.dart';

const String audioDetailRouterName = "/audioDetail";

class AudioDetailPage extends StatelessWidget {
  const AudioDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(AudioDetailLogic());

    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("播放详情".t),
        ),
        body: Column(
          children: [
            Expanded(child: GetBuilder<AudioDetailLogic>(builder: (logic) {
              return Column(
                children: [
                  Text(logic
                      .musicListLogic.musicList[logic.currentPlayIndex].name),
                  SizedBox(
                    height: 30.dp,
                  ),
                  RotatingImageWidget(
                    url: logic.musicListLogic.musicList[logic.currentPlayIndex]
                        .preview,
                    isPlaying: logic.isPlaying,
                  ),
                ],
              );
            })),
            AudioPlayWidget(
                list: logic.musicListLogic.musicList,
                index: logic.currentPlayIndex,
                currentPlayIndexListener: (index) {
                  logic.currentPlayIndex = index;
                  logic.update();
                },
                isPlayStateListener: (state) {
                  logic.isPlaying = state;
                  logic.update();
                }),
          ],
        ),
      ),
    );
  }
}
