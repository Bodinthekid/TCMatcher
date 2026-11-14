import '../services/tournament_service.dart';

class TournamentController {
  
  // Lógica para criar um torneio casual
  static Future<bool> createCasualTournament({
    required int organizerId,
    required int gameId,
    required String title,
    required String? description,
    required String locationName,
    required String startTime,
    required int maxSlots,
    required bool isPrivate,
  }) async {
    final bodyData = {
      'organizer_id': organizerId,
      'type_id': 2, // 2 = Casual
      'game_id': gameId,
      'title': title,
      'description': description,
      'location_name': locationName,
      'start_time': startTime,
      'max_slots': maxSlots,
      'entry_fee': 0.00,
      'is_private': isPrivate ? 1 : 0,
    };

    final response = await TournamentService.postTournament(bodyData);
    return response != null && response['success'] == true;
  }

  // Lógica para carregar a lista de torneios
  static Future<List<dynamic>> getTournamentsList() async {
    return await TournamentService.fetchTournaments();
  }

  // Participar num torneio
  static Future<bool> joinTournament(int tournamentId, int userId) async {
    final response = await TournamentService.post('/tournaments/$tournamentId/join', {
      'user_id': userId,
    });
    return response != null && response['success'] == true;
  }

  // Atualizar um torneio (modo criador)
  static Future<bool> updateTournament({
    required int tournamentId,
    required String title,
    required String? description,
    required String locationName,
  }) async {
    final response = await TournamentService.put('/tournaments/$tournamentId', {
      'title': title,
      'description': description,
      'location_name': locationName,
    });
    return response != null && response['success'] == true;
  }

  // Apagar / Cancelar um torneio (modo criador)
  static Future<bool> deleteTournament(int tournamentId) async {
    final response = await TournamentService.delete('/tournaments/$tournamentId');
    return response != null && response['success'] == true;
  }

}