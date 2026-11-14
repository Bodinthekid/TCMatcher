import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../controllers/tournament_controller.dart';
import '../controllers/auth_controller.dart'; // 👈 Import necessário para aceder ao ID global

class CreateCasualTournamentScreen extends StatefulWidget {
  const CreateCasualTournamentScreen({super.key});

  @override
  State<CreateCasualTournamentScreen> createState() => _CreateCasualTournamentScreenState();
}

class _CreateCasualTournamentScreenState extends State<CreateCasualTournamentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  int _selectedGameId = 1; // 1 = Magic, 2 = Pokémon, etc.
  double _maxSlots = 8;
  bool _isPrivate = false;

  // Data e hora de início predefinida (1 hora à frente)
  DateTime _startTime = DateTime.now().add(const Duration(hours: 1));
  bool _isLoading = false;

  // Função para abrir os seletores visuais (Calendário + Relógio)
  Future<void> _selectStartTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.primaryPurple,
              surface: Color(0xFF1E1E1E),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_startTime),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: AppColors.primaryPurple,
                surface: Color(0xFF1E1E1E),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          _startTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // 🔑 Obtém o ID real do utilizador autenticado
    final int? organizerId = AuthController.currentUserId;

    // Validação estrita: se não houver sessão ativa, cancela e avisa o utilizador
    if (organizerId == null) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: No active session found. Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final success = await TournamentController.createCasualTournament(
      organizerId: organizerId, // 👈 Usa o ID real em vez de valores fixos
      gameId: _selectedGameId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      locationName: _locationController.text.trim(),
      startTime: _startTime.toIso8601String(),
      maxSlots: _maxSlots.toInt(),
      isPrivate: _isPrivate,
    );

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pop(context, true);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create tournament. Try again.')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Create Casual Tournament',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white70),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Nome do Torneio
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Ex: Casual Park Session / Home Game'),
                validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
              ),
              const SizedBox(height: 16),

              // Jogo TCG
              DropdownButtonFormField<int>(
                value: _selectedGameId,
                dropdownColor: const Color(0xFF1E1E1E),
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Select TCG Game'),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Magic: The Gathering')),
                  DropdownMenuItem(value: 2, child: Text('Pokémon TCG')),
                  DropdownMenuItem(value: 3, child: Text('One Piece TCG')),
                  DropdownMenuItem(value: 4, child: Text('Yu-Gi-Oh!')),
                ],
                onChanged: (val) => setState(() => _selectedGameId = val!),
              ),
              const SizedBox(height: 16),

              // Slots Máximos
              Text('Max Player Slots: ${_maxSlots.toInt()}', style: const TextStyle(color: Colors.white70)),
              Slider(
                value: _maxSlots,
                min: 4,
                max: 32,
                divisions: 7,
                activeColor: AppColors.primaryPurple,
                onChanged: (val) => setState(() => _maxSlots = val),
              ),
              const SizedBox(height: 16),

              // Localização / Morada
              TextFormField(
                controller: _locationController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Ex: Main Street, nº 123 or City Park'),
                validator: (val) => val == null || val.isEmpty ? 'Required field' : null,
              ),
              const SizedBox(height: 16),

              // Descrição / Regras (Opcional)
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 3,
                decoration: _inputDecoration('Ex: Bring standard deck, starts at 3 PM... (Optional)'),
              ),
              const SizedBox(height: 16),

              // Botão Visual para Seleção de Data e Hora de Início
              _buildDateTimeCard(
                label: 'Tournament Start Date & Time',
                dateTime: _startTime,
                onTap: _selectStartTime,
              ),
              const SizedBox(height: 16),

              // Toggle Privado
              SwitchListTile(
                title: const Text('Private Tournament', style: TextStyle(color: Colors.white)),
                subtitle: const Text('Hidden from public map', style: TextStyle(color: AppColors.textMuted)),
                value: _isPrivate,
                activeColor: AppColors.primaryPurple,
                onChanged: (val) => setState(() => _isPrivate = val),
              ),
              const SizedBox(height: 20),

              // Botão Criar Evento
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Create Event', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeCard({required String label, required DateTime dateTime, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                const SizedBox(height: 4),
                Text(
                  '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Icon(Icons.calendar_today, color: AppColors.primaryPurple, size: 20),
          ],
        ),
      ),
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