import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:play_music/main/main_page.dart';
import 'package:play_music/page/audio_play/audio_detail_page.dart';
import 'package:play_music/page/music_list/music_list_page.dart';
import 'package:play_music/page/recommend/recommend_view.dart';
import 'package:play_music/page/web_view/web_view_page.dart';

final List<GetPage> router = [
  GetPage(name: '/', page: () => const MainPage()),
  GetPage(name: recommendName, page: () => const RecommendPage()),
  GetPage(name: audioDetailRouterName, page: () => const AudioDetailPage()),
  GetPage(name: musicListPageRouterName, page: () => MusicListPage()),
  GetPage(name: webViewPageRouterName, page: () => WebViewPage()),
];
