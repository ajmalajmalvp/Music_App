import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeProvider extends ChangeNotifier {
  void requistePermmission() async {
    await Permission.storage.request();
    notifyListeners();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
