import 'package:flutter/material.dart';
import 'package:flutter_project_week8/db/provider/FavoriteProvider/favorite_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.song});
  final SongModel song;
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        return IconButton(
          onPressed: () {
            if (value.isfavor(song)) {
              value.delete(song.id);
              Provider.of<FavoriteProvider>(context, listen: false)
                  .notifyListeners();
              const snackBar = SnackBar(
                content: Text(
                  "Removed From Favorite",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: Duration(
                  microseconds: 1500,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              value.add(song);
              Provider.of<FavoriteProvider>(context, listen: false)
                  .notifyListeners();
              const snackBar = SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  "Added To Favorite",
                ),
                duration: Duration(milliseconds: 350),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
            Provider.of<FavoriteProvider>(context, listen: false)
                .notifyListeners();
          },
          icon: value.isfavor(song)
              ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                ),
        );
      },
    );
  }
}
