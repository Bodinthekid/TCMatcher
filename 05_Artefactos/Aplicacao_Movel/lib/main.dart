import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme/app_colors.dart';
import 'screens/login_screen.dart';

// INICIALIZAÃ‡ÃƒO DA APLICAÃ‡ÃƒO
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variÃ¡veis de ambiente
  await dotenv.load(fileName: ".env", isOptional: true);

  // Inicia a aplicaÃ§Ã£o
  runApp(const TcgCompanionApp());
}

// APLICAÃ‡ÃƒO PRINCIPAL
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