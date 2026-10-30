import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [AuthLogo]
/// Componente modular responsável por exibir o logótipo da aplicação nos ecrãs de autenticação.
/// Inclui suporte a imagem local (`Image.asset`) e um mecanismo de fallback elegante (`errorBuilder`)
/// que exibe um contentor com ícone caso a imagem não seja encontrada.
class AuthLogo extends StatelessWidget {
  /// Ícone alternativo a ser exibido caso ocorra um erro ao carregar a imagem do logótipo
  final IconData fallbackIcon;

  const AuthLogo({
    super.key,
    this.fallbackIcon = Icons.style_rounded,
  });

  @override
  Widget build(BuildContext context) {
    // [O que acontece aqui]: Recorta a imagem com cantos arredondados e tenta carregar o asset local.
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        'images/logo2.png',
        cacheWidth: 750,
        fit: BoxFit.cover,
        // [Função errorBuilder]: Executada automaticamente se o Flutter não encontrar a imagem 'images/logo.png'
        errorBuilder: (_, __, ___) => Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Icon(
            fallbackIcon,
            size: 48,
            color: AppColors.primaryPurple,
          ),
        ),
      ),
    );
  }
}