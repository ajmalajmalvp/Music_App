import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/FavoriteProvider/favorite_provider.dart';
import 'package:flutter_project_week8/db/provider/HomeProvider/home_provider.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/db/widgets/glass_Morphisom.dart';
import 'package:flutter_project_week8/properites/Favorite/widgets/favorite_button.dart';
import 'package:flutter_project_week8/properites/PlayingPage/music_play_page.dart';
import 'package:flutter_project_week8/properites/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class ScreenSongsPageWidget extends StatelessWidget {
  ScreenSongsPageWidget({super.key});

  static List<SongModel> song = [];
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).requistePermmission();
    });
    FocusManager.instance.primaryFocus?.unfocus();
    return Scaffold(
      backgroundColor: Colors.black
      ,
      endDrawer: const ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
          bottom: Radius.circular(
            30.0,
          ),
        ),
      ),
      // appBar: const PreferredSize(
      //   child: SongsAppBar(),
      //   preferredSize: Size(double.maxFinite, 60),
      // ),
      body: Consumer<HomeProvider>(
        builder: (context, value, child) => FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, item) {
            if (item.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return const Center(
                child: Text("Sorry No Songs Found"),
              );
            }
            ScreenSongsPageWidget.song = item.data!;
            if (!Provider.of<FavoriteProvider>(context, listen: false)
                .isInitialized) {
              Provider.of<FavoriteProvider>(context, listen: false)
                  .initialise(item.data!);
            }
            GetSongs.songsCopy = item.data!;
            return SafeArea(
              child: Column(
                children: [
                  Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'M y M u s i c s',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.grey[350]),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 36,
                                        color: Colors.green)),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return const
                               ScreenSetting();
                            }));
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) {
                            return GlassMorphos(
                                child: GestureDetector(
                                  onTap: () {
                                    GetSongs.player.setAudioSource(
                                      GetSongs.creatingSongsList(
                                        item.data!,
                                      ),
                                      initialIndex: index,
                                    );
                                    GetSongs.player.play();
                                    Provider.of<HomeProvider>(context,
                                            listen: false)
                                        .notifyListeners();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NowPlayMusic(
                                            playersongs: item.data!,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: GlassMorphos(
                                    start: 0.0,
                                    end: 0.0,
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: QueryArtworkWidget(
                                              id: item.data![index].id,
                                              type: ArtworkType.AUDIO,
                                              nullArtworkWidget: const Icon(
                                                Icons.music_note_outlined,
                                                size: 50,
                                                color: Colors.white,
                                              ),
                                              artworkFit: BoxFit.fill,
                                              artworkBorder:
                                                  const BorderRadius.all(
                                                Radius.circular(
                                                  5,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          item.data![index]
                                                              .displayNameWOExt,
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.white70,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          "${item.data![index].album}",
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: FavoriteButton(
                                                    song: ScreenSongsPageWidget
                                                        .song[index],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                start: 0.1,
                                end: 0.5);
                          }),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
