import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:flutter_project_week8/properites/Favorite/favorite.dart';
import 'package:flutter_project_week8/properites/MIniPlayer/mini_player.dart';
import 'package:flutter_project_week8/properites/Search/search_page.dart';
import 'package:flutter_project_week8/properites/Songs/songs_page.dart';
import 'package:flutter_project_week8/properites/PlayList/play_list.dart';

ValueNotifier<int> bottomValueNotifier = ValueNotifier(0);

final pages = [
  ScreenSongsPageWidget(),
  SearchPage(),
  const FavoriteScreen(),
  PlayListWidget(),
];

class MainHomeBottomWidget extends StatelessWidget {
  const MainHomeBottomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bottomValueNotifier,
      builder: (context, value, _) {
        return Scaffold(
          body: pages[value],
          bottomNavigationBar: SingleChildScrollView(
            child: Column(
              children: [
                if (GetSongs.player.currentIndex != null)
                  Column(
                    children: [
                      const MiniPlayer(),
                      Container(
                        height: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                BottomNavigationBar(
                  elevation: 0,
                  currentIndex: value,
                  backgroundColor: Colors.black,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.green,
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.blue,
                  ),
                  selectedIconTheme: const IconThemeData(color: Colors.red),
                  type: BottomNavigationBarType.fixed,
                  onTap: (onTapValue) {
                   bottomValueNotifier.value = onTapValue;
                    bottomValueNotifier.value = onTapValue;
                  },
                  items:const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.music_video,
                        ),
                        label: "songs"),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                      ),
                      label: "search",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.favorite,
                        ),
                        label: "favorite"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.playlist_play,
                        ),
                        label: "playlist"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
