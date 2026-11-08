/// Modelo de dados que representa uma Loja de Trading Card Games (TCG).
/// 
/// Utilizado para mapear as lojas vindas da Overpass API (OpenStreetMap) 
/// ou da base de dados MySQL interna do TCMatcher.
/// 
class TcgStoreModel {

  final int id;   /// Identificador único da loja (ex: osm_id do OpenStreetMap ou ID do MySQL).
  final String name;  /// Nome comercial do estabelecimento.
  final double lat;  /// Latitude geográfica para posicionamento no mapa (`flutter_map`).
  final double lon;  /// Longitude geográfica para posicionamento no mapa (`flutter_map`).
  final String address;  /// Morada ou linha de endereço formatada da loja.

  /// Construtor principal para criar uma instância do modelo com todos os campos obrigatórios.
  TcgStoreModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
    required this.address,
  });

  /// Factory constructor para instanciar a loja a partir de um JSON (Resposta da API).
  /// 
  /// Converte com segurança os valores numéricos de coordenadas (`num`) para `double`,
  /// e aplica um valor padrão ao endereço caso a API devolva `null`.
  factory TcgStoreModel.fromJson(Map<String, dynamic> json) {
    return TcgStoreModel(
      id: json['id'],
      name: json['name'],
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      address: json['address'] ?? 'Localização comercial',
    );
  }

  /// Converte a instância atual do modelo num mapa JSON `Map<String, dynamic>`.
  /// 
  /// Útil para guardar em cache local, enviar em requisições HTTP POST/PUT
  /// ou fazer persistência de dados no dispositivo.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lat': lat,
      'lon': lon,
      'address': address,
    };
  }
}