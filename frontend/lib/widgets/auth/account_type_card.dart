import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// [AccountTypeCard]
/// Componente modular opcional que encapsula o cartão visual de opção de tipo de conta,
/// permitindo reutilizar o layout com ícone, título, descrição e indicador de seleção.
class AccountTypeCard extends StatelessWidget {
  /// Título principal do cartão (ex: 'Player Profile')
  final String title;
  
  /// Subtítulo explicativo detalhado sobre o perfil
  final String subtitle;
  
  /// Ícone representativo do tipo de conta
  final IconData icon;
  
  /// Ação executada ao tocar no cartão
  final VoidCallback onTap;
  
  /// Define se o cartão se encontra atualmente selecionado (destaca a borda em ciano)
  final bool isSelected;

  const AccountTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    // [O que acontece aqui]: Cria um InkWell envolto num Container com borda dinâmica baseada na seleção.
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? AppColors.accentCyan : AppColors.cardBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Contentor decorativo para o ícone do perfil
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.accentCyan : AppColors.primaryPurple,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Bloco de texto contendo o título e a descrição explicativa
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            // Ícone indicador de navegação à direita
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.textMuted,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}