// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizzy/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: Lottie.asset("Assets/lottie/Animation - 1714314651997.json"),
          )
        ],
      ),
      nextScreen: HomeScreen(),
      splashIconSize: 300.0,
      backgroundColor: Colors.white,
      duration: 1000,
    );
  }
}
