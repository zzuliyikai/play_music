import 'package:flutter/material.dart';
import 'package:play_music/utils/screen_utils.dart';

import '../model/banner_info.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.list});

  final double width;
  final double height;
  final List<BannerInfo> list;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return buildPageViewItem(index);
        },
        itemCount: widget.list.length,
      ),
    );
  }

  Widget buildPageViewItem(int index) {
    if (index == 0) {
      return Container(
        margin: EdgeInsets.all(16.dp),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(8.dp)),
        child: Center(
          child: Text(widget.list[index].desc),
        ),
      );
    } else if (index == 1) {
      return Container(
        margin: EdgeInsets.all(16.dp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.dp),
            image:
                DecorationImage(image: NetworkImage(widget.list[index].url), fit: BoxFit.cover)),
        child: Center(
          child: Text(widget.list[index].desc),
        ),
      );
    } else if (index == 2) {
      return Container(
        margin: EdgeInsets.all(16.dp),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(8.dp)),
        child: Center(
          child: Text(widget.list[index].desc),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(16.dp),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(8.dp)),
        child: Center(
          child: Text(widget.list[index].desc),
        ),
      );
    }
  }
}
