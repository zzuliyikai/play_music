import 'package:cached_network_image/cached_network_image.dart';
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.dp),
          child: CachedNetworkImage(
              imageUrl: widget.list[index].url, fit: BoxFit.cover),
        ),
      );
    } else if (index == 1) {
      return Container(
        margin: EdgeInsets.all(16.dp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.dp),
          child: CachedNetworkImage(
              imageUrl: widget.list[index].url, fit: BoxFit.cover),
        ),
      );
    } else if (index == 2) {
      return Container(
        margin: EdgeInsets.all(16.dp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.dp),
          child: CachedNetworkImage(
              imageUrl: widget.list[index].url, fit: BoxFit.cover),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.all(16.dp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.dp),
          child: CachedNetworkImage(
              imageUrl: widget.list[index].url, fit: BoxFit.cover),
        ),
      );
    }
  }
}
