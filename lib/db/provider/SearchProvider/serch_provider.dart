import 'package:flutter/cupertino.dart';
import 'package:flutter_project_week8/properites/Songs/songs_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchProvider extends ChangeNotifier {
  List<SongModel> temp = [];
  searchFilter(value) {
    if (value != null && value.isNotEmpty) {
      temp.clear();
      for (SongModel item in ScreenSongsPageWidget.song) {
        if (item.title.toLowerCase().contains(value.toLowerCase())) {
          temp.add(item);
        }
      }
    }
    notifyListeners();
  }
}
