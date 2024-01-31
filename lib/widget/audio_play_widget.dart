import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:play_music/utils/screen_utils.dart';

import '../model/music_item.dart';

class AudioPlayWidget extends StatefulWidget {
  final List<MusicItem> list;
  final int index;
  final ValueChanged currentPlayIndexListener;
  final ValueChanged isPlayStateListener;

  const AudioPlayWidget(
      {super.key,
      required this.list,
      required this.index,
      required this.currentPlayIndexListener,
      required this.isPlayStateListener});

  @override
  State<AudioPlayWidget> createState() => _AudioPlayWidgetState();
}

class _AudioPlayWidgetState extends State<AudioPlayWidget> {
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  int currentMusicIndex = 0;
  double _progress = 0.0;
  double totalDuration = 0.0;
  StreamSubscription<Duration>? positionSubscription;
  StreamSubscription<void>? completionSubscription;
  bool isDestroy = false;

  @override
  void initState() {
    super.initState();
    widget.isPlayStateListener.call(isPlaying);
    isDestroy = false;
    currentMusicIndex = widget.index;
    audioPlayer = AudioPlayer();
    positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((position) async {
      if (isDestroy) {
        return;
      }

      int duration = await audioPlayer.getDuration();
      totalDuration = duration.toDouble();
      _progress = position.inMilliseconds.toDouble() / duration;
      if (_progress >= 1.0) {
        _progress = 1.0;
      }
      setState(() {});
    });

    // 设置播放完成监听器
    completionSubscription =
        audioPlayer.onPlayerCompletion.listen((event) async {
      if (isDestroy) {
        return;
      }
      isPlaying = false;
      widget.isPlayStateListener.call(isPlaying);
      if (currentMusicIndex == widget.list.length - 1) {
        currentMusicIndex = 0;
      } else {
        currentMusicIndex++;
      }

      _progress = 0.0;
      widget.currentPlayIndexListener.call(currentMusicIndex);
      await audioPlayer.play(widget.list[currentMusicIndex].url,
          isLocal: false, stayAwake: true);
      isPlaying = true;
      widget.isPlayStateListener.call(isPlaying);
      setState(() {});
    });
  }

  @override
  void dispose() {
    isDestroy = true;
    if (positionSubscription != null) {
      positionSubscription!.cancel();
      positionSubscription = null;
    }
    if (completionSubscription != null) {
      completionSubscription!.cancel();
      completionSubscription = null;
    }
    audioPlayer.pause();
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildProgress(),
        IconButton(
            onPressed: () async {
              isPlaying = !isPlaying;
              if (isPlaying) {
                await audioPlayer.play(widget.list[currentMusicIndex].url,
                    isLocal: false, stayAwake: true);
              } else {
                await audioPlayer.pause();
              }
              widget.isPlayStateListener.call(isPlaying);
              setState(() {});
            },
            icon: isPlaying == true
                ? const Icon(Icons.pause)
                : const Icon(Icons.play_arrow))
      ],
    );
  }

  Widget buildProgress() {
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 1.dp, // 设置滑杆高度
          thumbShape:
              RoundSliderThumbShape(enabledThumbRadius: 2.dp), // 设置滑块半径大小
          thumbColor: Colors.white, // 设置滑块颜色
          activeTrackColor: Colors.white, // 设置活动段颜色（滑动过程中显示的颜色）
          inactiveTrackColor: Colors.grey[300], // 设置非活动段颜色（滑动范围之外的颜色）
        ),
        child: Slider(
          value: _progress,
          min: 0,
          max: 1,
          divisions: 100,
          // 可根据需求设置刻度数
          label: '${(_progress * 100).toInt()}%',
          onChanged: _onChanged,
          activeColor: Colors.blue, // 滑块划过的颜色
        ));
  }

  void _onChanged(double value) {
    audioPlayer.play(widget.list[currentMusicIndex].url,
        position: Duration(milliseconds: (value * totalDuration).toInt()),
        isLocal: false,
        stayAwake: true);
  }
}
