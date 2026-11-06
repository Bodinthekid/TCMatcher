import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [AccountTypeButton]
/// Widget modular responsável por criar os botões de seleção do tipo de conta 
/// (seja Jogador ou Loja) no ecrã de registo, adaptando o estilo visual 
/// conforme a propriedade [isPrimary].

class AccountTypeButton extends StatelessWidget {
  /// Texto exibido no interior do botão (ex: 'Player' ou 'Store')
  final String label;
  
  /// Função executada quando o utilizador pressiona o botão
  final VoidCallback onPressed;
  
  /// Define se o botão é primário (fundo roxo preenchido) ou secundário (apenas contorno)
  final bool isPrimary;

  const AccountTypeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true, // Por predefinição, assume o estilo primário
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Largura fixa estipulada para manter a consistência visual centralizada
      height: 48, // Altura ergonómica ideal para toque no telemóvel
      child: isPrimary
          ? ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple, // Cor principal roxa do tema
                foregroundColor: Colors.white,            // Cor do texto em branco
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14), // Cantos arredondados padronizados
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primaryPurpleDark, // Cor principal roxa do tema
                foregroundColor: Colors.white,
                side: const BorderSide(color: AppColors.cardBorder), // Contorno cinzento subtil
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
    );
  }
}