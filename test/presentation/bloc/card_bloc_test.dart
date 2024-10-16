import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:duel_yu_gi_oh/domain/usecases/get_cards_by_archetype.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_bloc.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_event.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_state.dart';

import 'card_bloc_test.mocks.dart';

@GenerateMocks([GetCardsByArchetype])
void main() {
  late MockGetCardsByArchetype mockGetCardsByArchetype;
  late CardBloc cardBloc;

  setUp(() {
    mockGetCardsByArchetype = MockGetCardsByArchetype();
    cardBloc = CardBloc(mockGetCardsByArchetype);
  });

  test('initial state is CardInitial', () {
    expect(cardBloc.state, isA<CardInitial>());
  });

  blocTest<CardBloc, CardState>(
    'emits [CardLoading, CardLoaded] when LoadCardsByArchetype is added and successful',
    build: () {
      when(mockGetCardsByArchetype.execute(any)).thenAnswer((_) async => [
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
      ]);
      return cardBloc;
    },
    act: (bloc) => bloc.add(LoadCardsByArchetype('Test Archetype')),
    expect: () => [
      isA<CardLoading>(),
      isA<CardLoaded>(),
    ],
  );

  blocTest<CardBloc, CardState>(
    'emits [CardLoading, CardError] when LoadCardsByArchetype is added and unsuccessful',
    build: () {
      when(mockGetCardsByArchetype.execute(any)).thenThrow(Exception('Failed to load cards'));
      return cardBloc;
    },
    act: (bloc) => bloc.add(LoadCardsByArchetype('Test Archetype')),
    expect: () => [
      isA<CardLoading>(),
      isA<CardError>(),
    ],
  );
}
