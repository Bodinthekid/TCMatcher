import 'package:flutter/material.dart';
import '../../controllers/tournament_controller.dart';
import 'tournament_delete_dialog.dart';
import 'tournament_details_body.dart';
import 'tournament_edit_form.dart';
import 'tournament_modal_header.dart';

class TournamentDetailsModal extends StatefulWidget {
  final dynamic tournament;
  final int currentUserId;
  final VoidCallback onChanged;

  const TournamentDetailsModal({
    super.key,
    required this.tournament,
    required this.currentUserId,
    required this.onChanged,
  });

  @override
  State<TournamentDetailsModal> createState() => _TournamentDetailsModalState();
}

class _TournamentDetailsModalState extends State<TournamentDetailsModal> {
  bool _isEditing = false;
  bool _isLoading = false;

  late final _titleController =
      TextEditingController(text: widget.tournament['title'] ?? '');
  late final _locationController =
      TextEditingController(text: widget.tournament['location_name'] ?? '');
  late final _descriptionController =
      TextEditingController(text: widget.tournament['description'] ?? '');

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isCreator =>
      widget.tournament['organizer_id']?.toString() ==
      widget.currentUserId.toString();

  void _showSnack(String msg, {Color? bg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: bg),
    );
  }

  Future<void> _joinTournament() async {
    setState(() => _isLoading = true);
    final success = await TournamentController.joinTournament(
      widget.tournament['id'],
      widget.currentUserId,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pop(context);
    _showSnack(
      success
          ? 'Successfully joined the tournament!'
          : 'You are already registered for this tournament.',
      bg: success ? Colors.green : Colors.orangeAccent,
    );
    if (success) widget.onChanged();
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);
    final success = await TournamentController.updateTournament(
      tournamentId: widget.tournament['id'],
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      locationName: _locationController.text.trim(),
    );
    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (success) _isEditing = false;
    });
    if (success) widget.onChanged();
    _showSnack(
      success
          ? 'Tournament updated successfully!'
          : 'Failed to update tournament.',
    );
  }

  Future<void> _handleDelete() async {
    final confirmed = await showDeleteTournamentDialog(context);
    if (!confirmed || !mounted) return;

    Navigator.pop(context);
    final success =
        await TournamentController.deleteTournament(widget.tournament['id']);
    if (success) widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final gameName = (widget.tournament['game_name'] ?? 'TCG').toString();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TournamentModalHeader(
              badgeLabel: gameName,
              onClose: () => Navigator.pop(context),
            ),
            const SizedBox(height: 10),
            if (_isCreator && _isEditing)
              TournamentEditForm(
                titleController: _titleController,
                locationController: _locationController,
                descriptionController: _descriptionController,
                isLoading: _isLoading,
                onCancel: () => setState(() => _isEditing = false),
                onSave: _saveChanges,
              )
            else
              TournamentDetailsBody(
                tournament: widget.tournament,
                isCreator: _isCreator,
                isLoading: _isLoading,
                onEditTap: () => setState(() => _isEditing = true),
                onDeleteTap: _handleDelete,
                onJoinTap: _joinTournament,
              ),
          ],
        ),
      ),
    );
  }
}