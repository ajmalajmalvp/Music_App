
import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/MiniProvider/mini_provider.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/db/widgets/text_aling.dart';
import 'package:flutter_project_week8/properites/PlayingPage/music_play_page.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
 
    final provider = Provider.of<MiniProvider>(context, listen: false);
    return Consumer<MiniProvider>(
      builder: (context, value, child) {
        return AnimatedContainer(
          color: Colors.black,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          width: double.infinity,
          height: 70,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return NowPlayMusic(playersongs: GetSongs.playingSongs ,);
                  },
                ),
              );
            },
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: QueryArtworkWidget(
                    artworkQuality: FilterQuality.high,
                    artworkFit: BoxFit.fill,
                    artworkBorder: BorderRadius.circular(30),
                    nullArtworkWidget: Lottie.asset("assets/songs.json"),
                    id: GetSongs.playingSongs[GetSongs.player.currentIndex!].id,
                    type: ArtworkType.AUDIO),
              ),
            ),
            title: AnimatedText(
            text: GetSongs
                .playingSongs[GetSongs.player.currentIndex!].displayNameWOExt,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
            subtitle: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                "${GetSongs.playingSongs[GetSongs.player.currentIndex!].artist}",
                style: const TextStyle(
                    fontSize: 11, overflow: TextOverflow.ellipsis),
              ),
            ),
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Row(
                children: [
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
                      size: 35,
                    ),
                  ),
                  ElevatedButton(
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
                      builder: (context, snpashot) {
                        bool? playingStage = snpashot.data;
                        if (playingStage != null && playingStage) {
                          return const Icon(
                            Icons.pause_circle_outline,
                            size: 35,
                          );
                        } else {
                          return const Icon(
                            Icons.play_circle_outline,
                            size: 35,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
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
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
