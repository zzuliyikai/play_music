import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:play_music/model/music_item.dart';

class AudioPlayLogic extends GetxController {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  late MusicItem musicItem;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    audioPlayer.onAudioPositionChanged.listen((position) {
      print("-------${position.inMilliseconds.toDouble()}");
    });

    // 设置播放完成监听器
    audioPlayer.onPlayerCompletion.listen((event) {
      print('播放已完成');
    });

// 设置播放状态变化监听器
    audioPlayer.onPlayerStateChanged.listen((playerState) {
      // playerState是一个枚举类型，包括：AudioPlayerState.none, playing, paused, stopped
      switch (playerState) {
        case AudioPlayerState.PLAYING:
          print('正在播放');
          break;
        case AudioPlayerState.PAUSED:
          print('已暂停');
          break;
        case AudioPlayerState.STOPPED:
          print('已停止');
          break;
        default:
          print('未知状态');
      }
    });

// 设置错误监听器
    audioPlayer.onPlayerError.listen((msg) {
      print('发生错误: $msg');
    });

    String name = Get.arguments['name'];
    String url = Get.arguments['url'];
    String author = Get.arguments['author'];
    String preview = Get.arguments['preview'];

    musicItem =
        MusicItem(name: name, url: url, author: author, preview: preview);
  }

  Future<void> playMusic(String musicUrl) async {
    print("==========isPlaying == $isPlaying");

    if (isPlaying) {
      return;
    }

    int result =
        await audioPlayer.play(musicUrl, isLocal: false, stayAwake: true);
    if (result == 1) {
      isPlaying = true;
      print("-------");
      update();
    } else {
      print('播放失败');
      print("-------播放失败");
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
