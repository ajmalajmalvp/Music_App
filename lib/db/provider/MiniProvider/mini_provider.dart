import 'package:flutter/cupertino.dart';
import 'package:flutter_project_week8/db/provider/widgets/get_songs.dart';

class  MiniProvider extends ChangeNotifier {
  void moundedfun() async {
    GetSongs.player.currentIndexStream.listen((index) {
      if (index != null) {
        notifyListeners();
      }
    });
  }
}
