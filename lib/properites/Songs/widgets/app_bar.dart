import 'package:flutter/material.dart';

class SongsAppBar extends StatelessWidget {
  const SongsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: RichText(
        text: TextSpan(
          text: "m y m u s i",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.grey[350],
          ),
          children: const <TextSpan>[
            TextSpan(
              text: " c s",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                color: Colors.green,
              ),
            )
          ],
        ),
      ),
      actions: [
        Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.settings_outlined),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        )
      ],
    );
  }
}
