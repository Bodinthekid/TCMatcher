import 'package:flutter/material.dart';
import '/theme/app_colors.dart';
import '/controllers/tournament_controller.dart';

class TournamentDetailsModal extends StatefulWidget {
  final dynamic tournament;
  final int currentUserId; // ID do utilizador atual logado
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

  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.tournament['title'] ?? '');
    _locationController = TextEditingController(text: widget.tournament['location_name'] ?? '');
    _descriptionController = TextEditingController(text: widget.tournament['description'] ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _isCreator {
    final organizerId = widget.tournament['organizer_id'];
    return organizerId != null && organizerId.toString() == widget.currentUserId.toString();
  }

  Future<void> _joinTournament() async {
    setState(() => _isLoading = true);
    
    // O TournamentController.joinTournament deve lançar a exceção com a mensagem do backend
    final success = await TournamentController.joinTournament(
      widget.tournament['id'], 
      widget.currentUserId,
    );
    
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pop(context);
      
      // Se falhou, podes tentar obter a mensagem de erro ou mostrar uma mensagem genérica/específica
      String message = success 
          ? 'Successfully joined the tournament!' 
          : 'You are already registered for this tournament.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: success ? Colors.green : Colors.orangeAccent, // Laranja para avisos/duplicados
        ),
      );

      if (success) widget.onChanged();
    }
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);
    
    final success = await TournamentController.updateTournament(
      tournamentId: widget.tournament['id'],
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      locationName: _locationController.text.trim(),
    );

    setState(() {
      _isLoading = false;
      if (success) _isEditing = false;
    });

    if (success) {
      widget.onChanged();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tournament updated successfully!')),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update tournament.')),
      );
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Delete Tournament', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this tournament? This action cannot be undone.', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Fecha o alerta
              Navigator.pop(context); // Fecha o modal de detalhes
              final success = await TournamentController.deleteTournament(widget.tournament['id']);
              if (success) {
                widget.onChanged();
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tournament;
    final String organizerName = t['organizer_name'] ?? 'Unknown Creator';
    final String gameName = t['game_name'] ?? 'TCG';

    // Formatação da data para exibição no modal
    String formattedDate = 'Time not set';
    if (t['start_time'] != null) {
      try {
        final DateTime dt = DateTime.parse(t['start_time']).toLocal();
        formattedDate = '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (_) {}
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(gameName.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 11)),
                  backgroundColor: AppColors.primaryPurple,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Modo Edição (Se for criador e clicou em editar)
            if (_isCreator && _isEditing) ...[
              const Text('Edit Tournament', style: TextStyle(color: AppColors.accentCyan, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Tournament Title'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Location / Address'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: _inputDecoration('Description / Rules'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white24)),
                      onPressed: () => setState(() => _isEditing = false),
                      child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryPurple),
                      onPressed: _isLoading ? null : _saveChanges,
                      child: _isLoading 
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ] else ...[
              // Modo Visualização Normal
              Text(
                t['title'] ?? 'Tournament',
                style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Organized by $organizerName',
                style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 20),

              // Detalhes
              _buildInfoRow(Icons.location_on_outlined, t['location_name'] ?? 'Location not specified'),
              const SizedBox(height: 10),
              _buildInfoRow(Icons.people_outline, '${t['max_slots'] ?? 8} Maximum Player Slots'),
              const SizedBox(height: 10),
              _buildInfoRow(Icons.access_time, formattedDate),
              
              const SizedBox(height: 20),
              const Divider(color: Colors.white10),
              const SizedBox(height: 10),

              // Descrição
              const Text('Description & Rules', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(
                (t['description'] == null || t['description'].toString().isEmpty) 
                    ? 'No description provided for this event.' 
                    : t['description'],
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 30),

              // Botões de Ação Dinâmicos
              if (_isCreator) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                    label: const Text('Manage & Edit Tournament', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () => setState(() => _isEditing = true),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: const Text('Delete Tournament', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _confirmDelete(context),
                  ),
                ),
              ] else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _isLoading ? null : _joinTournament,
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Join Tournament', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accentCyan, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}