import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/SearchProvider/serch_provider.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/properites/PlayingPage/music_play_page.dart';
import 'package:flutter_project_week8/properites/Songs/songs_page.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});
  String values = "";
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 90,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            autocorrect: true,
            decoration: const InputDecoration(
              prefixIconColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 3,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              filled: true,
              fillColor: Colors.transparent,
              hintText: "Search ",
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            onChanged: (String? value) {
              provider.searchFilter(value);
              values = value!;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(children: [
            Consumer<SearchProvider>(
              builder: (context, value, child) {
                return values.isEmpty
                    ? Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Lottie.asset("assets/search.json"),
                    )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          final data = value.temp[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                  nullArtworkWidget: const Icon(
                                    Icons.music_note_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ),
                                  artworkFit: BoxFit.cover,
                                  id: data.id,
                                  type: ArtworkType.AUDIO),
                              title: Text(
                                data.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                final searchIndex = createSearchIndex(data);
                                FocusScope.of(context).unfocus();
                                GetSongs.player.setAudioSource(
                                  GetSongs.creatingSongsList(
                                    ScreenSongsPageWidget.song,
                                  ),
                                  initialIndex: searchIndex,
                                );
                                GetSongs.player.play();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NowPlayMusic(
                                      playersongs: ScreenSongsPageWidget.song);
                                }));
                              },
                            ),
                          );
                        },
                        separatorBuilder: (context, child) {
                          return const Divider();
                        },
                        itemCount: provider.temp.length);
              },
            )
          ]),
        ),
      ),
    );
  }

  int? createSearchIndex(SongModel data) {
    for (int i = 0; i < ScreenSongsPageWidget.song.length; i++) {
      if (data.id == ScreenSongsPageWidget.song[i].id) {
        return i;
      }
    }
    return null;
  }
}
