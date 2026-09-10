import 'package:flutter/material.dart';

import 'theme/azalea_colors.dart';
import 'Screens/onboarding_screen.dart';

void main() {
  runApp(const AzaleaApp());
}

// ============================================================
// AZALEA APP
// ============================================================

class AzaleaApp extends StatelessWidget {
  const AzaleaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AZALEA',
      theme: ThemeData(
        scaffoldBackgroundColor: warmIvory,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: azaleaPink,
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}