import 'package:flutter/cupertino.dart';
import 'package:flutter_project_week8/main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:flutter/widgets.dart';

class FavoriteProvider extends ChangeNotifier {
   
  List<SongModel> favoriteSongs = [];
  bool isInitialized = false;
  final musicDb = Hive.box<int>(FAVORITE_DB_NAME);

  initialise(List<SongModel> songs) {
    for (SongModel song in songs) {
      if (isfavor(song)) {
        favoriteSongs.add(song);
      }
    }
    isInitialized = true;

    // notifyListeners();
  }

  bool isfavor(SongModel song) {
    // notifyListeners();
    if (musicDb.values.contains(song.id)) {
      return true;
    }

    return false;
  }

  add(SongModel song) async {
    favoriteSongs.add(song);

    musicDb.add(song.id);
    notifyListeners();
  }

  delete(int id) async {
    notifyListeners();
    int deletekey = 0;
    if (!musicDb.values.contains(id)) {
      return;
    }
    final Map<dynamic, int> favorMap = musicDb.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    musicDb.delete(deletekey);
    favoriteSongs.removeWhere((song) => song.id == id);
    notifyListeners();
  }
}
