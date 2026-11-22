import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/tournament_controller.dart';
import '../theme/app_colors.dart';
import '../widgets/events/casual_tournament_fields.dart';
import '../widgets/events/tournament_form_helpers.dart';
import '../widgets/events/tournament_modal_header.dart';

class CreateCasualTournamentScreen extends StatefulWidget {
  const CreateCasualTournamentScreen({super.key});

  @override
  State<CreateCasualTournamentScreen> createState() =>
      _CreateCasualTournamentScreenState();
}

class _CreateCasualTournamentScreenState
    extends State<CreateCasualTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _selectedGameId = 1;
  double _maxSlots = 8;
  bool _isPrivate = false;
  DateTime _startTime = DateTime.now().add(const Duration(hours: 1));
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartTime() async {
    final picked = await pickTournamentDateTime(context, _startTime);
    if (picked != null && mounted) setState(() => _startTime = picked);
  }

  void _showSnack(String msg, {Color? bg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: bg),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final organizerId = AuthController.currentUserId;
    if (organizerId == null) {
      setState(() => _isLoading = false);
      _showSnack(
        'Error: No active session found. Please log in again.',
        bg: Colors.red,
      );
      return;
    }

    final desc = _descriptionController.text.trim();
    final success = await TournamentController.createCasualTournament(
      organizerId: organizerId,
      gameId: _selectedGameId,
      title: _titleController.text.trim(),
      description: desc.isEmpty ? null : desc,
      locationName: _locationController.text.trim(),
      startTime: _startTime.toIso8601String(),
      maxSlots: _maxSlots.toInt(),
      isPrivate: _isPrivate,
    );

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pop(context, true);
    } else {
      _showSnack('Failed to create tournament. Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TournamentModalHeader(
                title: 'Create Casual Tournament',
                onClose: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16),
              CasualTournamentFields(
                titleController: _titleController,
                locationController: _locationController,
                descriptionController: _descriptionController,
                selectedGameId: _selectedGameId,
                maxSlots: _maxSlots,
                isPrivate: _isPrivate,
                startTime: _startTime,
                onGameChanged: (v) => setState(() => _selectedGameId = v),
                onMaxSlotsChanged: (v) => setState(() => _maxSlots = v),
                onPrivateChanged: (v) => setState(() => _isPrivate = v),
                onSelectStartTime: _selectStartTime,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Create Event',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}