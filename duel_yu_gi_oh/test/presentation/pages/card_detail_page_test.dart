import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:duel_yu_gi_oh/presentation/pages/card_detail_page.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart' as yugioh;
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('CardDetailPage displays card information correctly', (WidgetTester tester) async {
    final testCard = yugioh.Card(
      id: 1,
      name: 'Test Card',
      type: 'Effect Monster',
      desc: 'This is a test card description',
      atk: 1000,
      def: 1000,
      level: 4,
      race: 'Warrior',
      attribute: 'LIGHT',
      archetype: 'Test Archetype',
      imageUrl: 'https://example.com/image.jpg',
      isBanned: false,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(card: testCard),
        ),
      );

      expect(find.text('Test Card'), findsOneWidget);
      expect(find.text('Effect Monster'), findsOneWidget);
      expect(find.text('This is a test card description'), findsOneWidget);
      expect(find.text('ATK: 1000'), findsOneWidget);
      expect(find.text('DEF: 1000'), findsOneWidget);
      expect(find.text('Nivel/Rango: 4'), findsOneWidget);
      expect(find.text('Raza: Warrior'), findsOneWidget);
      expect(find.text('Atributo: LIGHT'), findsOneWidget);
      expect(find.text('Arquetipo: Test Archetype'), findsOneWidget);
    });
  });

  testWidgets('CardDetailPage handles null values correctly', (WidgetTester tester) async {
    final testCard = yugioh.Card(
      id: 2,
      name: 'Test Spell Card',
      type: 'Spell Card',
      desc: 'This is a test spell card',
      race: 'Normal',
      imageUrl: 'https://example.com/spell.jpg',
      isBanned: false,
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardDetailPage(card: testCard),
        ),
      );

      expect(find.text('Test Spell Card'), findsOneWidget);
      expect(find.text('Spell Card'), findsOneWidget);
      expect(find.text('This is a test spell card'), findsOneWidget);
      expect(find.text('ATK:'), findsNothing);
      expect(find.text('DEF:'), findsNothing);
      expect(find.text('Nivel/Rango:'), findsNothing);
      expect(find.text('Raza: Normal'), findsOneWidget);
      expect(find.text('Atributo:'), findsNothing);
      expect(find.text('Arquetipo:'), findsNothing);
    });
  });
}
