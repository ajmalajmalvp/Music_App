import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../BottomNavigation/main_bottom.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 300,
      splash: SizedBox(
        child: Image.asset(
          "assets/mainimager.png",
        ),
      ),
      nextScreen: const MainHomeBottomWidget(),
      splashTransition: SplashTransition.slideTransition,
      backgroundColor: Colors.black,
      duration: 2000,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
