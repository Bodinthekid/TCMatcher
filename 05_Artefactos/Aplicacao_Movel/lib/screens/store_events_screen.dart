import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/tournament_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/events/events_filters_panel.dart';
import '../widgets/events/events_list_view.dart';
import '../widgets/events/tournament_details_modal.dart';
import '../widgets/events/tournament_filter_helper.dart';
import 'create_casual_tournament_screen.dart';

class StoreEventsScreen extends StatefulWidget {
  const StoreEventsScreen({super.key});

  @override
  State<StoreEventsScreen> createState() => _StoreEventsScreenState();
}

class _StoreEventsScreenState extends State<StoreEventsScreen> {
  List<dynamic> _allTournaments = [];
  List<dynamic> _filteredTournaments = [];
  bool _isLoading = true;
  String _selectedFilter = 'All';
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
        selectedCategory: _selectedFilter,
        selectedGameIndexes: _selectedGameFilterIndexes,
        currentUserId: AuthController.currentUserId?.toString(),
      );
    });
  }

  void _toggleGameFilter(int index) {
    setState(() {
      _selectedGameFilterIndexes.contains(index)
          ? _selectedGameFilterIndexes.remove(index)
          : _selectedGameFilterIndexes.add(index);
    });
    _applyFilters();
  }

  void _openDetails(dynamic tournament) {
    final loggedUserId = AuthController.currentUserId;
    if (loggedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session not found. Please log in again.')),
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
        primary: false,
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
            categories: const ['All', 'Mine', 'Public', 'Private'],
            selectedCategory: _selectedFilter,
            selectedGameFilterIndexes: _selectedGameFilterIndexes,
            onSearchChanged: (_) => _applyFilters(),
            onCategoryChanged: (val) {
              setState(() => _selectedFilter = val);
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