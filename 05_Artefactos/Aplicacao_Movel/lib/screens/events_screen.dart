import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/tournament_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/events/events_filters_panel.dart';
import '../widgets/events/events_list_view.dart';
import '../widgets/events/tournament_details_modal.dart';
import '../widgets/events/tournament_filter_helper.dart';
import 'create_casual_tournament_screen.dart';

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
  final Set<int> _selectedGameFilterIndexes = {};
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTournaments();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadTournaments() async {
    setState(() => _isLoading = true);
    final tournaments = await TournamentController.getTournamentsList();
    if (!mounted) return;

    _allTournaments = tournaments;
    _applyFilters();
    setState(() => _isLoading = false);
  }

  void _applyFilters() {
    setState(() {
      _filteredTournaments = TournamentFilterHelper.filter(
        tournaments: _allTournaments,
        query: _searchController.text,
        selectedCategory: _selectedPrivacyFilter,
        selectedGameIndexes: _selectedGameFilterIndexes,
      );
    });
  }

  void _toggleGameFilter(int index) {
    setState(() {
      if (_selectedGameFilterIndexes.contains(index)) {
        _selectedGameFilterIndexes.remove(index);
      } else {
        _selectedGameFilterIndexes.add(index);
      }
    });
    _applyFilters();
  }

  void _openDetails(dynamic tournament) {
    final loggedUserId = AuthController.currentUserId;
    if (loggedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Session not found. Please log in again.'),
        ),
      );
      return;
    }

    TournamentFilterHelper.showEventModal(
      context,
      TournamentDetailsModal(
        tournament: tournament,
        currentUserId: loggedUserId,
        onChanged: _loadTournaments,
      ),
    );
  }

  Future<void> _openCreateModal() async {
    final created = await TournamentFilterHelper.showEventModal<bool>(
      context,
      const CreateCasualTournamentScreen(),
    );
    if (created == true) _loadTournaments();
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
          EventsFiltersPanel(
            searchController: _searchController,
            categories: const ['All', 'Public', 'Private'],
            selectedCategory: _selectedPrivacyFilter,
            selectedGameFilterIndexes: _selectedGameFilterIndexes,
            onSearchChanged: (_) => _applyFilters(),
            onCategoryChanged: (val) {
              setState(() => _selectedPrivacyFilter = val);
              _applyFilters();
            },
            onGameFilterToggled: _toggleGameFilter,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: EventsListView(
              isLoading: _isLoading,
              tournaments: _filteredTournaments,
              onRefresh: _loadTournaments,
              onTournamentTap: _openDetails,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCreateModal,
        backgroundColor: AppColors.primaryPurple,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}