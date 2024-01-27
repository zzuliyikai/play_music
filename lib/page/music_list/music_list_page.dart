import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/model/music_item.dart';
import 'package:play_music/page/audio_play/audio_play_page.dart';
import 'package:play_music/utils/screen_utils.dart';

import 'music_list_logic.dart';

const String musicListPageRouterName = '/musicListPage';

class MusicListPage extends StatelessWidget {
  MusicListPage({Key? key}) : super(key: key);

  final logic = Get.put(MusicListLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text("音乐列表".t),
      ),
      body: GetBuilder<MusicListLogic>(
        assignId: true,
        builder: (logic) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return buildMusicItem(index);
            },
            itemCount: logic.musicList.length,
          );
        },
      ),
    );
  }

  Widget buildMusicItem(int index) {
    MusicItem musicItem = logic.musicList[index];
    double marginTop = 8.dp;

    if(index != 0) {
      marginTop = 8.dp;
    }


    return InkWell(
      onTap: () {
        Get.toNamed(audioPlayPage, arguments: {
          "name": musicItem.name,
          "url": musicItem.url,
          "author": musicItem.author,
          "preview": musicItem.preview
        });
      },
      child: Container(
        padding:
            EdgeInsets.only(left: 12.dp, right: 12      .dp, top: 8.dp, bottom: 8.dp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.dp)

        ),
        margin: EdgeInsets.only(
          left: 16.dp,
          right: 16.dp,
          top: marginTop
        ),
        child: Row(
          children: [
            Container(
              width: 40.dp,
              height: 40.dp,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(musicItem.preview)),
                  borderRadius: BorderRadius.circular(4.dp)),
            ),
            SizedBox(
              width: 16.dp,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(musicItem.name),
                SizedBox(
                  height: 4.dp,
                ),
                Text(musicItem.author),
              ],
            ),
            Spacer(),
            Icon(Icons.more_vert, color: Colors.grey.shade600,),
          ],
        ),
      ),
    );
  }
}
