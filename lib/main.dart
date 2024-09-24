import 'package:flutter/material.dart';
import 'package:music_player/core/configs/theme/app_theme.dart';
import 'package:music_player/presentation/splash/pages/splash.dart';

void main() {
  runApp(const MusicPlayer());
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashPage(),
    );
  }
}

