

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/NowPlayPro/now_play.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/db/widgets/text_aling.dart';
import 'package:flutter_project_week8/properites/Favorite/widgets/favorite_button.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class NowPlayMusic extends StatelessWidget {
  NowPlayMusic({
    super.key,
    required this.playersongs,
  });
  final List<SongModel> playersongs;
  bool _isSuffle = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NowPlayPro>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<NowPlayPro>(context, listen: false).moutedFun();
    });
    

    return Consumer<NowPlayPro>(
      builder: (context, value, child) {
        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.black,
              ],
              stops: [
                0.5,
                1,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            provider;
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                          ),
                          color: Colors.white,
                          iconSize: 40,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 400,
                                width: 300,
                                child: Consumer<NowPlayPro>(
                                    builder: (context, value, child) {
                                       print(playersongs.toString());
                                  return QueryArtworkWidget(
                                    keepOldArtwork: true,
                                    id: playersongs[value.currentIndex].id,
                                    quality: 100,
                                    type: ArtworkType.AUDIO,
                                    artworkFit: BoxFit.fill,
                                    artworkBorder: BorderRadius.circular(50),
                                    nullArtworkWidget: Lottie.asset(
                                      "assets/musi.json",
                                    ),
                                    artworkWidth: 300,
                                    artworkHeight: 400,
                                  );
                                }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      children: [
                                        AnimatedText(
                                          text: playersongs[value.currentIndex]
                                              .displayNameWOExt,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(
                                                playersongs[value.currentIndex]
                                                            .artist
                                                            .toString() ==
                                                        "<unknown>"
                                                    ? "Unknown Artist"
                                                    : playersongs[
                                                            value.currentIndex]
                                                        .artist
                                                        .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                icon:
                                                    const Icon(Icons.volume_up),
                                                color: Colors.white,
                                                onPressed: () {
                                                  showSliderDialog(
                                                    context: context,
                                                    title: "Adjust Volume",
                                                    divisions: 10,
                                                    min: 0.0,
                                                    max: 1.0,
                                                    value:
                                                        GetSongs.player.volume,
                                                    stream: GetSongs
                                                        .player.volumeStream,
                                                    onChanged: GetSongs
                                                        .player.setVolume,
                                                  );
                                                },
                                              ),
                                            ),
                                            StreamBuilder<double>(
                                              stream:
                                                  GetSongs.player.speedStream,
                                              builder: (context, snapshot) =>
                                                  Expanded(
                                                child: IconButton(
                                                  icon: Text(
                                                    "${snapshot.data?.toStringAsFixed(1)}x",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    showSliderDialog(
                                                      context: context,
                                                      title: "Adjust Speed",
                                                      divisions: 10,
                                                      min: 0.5,
                                                      max: 1.5,
                                                      value:
                                                          GetSongs.player.speed,
                                                      stream: GetSongs
                                                          .player.speedStream,
                                                      onChanged: GetSongs
                                                          .player.setSpeed,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  FavoriteButton(
                                    song: playersongs[value.currentIndex],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              StreamBuilder<DurationState>(
                                stream: _durationStateStream,
                                builder: (context, snapshot) {
                                  final durationState = snapshot.data;
                                  final progress =
                                      durationState?.postion ?? Duration.zero;
                                  final total =
                                      durationState?.total ?? Duration.zero;
                                  return ProgressBar(
                                    timeLabelTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    progress: progress,
                                    total: total,
                                    barHeight: 3.0,
                                    thumbRadius: 5,
                                    progressBarColor: Colors.white,
                                    baseBarColor: Colors.white,
                                    bufferedBarColor: Colors.grey,
                                    buffered: const Duration(
                                      microseconds: 2000,
                                    ),
                                    onSeek: (duration) {
                                      GetSongs.player.seek(duration);
                                    },
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                      ),
                                      child: StreamBuilder<bool>(
                                        stream: GetSongs
                                            .player.shuffleModeEnabledStream,
                                        builder: (context, snapshot) {
                                          return _suffleButton(
                                              context, snapshot.data ?? false);
                                        },
                                      )
                                      // ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //         elevation: 0,
                                      //         padding: const EdgeInsets.all(
                                      //           15,
                                      //         ),
                                      //         backgroundColor: Colors.transparent,
                                      //         foregroundColor: Colors.black),
                                      //     onPressed: () async {
                                      //       _isSuffle == false
                                      //           ? await GetSongs.player
                                      //               .setShuffleModeEnabled(true)

                                      //           : await GetSongs.player
                                      //               .setShuffleModeEnabled(false);
                                      //       const ScaffoldMessenger(
                                      //         child: SnackBar(
                                      //           content: Text(
                                      //             "Suffle Enabled",
                                      //           ),
                                      //         ),
                                      //       );
                                      //     },
                                      //     child: StreamBuilder<bool>(
                                      //   stream: GetSongs
                                      //       .player.shuffleModeEnabledStream,
                                      //   builder:
                                      //       (context, AsyncSnapshot snapshot) {
                                      //         log(snapshot.data.toString());
                                      //     // _isSuffle = snapshot.data;
                                      //     if (_isSuffle) {
                                      //       return Icon(
                                      //         Icons.shuffle,
                                      //         color: Colors.green[800],
                                      //         size: 35,
                                      //       );
                                      //     } else {
                                      //       return const Icon(
                                      //         Icons.shuffle,
                                      //         size: 35,
                                      //         color: Colors.white,
                                      //       );
                                      //     }
                                      //   }),
                                      //     ),
                                      ),
                                  IconButton(
                                    onPressed: () async {
                                      if (GetSongs.player.hasPrevious) {
                                        await GetSongs.player.seekToPrevious();
                                        await GetSongs.player.play();
                                      } else {
                                        await GetSongs.player.play();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, top: 15),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.green,
                                      ),
                                      onPressed: () async {
                                        if (GetSongs.player.playing) {
                                          await GetSongs.player.pause();
                                          provider;
                                        } else {
                                          await GetSongs.player.play();
                                          provider;
                                        }
                                      },
                                      child: StreamBuilder<bool>(
                                        stream: GetSongs.player.playingStream,
                                        builder: (context, snapshot) {
                                          bool? playingStage = snapshot.data;
                                          if (playingStage != null &&
                                              playingStage) {
                                            return const Icon(
                                              Icons.pause_circle_outline,
                                              size: 60,
                                            );
                                          } else {
                                            return const Icon(
                                              Icons.play_circle_outline,
                                              size: 60,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    highlightColor: Colors.green,
                                    onPressed: () async {
                                      if (GetSongs.player.hasNext) {
                                        await GetSongs.player.seekToNext();
                                        await GetSongs.player.play();
                                      } else {
                                        await GetSongs.player.play();
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.skip_next,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                    ),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: Colors.transparent,
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: () {
                                          GetSongs.player.loopMode ==
                                                  LoopMode.one
                                              ? GetSongs.player
                                                  .setLoopMode(LoopMode.all)
                                              : GetSongs.player
                                                  .setLoopMode(LoopMode.one);
                                        },
                                        child: StreamBuilder<LoopMode>(
                                          stream:
                                              GetSongs.player.loopModeStream,
                                          builder: (context, snapshot) {
                                            final loopmode = snapshot.data;
                                            if (LoopMode.one == loopmode) {
                                              return const Icon(
                                                Icons.repeat_one,
                                                color: Colors.green,
                                                size: 40,
                                              );
                                            } else {
                                              return const Icon(
                                                Icons.repeat_one,
                                                color: Colors.white,
                                                size: 40,
                                              );
                                            }
                                          },
                                        )),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showSliderDialog({
    required BuildContext context,
    required String title,
    required int divisions,
    required double min,
    required double max,
    String valueSuffix = "",
    required double value,
    required Stream<double> stream,
    required ValueChanged<double> onChanged,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        content: StreamBuilder<double>(
          stream: stream,
          builder: (context, snapshot) => SizedBox(
            height: 100.0,
            child: Column(
              children: [
                Text(
                  "${snapshot.data?.toStringAsFixed(1)}$valueSuffix",
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Fixed",
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                Slider(
                  divisions: divisions,
                  min: min,
                  max: max,
                  value: snapshot.data ?? value,
                  onChanged: onChanged,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _suffleButton(BuildContext context, bool isEnabled) {
    return IconButton(
      icon: isEnabled
          ? const Icon(
              Icons.shuffle,
              color: Colors.green,
              size: 40,
            )
          : const Icon(
              size: 40,
              Icons.shuffle,
              color: Colors.white,
            ),
      onPressed: () async {
        final enable = !isEnabled;
        if (enable) {
          await GetSongs.player.shuffle();
        }
        await GetSongs.player.setShuffleModeEnabled(enable);
      },
    );
  }

  Stream<DurationState> get _durationStateStream =>
      Rx.combineLatest2<Duration, Duration?, DurationState>(
          GetSongs.player.positionStream,
          GetSongs.player.durationStream,
          (postion, duration) => DurationState(
              postion: postion, total: duration ?? Duration.zero));
}

class DurationState {
  DurationState({this.postion = Duration.zero, this.total = Duration.zero});
  Duration postion, total;
}
