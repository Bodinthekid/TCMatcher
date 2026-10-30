// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme/app_colors.dart';
import 'screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const TcgCompanionApp());
}

class TcgCompanionApp extends StatelessWidget {
  const TcgCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TCG Matchmaking & Discovery',
      debugShowCheckedModeBanner: false,
      theme: AppColors.darkTheme,
      home: const LoginScreen(),
    );
  }
}