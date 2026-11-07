import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/auth/auth_logo.dart';
import '../widgets/auth/account_type_button.dart';
import 'register_player_screen.dart';
import 'register_store_screen.dart';

/// [AccountTypeScreen]
/// Ecrã estrutural responsável por apresentar a escolha do tipo de conta.
/// Segue a arquitetura modular, delegando a identidade visual para o [AuthLogo] 
/// e os botões de ação para o [AccountTypeButton].
class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key}); // Construtor constante para otimização de performance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior limpa com o título de registo centralizado
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          // Adiciona margem interna lateral e vertical para garantir margens seguras no ecrã
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Logótipo modular da autenticação com ícone de fallback personalizado para pessoas/perfis
              const AuthLogo(fallbackIcon: Icons.people_alt_rounded),
              const SizedBox(height: 60), // Espaçamento generoso antes das opções de escolha

              // 2. Botão modular primário para o fluxo de registo de Jogador (Player)
              AccountTypeButton(
                label: 'Player',
                isPrimary: true,
                onPressed: () {
                  // Navega para o ecrã dedicado ao registo de jogadores
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPlayerScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12), // Espaçamento vertical entre os dois botões

              // 3. Botão modular secundário para o fluxo de registo de Loja (Store)
              AccountTypeButton(
                label: 'Store',
                isPrimary: false,
                onPressed: () {
                  // Navega para o ecrã dedicado ao registo de lojas TCG
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterStoreScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}