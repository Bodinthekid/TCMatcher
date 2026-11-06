import 'package:flutter/material.dart';
import '../widgets/events/store_events_section.dart';

/// [EventsScreen]
/// Ecrã principal responsável por organizar e apresentar exclusivamente a interface de eventos de lojas.
class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Apenas os cartazes de torneios e eventos promovidos pelas lojas TCG
          StoreEventsSection(),
        ],
      ),
    );
  }
}