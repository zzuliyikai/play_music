import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatefulWidget {
  final AudioPlayer positionChange;
  const ProgressBarWidget({super.key, required this.positionChange});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  double _progress = 0.5;



  void _onChanged(double value) {
    setState(() {
      _progress = value;
    });
    // 在这里处理进度变化，比如保存到状态管理或调用API更新进度等
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _progress,
      min: 0,
      max: 1,
      divisions: 100,
      // 可根据需求设置刻度数
      label: '${(_progress * 100).toInt()}%',
      onChanged: _onChanged,
      activeColor: Colors.blue, // 滑块划过的颜色
    );
  }
}
