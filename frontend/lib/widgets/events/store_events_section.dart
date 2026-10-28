import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../shared_widgets.dart';

/// [StoreEventsSection]
/// Widget modular responsável por agrupar e exibir todos os eventos comerciais 
/// planeados pelas lojas locais parceiras da plataforma.
class StoreEventsSection extends StatelessWidget {
  const StoreEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de identificação da secção com estilo visual em destaque (maiúsculas e cor ciano)
        Text(
          'STORE EVENT CARDS',
          style: TextStyle(
            color: AppColors.accentCyan,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 12),
        
        // Cartaz detalhado do primeiro evento de loja (Magic: The Gathering - Friday Night Commander)
        DetailedStoreEventCard(
          gameName: 'Magic',
          gameIcon: Icons.local_fire_department_outlined,
          gameColor: AppColors.magicOrange,
          title: 'Friday Night Commander',
          storeLocation: 'Twenty Sided Store · Brooklyn',
          dateTime: 'Oct 9 · 7:00 PM',
          spotsInfo: 'Casual pods · 6 left',
          imageUrl:
              'https://images.unsplash.com/photo-1611996575749-79a3a250f948?auto=format&fit=crop&w=400&q=80',
        ),
        SizedBox(height: 14),
        
        // Cartaz detalhado do segundo evento de loja (Pokémon TCG - League Challenge)
        DetailedStoreEventCard(
          gameName: 'Pokémon',
          gameIcon: Icons.catching_pokemon,
          gameColor: AppColors.pokemonGold,
          title: 'Pokémon League Challenge',
          storeLocation: 'Next Level Games · Queens',
          dateTime: 'Oct 11 · 12:30 PM',
          spotsInfo: 'Standard · 12 spots',
          imageUrl:
              'https://images.unsplash.com/photo-1606167668584-78701c57f13d?auto=format&fit=crop&w=400&q=80',
        ),
      ],
    );
  }
}