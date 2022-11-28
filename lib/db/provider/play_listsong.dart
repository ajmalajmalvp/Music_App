import 'package:flutter/material.dart';
import 'package:flutter_project_week8/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Models/play_list_model.dart';

class PlayListDb extends ChangeNotifier {
  List<PlayListerModel> playListNotifier = [];

  Future<void> playListAdd(PlayListerModel value) async {
    final playListDb = Hive.box<PlayListerModel>(PLAYLIST_DB_NAME);
    await playListDb.add(value);
    getAllPlayList();
    notifyListeners();
  }

  Future<void> getAllPlayList() async {
    final playListDb = Hive.box<PlayListerModel>(PLAYLIST_DB_NAME);
    playListNotifier.clear();
    playListNotifier.addAll(playListDb.values);
    notifyListeners();
  }

  Future<void> playlistDelete(int index) async {
    final playlistDb = Hive.box<PlayListerModel>(PLAYLIST_DB_NAME);
    await playlistDb.deleteAt(index);
    getAllPlayList();
    notifyListeners();
  }

  Future<void> appReset(context) async {
    final playListDb = Hive.box<PlayListerModel>(PLAYLIST_DB_NAME);
    final favoriteDb = Hive.box<int>(FAVORITE_DB_NAME);
    await playListDb.clear();
    await favoriteDb.clear();
    
    notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const MaterialAppWidget(),
      ),
      (route) => false,
    );
  }
 

}
