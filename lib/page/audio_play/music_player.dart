import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  final String musicUrl; // 音乐文件的URL

  const MusicPlayer({Key? key, required this.musicUrl}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> with WidgetsBindingObserver {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.stop(); // 结束播放并释放资源
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playMusic() async {
    int result = await audioPlayer.play(widget.musicUrl);

    if (result == 1) {
      setState(() {
        isPlaying = true;
      });
    } else {
      print('播放失败');
    }
  }

  Future<void> pauseMusic() async {
    await audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed && isPlaying) {
      audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: isPlaying ? pauseMusic : playMusic,
              child: Text(isPlaying ? '暂停' : '播放'),
            ),
          ],
        ),
      ),
    );
  }
}