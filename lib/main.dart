import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/BottomProvider/bottom_provider.dart';
import 'package:flutter_project_week8/db/provider/FavoriteProvider/favorite_provider.dart';
import 'package:flutter_project_week8/db/provider/HomeProvider/home_provider.dart';
import 'package:flutter_project_week8/db/provider/MiniProvider/mini_provider.dart';
import 'package:flutter_project_week8/db/provider/NowPlayPro/now_play.dart';
import 'package:flutter_project_week8/db/provider/SearchProvider/serch_provider.dart';
import 'package:flutter_project_week8/db/provider/play_listsong.dart';
import 'package:flutter_project_week8/properites/SplashScreen/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'Models/play_list_model.dart';

const PLAYLIST_DB_NAME = "play-database";
const FAVORITE_DB_NAME = "favorite-db";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PlayListerModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListerModelAdapter());
  }

  await Hive.openBox<PlayListerModel>(PLAYLIST_DB_NAME);
  await Hive.openBox<int>(FAVORITE_DB_NAME);

  await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
      preloadArtwork: true);

  runApp(const MaterialAppWidget());
}

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => NowPlayPro()),
        ChangeNotifierProvider(create: (context) => PlayListDb()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => MiniProvider()),
        ChangeNotifierProvider(create: (context) => BottomProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Music App",
        home: SplashScreen(),
      ),
    );
  }
}
