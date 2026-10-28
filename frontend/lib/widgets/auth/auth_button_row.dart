import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [AuthButtonRow]
/// Linha modular de botões de ação para os ecrãs de autenticação (ex: Entrar e Registar).
/// Permite alternar dinamicamente a ordem do botão primário e secundário através da propriedade [primaryFirst].
class AuthButtonRow extends StatelessWidget {
  /// Texto apresentado no botão principal (destacado)
  final String primaryLabel;
  
  /// Ação executada ao pressionar o botão principal
  final VoidCallback onPrimaryTap;
  
  /// Texto apresentado no botão secundário (contornado)
  final String secondaryLabel;
  
  /// Ação executada ao pressionar o botão secundário
  final VoidCallback onSecondaryTap;
  
  /// Define se o botão principal aparece primeiro (à esquerda) ou em segundo (à direita)
  final bool primaryFirst;

  const AuthButtonRow({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryTap,
    required this.secondaryLabel,
    required this.onSecondaryTap,
    this.primaryFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    // Criação do botão primário com fundo roxo preenchido
    final primaryBtn = ElevatedButton(
      onPressed: onPrimaryTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 46),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(
        primaryLabel,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );

    // Criação do botão secundário com estilo de contorno (OutlinedButton)
    final secondaryBtn = OutlinedButton(
      onPressed: onSecondaryTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 46),
        side: const BorderSide(color: AppColors.cardBorder),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Text(secondaryLabel),
    );

    // [O que acontece aqui]: Retorna uma linha que organiza os botões com base na flag [primaryFirst]
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: primaryFirst
          ? [primaryBtn, const SizedBox(width: 12), secondaryBtn]
          : [secondaryBtn, const SizedBox(width: 12), primaryBtn],
    );
  }
}