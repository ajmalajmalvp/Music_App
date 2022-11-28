import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/play_listsong.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/main.dart';
import 'package:flutter_project_week8/properites/Favorite/widgets/favorite_button.dart';
import 'package:flutter_project_week8/properites/PlayingPage/music_play_page.dart';
import 'package:flutter_project_week8/properites/PlayList/palaylist_floatiing-actionbutton.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../../Models/play_list_model.dart';


class PlayListDetailsWidget extends StatelessWidget {
  const PlayListDetailsWidget({
    super.key,
    required this.playList,
    required this.folderIndex,
  });

  final PlayListerModel playList;
  final int folderIndex;

  @override
  Widget build(BuildContext context) {
    late List<SongModel> playListSong;
    final provider = Provider.of<PlayListDb>(context);
    return Consumer<PlayListDb>(builder: (context, newValue, child) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/music.json",
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    playList.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return FloatingActionButtonPlayListWidget(
                                playlist: playList);
                          },
                        ),
                      );
                    },
                    child: const Text("Add songs"),
                  ),
                  ValueListenableBuilder(
                      valueListenable:
                          Hive.box<PlayListerModel>(PLAYLIST_DB_NAME)
                              .listenable(),
                      builder: (context, value, _) {
                        playListSong = listPlayList(
                            value.values.toList()[folderIndex].songIds);
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                List<SongModel> newList = [...playListSong];
                                GetSongs.player.stop();
                                GetSongs.player.setAudioSource(
                                  GetSongs.creatingSongsList(
                                    newList,
                                  ),
                                  initialIndex: index,
                                );
                                GetSongs.player.play();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NowPlayMusic(
                                      playersongs: playListSong,
                                    ),
                                  ),
                                );
                              },
                              leading: QueryArtworkWidget(
                                id: playListSong[index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: const Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                                errorBuilder: (context, exception, gdb) {
                                  provider;
                                  return Image.asset("");
                                },
                              ),
                              title: Text(
                                playListSong[index].title,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              subtitle: Text(
                                playListSong[index].artist!,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.topCenter,
                                              colors: [
                                                Color.fromARGB(255, 210, 144, 139),
                                                Color.fromARGB(255, 144, 212, 146),
                                              ],
                                              stops: [0.5, 1],
                                            ),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                25.0,
                                              ),
                                              topRight: Radius.circular(
                                                25.0,
                                              ),
                                            ),
                                          ),
                                          child: SizedBox(
                                            height: 350,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.transparent,
                                                  ),
                                                  child: QueryArtworkWidget(
                                                    artworkBorder:
                                                        BorderRadius.circular(
                                                            1),
                                                    artworkWidth: 100,
                                                    artworkHeight: 400,
                                                    nullArtworkWidget:
                                                        const Icon(
                                                      Icons.music_note,
                                                      size: 100,
                                                    ),
                                                    id: playListSong[index].id,
                                                    type: ArtworkType.AUDIO,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    playListSong[index].title,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    18.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ElevatedButton.icon(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white),
                                                        onPressed: () {
                                                          playList.deletData(
                                                              playListSong[
                                                                      index]
                                                                  .id);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .delete_outline_outlined,
                                                          size: 25,
                                                        ),
                                                        label: const Text(
                                                          "Remove Song",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          FavoriteButton(
                                                            song: playListSong[
                                                                index],
                                                          ),
                                                          const Text(
                                                            "Add To Favorite",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.more_vert_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: playListSong.length,
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FloatingActionButtonPlayListWidget(playlist: playList);
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }

  List<SongModel> listPlayList(List<int> data) {
    List<SongModel> plasong = [];
    for (int i = 0; i < GetSongs.songsCopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (GetSongs.songsCopy[i].id == data[j]) {
          plasong.add(GetSongs.songsCopy[i]);
        }
      }
    }
    return plasong;
  }
}
