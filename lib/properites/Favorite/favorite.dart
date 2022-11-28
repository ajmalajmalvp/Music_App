import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/properites/PlayingPage/music_play_page.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../db/provider/FavoriteProvider/favorite_provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    final provider = Provider.of<FavoriteProvider>(context);

    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(0),
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Text(
                "F a v o r i t e s",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: value.favoriteSongs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            "assets/love.json",
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Add to favorites",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        Consumer<FavoriteProvider>(
                          builder: (context, value, child) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () async {
                                    List<SongModel> newList = [
                                      ...value.favoriteSongs
                                    ];
                                    provider.notifyListeners();
                                    GetSongs.player.setAudioSource(
                                      GetSongs.creatingSongsList(newList),
                                      initialIndex: index,
                                    );
                                    GetSongs.player.play();
                                    Provider.of<FavoriteProvider>(context,
                                            listen: false)
                                        .notifyListeners();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NowPlayMusic(
                                            playersongs: newList,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  leading: QueryArtworkWidget(
                                    id: value.favoriteSongs[index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                  ),
                                  title: Text(
                                    value.favoriteSongs[index].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Text(
                                    value.favoriteSongs[index].album!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      provider;
                                      value.delete(
                                          value.favoriteSongs[index].id);

                                      const snackBar = SnackBar(
                                        backgroundColor: Colors.black,
                                        content: Text(
                                          "Song deleted from favorite",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        duration: Duration(microseconds: 190),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    icon: const Icon(
                                      Icons.heart_broken_sharp,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              itemCount: value.favoriteSongs.length,
                            );
                          },
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
