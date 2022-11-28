import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

Widget sharethisApp(BuildContext context) {
  return Scaffold(
    body: FutureBuilder(
        future: Future.delayed(const Duration(milliseconds: 30), () {
          return Share.share("https://play.google.com/store/apps/details?id=com.google.earth");
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        }),
  );
}
