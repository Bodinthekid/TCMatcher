import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// [MatchmakingStatusBanner]
/// Constrói o cartão com fundo em gradiente responsável por demonstrar 
/// o estado atual e o jogo configurado para a sessão.
class MatchmakingStatusBanner extends StatelessWidget {
  const MatchmakingStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // [O que está a acontecer]: Estamos a criar um contentor decorado com um gradiente 
    // vertical de tons roxos escuros para dar destaque visual ao estado do utilizador.
    return Container(
      padding: const EdgeInsets.all(16), // Margem interna de 16 pixéis em redor do conteúdo
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF231D49), // Tom de roxo mais claro no canto superior esquerdo
            Color(0xFF191630), // Tom de roxo mais escuro no canto inferior direito
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18), // Cantos arredondados modernos
        border: Border.all(
          color: AppColors.primaryPurple.withValues(alpha: 0.6), // Contorno subtil em roxo
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          // Linha superior do banner: Mostra o badge de disponibilidade e os jogadores próximos
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Badge que indica visualmente que o utilizador está pronto para jogar
              const StatusBadge(
                label: 'Available to Play',
                dotColor: AppColors.statusAvailable,
                backgroundColor: Color(0xFF2E2759),
              ),
              // Contador em tempo real de jogadores disponíveis na vizinhança
              Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: AppColors.accentCyan, // Ponto indicador ciano brilhante
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    '12 nearby',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Linha inferior do banner: Detalhes do jogo de cartas selecionado (ex: Magic: The Gathering)
          Row(
            children: [
              // Caixa com o ícone representativo do TCG com fundo personalizado
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF332024), // Fundo escuro com tom avermelhado/laranja
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.magicOrange.withValues(alpha: 0.5),
                  ),
                ),
                child: const Icon(
                  Icons.local_fire_department_outlined,
                  color: AppColors.magicOrange,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              // Informação de texto com o nome do jogo e formato escolhido (Commander)
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Magic: The Gathering',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Commander · Casual',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // Ícone de edição para permitir ao utilizador alterar o jogo ou formato
              const Icon(
                Icons.edit_outlined,
                color: AppColors.accentCyan,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}