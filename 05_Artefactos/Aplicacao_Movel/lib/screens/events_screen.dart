
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/tournament_controller.dart';
import '../controllers/auth_controller.dart';
import 'create_casual_tournament_screen.dart';
import '../widgets/events/tournament_details_modal.dart';
import '../widgets/discover/discover_featured_event_card.dart';
import '../widgets/discover/discover_game_filters.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<dynamic> _allTournaments = [];
  List<dynamic> _filteredTournaments = [];

  bool _isLoading = true;

  String _selectedPrivacyFilter = 'All';

  // MULTI-SELEÇÃO DE JOGOS
  // Set vazio = All (todos os jogos)
  final Set<int> _selectedGameFilterIndexes = {};

  final TextEditingController _searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTournaments();
  }

  // CARREGAR TORNEIOS
  Future<void> _loadTournaments() async {
    setState(() => _isLoading = true);

    final tournaments =
        await TournamentController.getTournamentsList();

    if (!mounted) return;

    _allTournaments = tournaments;

    _filterTournaments();

    setState(() => _isLoading = false);
  }

  // MAPEAR ÍNDICES DOS JOGOS PARA GAME_ID DA BASE DE DADOS
  int? _getGameIdFromFilterIndex(int index) {
    switch (index) {
      case 0:
        return 2; // Pokémon

      case 1:
        return 4; // Yu-Gi-Oh!

      case 2:
        return 1; // Magic

      case 3:
        return 3; // One Piece

      default:
        return null;
    }
  }

  // ALTERNAR SELEÇÃO DE JOGOS
  void _toggleGameFilter(int index) {
    setState(() {
      if (_selectedGameFilterIndexes.contains(index)) {
        _selectedGameFilterIndexes.remove(index);
      } else {
        _selectedGameFilterIndexes.add(index);
      }
    });

    _filterTournaments();
  }

  // FILTRAR TORNEIOS
  void _filterTournaments() {
    final query = _searchController.text.toLowerCase();

    // Converter todos os índices selecionados para game_id
    final Set<int> selectedGameIds = _selectedGameFilterIndexes
        .map(_getGameIdFromFilterIndex)
        .whereType<int>()
        .toSet();

    setState(() {
      _filteredTournaments = _allTournaments.where((t) {

        final bool isPrivate = t['is_private'] == 1;

        // 1. FILTRO DE PRIVACIDADE
        bool matchesCategory = true;

        if (_selectedPrivacyFilter == 'Public') {
          matchesCategory = !isPrivate;
        } else if (_selectedPrivacyFilter == 'Private') {
          matchesCategory = isPrivate;
        }

        // 2. FILTRO DE JOGOS (MULTI-SELEÇÃO)
        final int? tGameId = t['game_id'] is int
            ? t['game_id']
            : int.tryParse(t['game_id']?.toString() ?? '');

        // Se nenhum jogo estiver selecionado, mostra todos.
        // Se houver jogos selecionados, mostra qualquer um deles.
        final bool matchesGame = selectedGameIds.isEmpty ||
            (tGameId != null && selectedGameIds.contains(tGameId));

        // 3. FILTRO DE PESQUISA
        final title =
            (t['title'] ?? '').toString().toLowerCase();

        final organizer =
            (t['organizer_name'] ?? '').toString().toLowerCase();

        final bool matchesSearch =
            title.contains(query) || organizer.contains(query);

        return matchesCategory &&
            matchesGame &&
            matchesSearch;
      }).toList();
    });
  }

  // ABRIR MODAL DE DETALHES
  void _openEventDetailsModal(
    BuildContext context,
    dynamic tournament,
  ) {
    final int? loggedUserId = AuthController.currentUserId;

    if (loggedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Erro: Sessão não encontrada. Por favor, faz login novamente.',
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 500,
            maxHeight: 700,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: TournamentDetailsModal(
            tournament: tournament,
            currentUserId: loggedUserId,
            onChanged: _loadTournaments,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'STORE & CASUAL EVENTS',
          style: TextStyle(
            color: AppColors.accentCyan,
            fontSize: 14,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),

      body: Column(
        children: [

          // PAINEL DE PESQUISA E FILTROS
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // PESQUISA
                TextField(
                  controller: _searchController,
                  onChanged: (value) => _filterTournaments(),
                  style: const TextStyle(color: Colors.white),

                  decoration: InputDecoration(
                    hintText: 'Search by tournament or creator...',
                    hintStyle: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // FILTROS DE PRIVACIDADE
                Row(
                  children: [
                    _buildPrivacyFilterChip('All'),
                    const SizedBox(width: 8),
                    _buildPrivacyFilterChip('Public'),
                    const SizedBox(width: 8),
                    _buildPrivacyFilterChip('Private'),
                  ],
                ),

                const SizedBox(height: 12),

                // FILTROS DE JOGOS COM MULTI-SELEÇÃO
                DiscoverGameFilters(
                  selectedFilterIndexes: _selectedGameFilterIndexes,
                  onFilterSelected: _toggleGameFilter,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // LISTA DE EVENTOS
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryPurple,
                    ),
                  )
                : _filteredTournaments.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'No tournaments found matching your criteria.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),

                        itemCount: _filteredTournaments.length,

                        itemBuilder: (context, index) {
                          final t = _filteredTournaments[index];

                          final bool isPrivate =
                              t['is_private'] == 1;

                          final String gameName =
                              t['game_name'] ?? 'TCG';

                          final String organizerName =
                              t['organizer_name'] ?? 'Unknown Creator';

                          final String location = isPrivate
                              ? '📍 Private Location (Invite Only)'
                              : '📍 ${t['location_name'] ?? 'Location not specified'}';

                          // FORMATAÇÃO DA DATA
                          String dateLabel =
                              isPrivate ? 'PRIVATE' : 'TODAY';

                          if (t['start_time'] != null) {
                            try {
                              final DateTime dt =
                                  DateTime.parse(t['start_time']).toLocal();

                              dateLabel =
                                  '${dt.day.toString().padLeft(2, '0')}/'
                                  '${dt.month.toString().padLeft(2, '0')}'
                                  ' • '
                                  '${dt.hour.toString().padLeft(2, '0')}:'
                                  '${dt.minute.toString().padLeft(2, '0')}';

                              if (isPrivate) {
                                dateLabel = '$dateLabel (PRIVATE)';
                              }
                            } catch (_) {}
                          }

                          final String storeDetails =
                              'By $organizerName\n$location';

                          final String tagText =
                              '${gameName.toUpperCase()} • $dateLabel';

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                            ),

                            child: GestureDetector(
                              onTap: () => _openEventDetailsModal(
                                context,
                                t,
                              ),

                              child: DiscoverFeaturedEventCard(
                                tag: tagText,
                                title: t['title'] ?? 'Tournament',
                                storeDetails: storeDetails,
                                seatsLeft:
                                    '${t['max_slots'] ?? 8} max slots',
                                gameId: t['game_id'],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),

      // BOTÃO CRIAR EVENTO
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await showDialog<bool>(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),

              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 700,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFF121212),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),

                child: const CreateCasualTournamentScreen(),
              ),
            ),
          );

          if (created == true) {
            _loadTournaments();
          }
        },

        backgroundColor: AppColors.primaryPurple,

        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

  // FILTROS DE PRIVACIDADE
  Widget _buildPrivacyFilterChip(String label) {
    final bool isSelected = _selectedPrivacyFilter == label;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPrivacyFilter = label;
          });

          _filterTournaments();
        },

        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),

          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryPurple
                : const Color(0xFF1E1E1E),

            borderRadius: BorderRadius.circular(10),

            border: Border.all(
              color: isSelected
                  ? AppColors.primaryPurple
                  : Colors.white10,
            ),
          ),

          alignment: Alignment.center,

          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : AppColors.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
