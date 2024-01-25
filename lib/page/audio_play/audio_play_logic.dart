import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioPlayLogic extends GetxController {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
  }

  Future<void> playMusic(String musicUrl) async {
    int result = await audioPlayer.play(musicUrl);
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
    audioPlayer.stop(); // 结束播放并释放资源
    audioPlayer.dispose();
    super.onClose();
  }
}
