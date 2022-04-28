import 'dart:async';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:music_player/controllers/page_manager.dart';
import 'package:music_player/services/service_locator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen(this.pageController, {Key? key}) : super(key: key);
  final PageController pageController;
  final _pageManager = getIt<PageManager>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageManager.onBackPressed) {
          return true;
        } //
        else {
          _pageManager.onBackPressed = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff4b152c),
                          Color(0xff27163b),
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white.withOpacity(0.03),
                        ),
                        child: const Text(
                          'Double-click the back button to exit the app.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              duration: const Duration(milliseconds: 2200),
              elevation: 0,
            ),
          );
          Timer(const Duration(milliseconds: 2200), () {
            _pageManager.onBackPressed = false;
          });
          return false;
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff4b152c),
                    Color(0xff27163b),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                border: Border(bottom: BorderSide(color: Colors.white)),
              ),
              child: const Center(
                child: Text(
                  'Playlist',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _pageManager.playlistNotifier,
                builder: (context, List<MediaItem> song, child) {
                  if (song.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  } //
                  else {
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: song.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            song[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            song[index].artist ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            pageController.animateToPage(
                              1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                            _pageManager.playFromPlaylist(index);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          color: Colors.white,
                          height: 1,
                          thickness: 0.8,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _pageManager.currentSongDetailNotifier,
              builder: (context, MediaItem audio, _) {
                if (audio.id == '-1') {
                  return Container();
                } //
                else {
                  return Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff4b152c),
                          Color(0xff27163b),
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ),
                      border: Border(top: BorderSide(color: Colors.white)),
                    ),
                    child: ListTile(
                      onTap: () {
                        pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutQuart,
                        );
                      },
                      leading: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(audio.artUri.toString()),
                      ),
                      title: Text(
                        audio.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        audio.artist ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: ValueListenableBuilder(
                          valueListenable: _pageManager.buttonNotifier,
                          builder: (context, ButtonState value, _) {
                            switch (value) {
                              case ButtonState.loading:
                                return const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  ),
                                );
                              case ButtonState.playing:
                                return IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: _pageManager.pause,
                                  icon: const Icon(
                                    Icons.pause_circle_outline_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                );
                              case ButtonState.paused:
                                return IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.play_circle_outline_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  onPressed: _pageManager.play,
                                );
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
