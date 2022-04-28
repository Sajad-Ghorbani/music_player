import 'dart:ui';
import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/controllers/page_manager.dart';
import 'package:music_player/services/service_locator.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen(this.controller, {Key? key}) : super(key: key);
  final PageController controller;

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final _pageManager = getIt<PageManager>();

  bool onLikeTapped = false;

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox.expand(
          child: ValueListenableBuilder(
            valueListenable: _pageManager.currentSongDetailNotifier,
            builder: (context, MediaItem value, child) {
              if (value.id == '-1') {
                return Image.asset(
                  'assets/images/default.jpg',
                  fit: BoxFit.cover,
                );
              } //
              else {
                String image = value.artUri.toString();
                return FadeInImage(
                  placeholder: const AssetImage('assets/images/default.jpg'),
                  image: NetworkImage(
                    image,
                  ),
                  fit: BoxFit.cover,
                );
              }
            },
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
          child: Container(
            color: Colors.grey[900]!.withOpacity(0.6),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.controller.animateToPage(
                                0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Now Playing',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Scaffold.of(context).openEndDrawer();
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    ValueListenableBuilder(
                      valueListenable: _pageManager.currentSongDetailNotifier,
                      builder: (context, MediaItem value, child) {
                        if (value.id == '-1') {
                          return const CircleAvatar(
                            radius: 110,
                            backgroundImage:
                                AssetImage('assets/images/default.jpg'),
                          );
                        } //
                        else {
                          String image = value.artUri.toString();
                          return CircleAvatar(
                            radius: 110,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(110),
                              child: FadeInImage(
                                height: 220,
                                placeholder: const AssetImage(
                                    'assets/images/default.jpg'),
                                image: NetworkImage(
                                  image,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable:
                              _pageManager.currentSongDetailNotifier,
                          builder: (context, MediaItem value, child) {
                            String title = value.title;
                            String artist = value.artist ?? '';
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artist,
                                  style: const TextStyle(
                                      fontSize: 35,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white),
                                ),
                              ],
                            );
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              onLikeTapped = !onLikeTapped;
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 35,
                            color: onLikeTapped ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ValueListenableBuilder<ProgressBarState>(
                        valueListenable: _pageManager.progressNotifier,
                        builder: (context, value, _) {
                          return ProgressBar(
                            progress: value.current,
                            total: value.total,
                            buffered: value.buffered,
                            thumbColor: Colors.white,
                            progressBarColor: Colors.redAccent,
                            baseBarColor: Colors.grey.withOpacity(0.7),
                            bufferedBarColor: Colors.redAccent.withOpacity(0.5),
                            thumbGlowColor: Colors.redAccent.withOpacity(0.25),
                            timeLabelTextStyle: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            onSeek: _pageManager.seek,
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: _pageManager.repeatStateNotifier,
                          builder: (context, repeatState value, child) {
                            switch (value) {
                              case repeatState.off:
                                return IconButton(
                                  icon: const Icon(
                                    Icons.east_rounded,
                                    size: 35,
                                  ),
                                  onPressed: _pageManager.onRepeatPressed,
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                );
                              case repeatState.one:
                                return IconButton(
                                  icon: const Icon(
                                    Icons.repeat_one_rounded,
                                    size: 35,
                                  ),
                                  onPressed: _pageManager.onRepeatPressed,
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                );
                              case repeatState.all:
                                return IconButton(
                                  icon: const Icon(
                                    Icons.repeat_rounded,
                                    size: 35,
                                  ),
                                  onPressed: _pageManager.onRepeatPressed,
                                  color: Colors.white,
                                  padding: EdgeInsets.zero,
                                );
                            }
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: _pageManager.isFirstSongNotifier,
                          builder: (context, bool value, child) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 35,
                              ),
                              color: Colors.white,
                              onPressed:
                                  value ? null : _pageManager.onPreviousPressed,
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.redAccent,
                                  Color(0xCC722520),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft,
                              )),
                          child: ValueListenableBuilder<ButtonState>(
                            valueListenable: _pageManager.buttonNotifier,
                            builder: (context, ButtonState value, _) {
                              switch (value) {
                                case ButtonState.loading:
                                  return const Padding(
                                    padding: EdgeInsets.all(6.0),
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
                                      Icons.pause,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  );
                                case ButtonState.paused:
                                  return IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    onPressed: _pageManager.play,
                                  );
                              }
                            },
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: _pageManager.isLastSongNotifier,
                          builder: (context, bool value, child) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 35,
                              ),
                              color: Colors.white,
                              onPressed:
                                  value ? null : _pageManager.onNextPressed,
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: _pageManager.volumeStateNotifier,
                          builder: (context, double value, child) {
                            if (value == 0) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.volume_off_rounded,
                                  size: 35,
                                ),
                                color: Colors.white,
                                onPressed: _pageManager.onVolumePressed,
                              );
                            } //
                            else {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.volume_up_rounded,
                                  size: 35,
                                ),
                                color: Colors.white,
                                onPressed: _pageManager.onVolumePressed,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
