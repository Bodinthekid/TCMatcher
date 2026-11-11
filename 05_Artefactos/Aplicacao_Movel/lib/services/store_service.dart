import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/tcg_store_model.dart'; // 👈 Importação limpa do Model

/// Serviço responsável por gerir as requisições HTTP relacionadas com as Lojas (Stores)
/// junto da API backend do TCMatcher (Node.js/Express).
class StoreService {

  /// Obtém o URL base da API a partir das variáveis de ambiente (`.env`).
  /// Caso não esteja definido no `.env`, utiliza por predefinição o IP de localhost 
  /// otimizado para o emulador Android (`10.0.2.2`).
  static String get baseUrl => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:3000/api';

  /// Procura e retorna uma lista de lojas de TCG próximas com base nas coordenadas geográficas.
  /// Faz um pedido `GET` ao endpoint `/stores/nearby`, enviando a latitude (`lat`), 
  /// a longitude (`lon`) e um raio de abrangência padrão (por exemplo, 5000 metros / 5km).
  /// Retorna uma lista de objetos [TcgStoreModel] em caso de sucesso, ou uma lista vazia `[]`
  /// caso ocorra algum erro na rede ou no servidor, blindando a interface (UI) contra falhas.
  static Future<List<TcgStoreModel>> getNearbyStores(double lat, double lon) async {
    try {
      // Constrói o URL completo com os parâmetros de consulta de geolocalização
      final url = Uri.parse('$baseUrl/stores/nearby?lat=$lat&lon=$lon&radius=5000');
      print('🔗 URL exato a ser chamado pelo Flutter: $url');
      // Executa a requisição HTTP GET de forma assíncrona
      final response = await http.get(url);
      print('📡 Status Code recebido: ${response.statusCode}');
      
      // Valida se o servidor respondeu com sucesso (Status Code 200)
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List storesJson = data['stores'];
        
        // Mapeia cada elemento da lista JSON para uma instância do TcgStoreModel
        return storesJson.map((json) => TcgStoreModel.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar lojas próximas do servidor.');
      }
    } catch (e) {
      // Regista o erro detalhado na consola para fins de depuração (debug)
      print('Erro no StoreService: $e');
      
      // Retorna uma lista vazia para evitar que a aplicação faça crash e proteja o mapa
      return [];
    }
  }
}