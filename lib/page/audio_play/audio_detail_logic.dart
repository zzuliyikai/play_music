import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:play_music/model/music_item.dart';

import '../music_list/music_list_logic.dart';

class AudioDetailLogic extends GetxController {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  late MusicItem musicItem;
  var musicListLogic = Get.find<MusicListLogic>();
  int currentPlayIndex = 0;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((position) async {
      print("-------${position.inMilliseconds.toDouble()}");
      int duration = await audioPlayer.getDuration();
      print("---------duration ${duration}");



    });

    // 设置播放完成监听器
    audioPlayer.onPlayerCompletion.listen((event) {
      isPlaying = false;
      currentPlayIndex++;
      musicItem = musicListLogic.musicList[currentPlayIndex];
      playMusic(musicItem.url);
    });

    currentPlayIndex = Get.arguments['index'];

    musicItem = musicListLogic.musicList[currentPlayIndex];
  }

  Future<void> playMusic(String musicUrl) async {
    if (isPlaying) {
      return;
    }

    int result =
        await audioPlayer.play(musicUrl, isLocal: false, stayAwake: true);
    if (result == 1) {
      isPlaying = true;
      update();
    } else {
      print('播放失败');
    }
  }

  Future<void> pauseMusic() async {
    await audioPlayer.pause();
    isPlaying = false;
    update();
  }

  @override
  void onClose() {
    pauseMusic();
    audioPlayer.stop(); // 结束播放并释放资源
    audioPlayer.dispose();
    super.onClose();
  }
}
