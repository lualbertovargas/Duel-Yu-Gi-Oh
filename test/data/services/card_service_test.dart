import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:duel_yu_gi_oh/data/services/card_service.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart';

import 'card_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('CardService', () {
    late CardService cardService;
    late MockClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockClient();
      cardService = CardService();
    });

    test('getCardsByArchetype returns a list of Cards if the http call completes successfully', () async {
      final responseData = {
        "data": [
          {
            "id": 1,
            "name": "Test Card",
            "type": "Effect Monster",
            "desc": "This is a test card",
            "atk": 1000,
            "def": 1000,
            "level": 4,
            "race": "Warrior",
            "attribute": "LIGHT",
            "archetype": "Test Archetype",
            "card_images": [{"image_url": "https://example.com/image.jpg"}]
          }
        ]
      };

      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(json.encode(responseData), 200));

      final cards = await cardService.getCardsByArchetype('Test Archetype');

      expect(cards, isA<List<Card>>());
      expect(cards.length, 1);
      expect(cards[0].name, 'Test Card');
    });

    test('getCardsByArchetype throws an exception if the http call completes with an error', () {
      when(mockHttpClient.get(any))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(cardService.getCardsByArchetype('Test Archetype'), throwsException);
    });
  });
}
