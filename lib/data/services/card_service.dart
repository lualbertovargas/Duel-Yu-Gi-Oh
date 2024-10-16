import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/card.dart';

///Service to handle the YGOProDeck API
///Currently only used to get cards by archetype
///Can be extended to get more card information
///such as cards by name, by type, by race, etc.

///Returns [true] if the card is banned
///Otherwise returns [false]
///

class CardService {
  final String baseUrl = 'https://db.ygoprodeck.com/api/v7';

  Future<List<Card>> getCardsByArchetype(String archetype) async {
    final response =
        await http.get(Uri.parse('$baseUrl/cardinfo.php?archetype=$archetype'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data
          .map((json) => _cardFromJson(json))
          .where((card) => !card.isBanned)
          .toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }

  Card _cardFromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      desc: json['desc'] ?? '',
      atk: json['atk'] is int ? json['atk'] : null,
      def: json['def'] is int ? json['def'] : null,
      level: json['level'] is int ? json['level'] : null,
      race: json['race'] ?? '',
      attribute: json['attribute'] ?? '',
      archetype: json['archetype'] ?? '',
      imageUrl: json['card_images'] != null && json['card_images'].isNotEmpty
          ? json['card_images'][0]['image_url'] ?? ''
          : '',
      isBanned: _checkIfBanned(json['banlist_info']),
    );
  }

  ///Metodo revisa si la carta esta [prohibida]
  ///
  bool _checkIfBanned(dynamic banlistInfo) {
    if (banlistInfo == null) return false;
    if (banlistInfo is Map<String, dynamic>) {
      final String? tcgStatus = banlistInfo['ban_tcg'];
      return tcgStatus == 'Banned';
    }
    return false;
  }
}
