import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:play_music/main/main_page.dart';
import 'package:play_music/page/audio_play/audio_play_page.dart';
import 'package:play_music/page/recommend/recommend_view.dart';

final List<GetPage> router = [
  GetPage(name: '/', page: () => const MainPage()),
  GetPage(name: recommendName, page: () => const RecommendPage()),
  GetPage(name: audioPlayPage, page: () => const AudioPlayPage()),
];
