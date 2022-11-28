import 'package:flutter/cupertino.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlayPro extends ChangeNotifier {
  int currentIndex = 0;
  bool _isSuffle = false;
  moutedFun() {
    GetSongs.player.currentIndexStream.listen(
      (index) {
        if (index != null) {
          notifyListeners();
          currentIndex = index;
          GetSongs.currentIndex = index;
        }
        notifyListeners();
      },
    );
   
  }


 
}
