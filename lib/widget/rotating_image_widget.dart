import 'package:flutter/material.dart';
import 'package:play_music/utils/screen_utils.dart';

class RotatingImageWidget extends StatefulWidget {
  final String url;

  final bool isPlaying;

  const RotatingImageWidget(
      {super.key, required this.url, required this.isPlaying});

  @override
  RotatingImageWidgetState createState() => RotatingImageWidgetState();
}

class RotatingImageWidgetState extends State<RotatingImageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15), // 自定义旋转周期
    );
    // _controller.repeat(); // 开始循环旋转
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 暂停动画
  void pauseAnimation() {
    if (_controller.isAnimating) {
      _controller.stop(canceled: false); // 使用stop方法暂停，canceled为false表示不是取消动画
    }
  }

// 开始或继续动画
  void resumeAnimation() {
    if (!_controller.isAnimating) {
      _controller.forward(); // 使用forward方法从当前位置开始播放到结束
      // 若要从头开始播放，可以先调用_controller.reverse(from: 0.0)然后再调用_forward()
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlaying) {
      if (!_controller.isAnimating) {
        resumeAnimation();
        _controller.repeat();
      }
    } else {
      pauseAnimation();
    }
    return RotationTransition(
        turns: Tween<double>(begin: 0.0, end: 1.0).animate(_controller),
        child: ClipOval(
          child: Image.network(
            widget.url,
            width: 200.dp,
            height: 200.dp,
            fit: BoxFit.cover,
          ),
        ));
  }
}
