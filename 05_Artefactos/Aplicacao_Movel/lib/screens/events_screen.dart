import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/tournament_controller.dart';
import '../controllers/auth_controller.dart';
import 'create_casual_tournament_screen.dart';
import '../widgets/events/tournament_details_modal.dart'; // ðŸ‘ˆ Import correto na pasta widgets/events/
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
  String _selectedPrivacyFilter = 'All'; // 'All', 'Public', 'Private'
  int _selectedGameFilterIndex = 4; // 4 = All (por omissÃ£o)
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTournaments();
  }

  Future<void> _loadTournaments() async {
    setState(() => _isLoading = true);
    final tournaments = await TournamentController.getTournamentsList();
    if (!mounted) return;
    _allTournaments = tournaments;
    _filterTournaments();
    setState(() => _isLoading = false);
  }

  // Mapeia o Ã­ndice do DiscoverGameFilters para o game_id correspondente na base de dados
  int? _getGameIdFromFilterIndex(int index) {
    switch (index) {
      case 0:
        return 2; // PokÃ©mon
      case 1:
        return 4; // Yu-Gi-Oh!
      case 2:
        return 1; // Magic
      case 3:
        return 3; // One Piece
      case 4:
      default:
        return null; // All
    }
  }

  void _filterTournaments() {
    final query = _searchController.text.toLowerCase();
    final int? targetGameId = _getGameIdFromFilterIndex(_selectedGameFilterIndex);

    setState(() {
      _filteredTournaments = _allTournaments.where((t) {
        final bool isPrivate = t['is_private'] == 1;

        // 1. Filtro por privacidade (All, Public, Private)
        bool matchesCategory = true;
        if (_selectedPrivacyFilter == 'Public') {
          matchesCategory = !isPrivate;
        } else if (_selectedPrivacyFilter == 'Private') {
          matchesCategory = isPrivate;
        }

        // 2. Filtro por Jogo com base no DiscoverGameFilters
        bool matchesGame = true;
        if (targetGameId != null) {
          final int? tGameId = t['game_id'] is int
              ? t['game_id']
              : int.tryParse(t['game_id']?.toString() ?? '');
          matchesGame = tGameId == targetGameId;
        }

        // 3. Filtro por texto (TÃ­tulo ou Nome do Criador)
        final title = (t['title'] ?? '').toString().toLowerCase();
        final organizer = (t['organizer_name'] ?? '').toString().toLowerCase();
        bool matchesSearch = title.contains(query) || organizer.contains(query);

        return matchesCategory && matchesGame && matchesSearch;
      }).toList();
    });
  }

  void _openEventDetailsModal(BuildContext context, dynamic tournament) {

    final int? loggedUserId = AuthController.currentUserId;

    // Se por acaso o ID for nulo, impede a aÃ§Ã£o e avisa o utilizador
    if (loggedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro: SessÃ£o nÃ£o encontrada. Por favor, faz login novamente.')),
      );
      return;
    }
   
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: TournamentDetailsModal(
            tournament: tournament,
            currentUserId: loggedUserId, // âš ï¸ Substitui pelo ID real do utilizador autenticado atual
            onChanged: _loadTournaments, // Atualiza a lista quando alteras, apagas ou participas
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
          // Painel de Pesquisa e Filtros alinhados Ã  esquerda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => _filterTournaments(),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search by tournament or creator...',
                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
                const SizedBox(height: 12),

                // Filtros de Privacidade (All, Public, Private)
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

                // DiscoverGameFilters alinhado Ã  esquerda
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DiscoverGameFilters(
                    selectedFilterIndex: _selectedGameFilterIndex,
                    onFilterSelected: (index) {
                      setState(() {
                        _selectedGameFilterIndex = index;
                      });
                      _filterTournaments();
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Lista de Eventos
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primaryPurple))
                : _filteredTournaments.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'No tournaments found matching your criteria.',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: _filteredTournaments.length,
                        itemBuilder: (context, index) {
                          final t = _filteredTournaments[index];
                          final bool isPrivate = t['is_private'] == 1;
                          final String gameName = t['game_name'] ?? 'TCG';
                          final String organizerName = t['organizer_name'] ?? 'Unknown Creator';
                          final String location = isPrivate
                              ? 'ðŸ“ Private Location (Invite Only)'
                              : 'ðŸ“ ${t['location_name'] ?? 'Location not specified'}';

                          // FormataÃ§Ã£o dinÃ¢mica de start_time
                          String dateLabel = isPrivate ? 'PRIVATE' : 'TODAY';
                          if (t['start_time'] != null) {
                            try {
                              final DateTime dt = DateTime.parse(t['start_time']).toLocal();
                              dateLabel =
                                  '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')} â€¢ ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
                              if (isPrivate) {
                                dateLabel = '$dateLabel (PRIVATE)';
                              }
                            } catch (_) {}
                          }

                          final String storeDetails = 'By $organizerName\n$location';
                          final String tagText = '${gameName.toUpperCase()} â€¢ $dateLabel';

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: GestureDetector(
                              onTap: () => _openEventDetailsModal(context, t), // ðŸ‘ˆ Abre o modal de detalhes ao tocar
                              child: DiscoverFeaturedEventCard(
                                tag: tagText,
                                title: t['title'] ?? 'Tournament',
                                storeDetails: storeDetails,
                                seatsLeft: '${t['max_slots'] ?? 8} max slots',
                                gameId: t['game_id'],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await showDialog<bool>(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(16),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
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
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

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
            color: isSelected ? AppColors.primaryPurple : const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColors.primaryPurple : Colors.white10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textMuted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}