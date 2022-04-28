import 'package:flutter/material.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/screens/music_player_screen.dart';
import 'package:music_player/services/service_locator.dart';
import 'package:music_player/widgets/custom_drawer.dart';

import 'controllers/page_manager.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController controller = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    getIt<PageManager>().init();
  }

  @override
  void dispose() {
    getIt<PageManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Ubuntu'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        endDrawer: const CustomDrawer(),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4b152c),
                Color(0xff27163b),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: PageView(
            controller: controller,
            scrollDirection: Axis.vertical,
            children: [
              HomeScreen(controller),
              WillPopScope(
                onWillPop: () async {
                  controller.animateToPage(0,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut);
                  return false;
                },
                child: MusicPlayerScreen(controller),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
