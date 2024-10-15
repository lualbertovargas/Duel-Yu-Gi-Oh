import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart';
import 'package:duel_yu_gi_oh/domain/repositories/card_repository.dart';
import 'package:duel_yu_gi_oh/domain/usecases/get_cards_by_archetype.dart';

import 'get_cards_by_archetype_test.mocks.dart';

@GenerateMocks([CardRepository])
void main() {
  late GetCardsByArchetype usecase;
  late MockCardRepository mockCardRepository;

  setUp(() {
    mockCardRepository = MockCardRepository();
    usecase = GetCardsByArchetype(mockCardRepository);
  });

  final tArchetype = 'Test Archetype';
  final tCards = [
    Card(
      id: 1,
      name: 'Test Card',
      type: 'Effect Monster',
      desc: 'This is a test card',
      atk: 1000,
      def: 1000,
      level: 4,
      race: 'Warrior',
      attribute: 'LIGHT',
      archetype: 'Test Archetype',
      imageUrl: 'https://example.com/image.jpg',
      isBanned: false,
    )
  ];

  test(
    'should get cards by archetype from the repository',
    () async {
      // arrange
      when(mockCardRepository.getCardsByArchetype(any))
          .thenAnswer((_) async => tCards);
      // act
      final result = await usecase.execute(tArchetype);
      // assert
      expect(result, tCards);
      verify(mockCardRepository.getCardsByArchetype(tArchetype));
      verifyNoMoreInteractions(mockCardRepository);
    },
  );
}
