import 'package:flutter/material.dart';
import '../widgets/events/store_events_section.dart';
import '../widgets/events/players_section.dart';

/// [EventsScreen]
/// Ecrã principal responsável por organizar e apresentar a interface de eventos.
/// Segue o princípio da responsabilidade única: serve apenas como esqueleto estrutural,
/// delegando os blocos visuais para widgets modulares dedicados.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // Adiciona margem simétrica interna para garantir um respiro visual nas margens do telemóvel
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Secção modular contendo os cartazes de torneios promovidos pelas lojas TCG
          StoreEventsSection(),
          SizedBox(height: 28),
          
          // 2. Secção modular contendo os cartazes dos perfis de jogadores próximos para partidas casuais
          PlayersSection(),
        ],
      ),
    );
  }
}