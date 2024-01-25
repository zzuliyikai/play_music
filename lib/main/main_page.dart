import 'package:flutter/material.dart';
import 'package:play_music/localization/localization_ext.dart';
import 'package:play_music/main/collect/collect_page.dart';
import 'package:play_music/main/home/home_page.dart';
import 'package:play_music/main/profile/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [HomePage(), CollectPage(), ProfilePage()],
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: "首页".t),
        BottomNavigationBarItem(
            icon: const Icon(Icons.collections), label: "收藏".t),
        BottomNavigationBarItem(icon: const Icon(Icons.person), label: "我的".t),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        _currentIndex = index;
        setState(() {});
      },
    );
  }
}
