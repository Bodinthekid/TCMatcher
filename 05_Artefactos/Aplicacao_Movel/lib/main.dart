import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'theme/app_colors.dart';
import 'screens/login_screen.dart';

// INICIALIZAÇÃO DA APLICAÇÃO
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variáveis de ambiente
  await dotenv.load(fileName: ".env");

  // Inicia a aplicação
  runApp(const TcgCompanionApp());
}

// APLICAÇÃO PRINCIPAL
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