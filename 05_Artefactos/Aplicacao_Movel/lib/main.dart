import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:scaled_app/scaled_app.dart';
import 'screens/login_screen.dart';
import 'theme/app_colors.dart';
import 'utils/app_scale_config.dart';

Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: AppScaleConfig.scaleFactor,
  );

  await dotenv.load(fileName: '.env', isOptional: true);

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
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).scale().copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const LoginScreen(),
    );
  }
}