import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:duel_yu_gi_oh/presentation/pages/home.page.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_bloc.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_state.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart' as yugioh;

import 'home_page_test.mocks.dart';

@GenerateMocks([CardBloc])
void main() {
  late MockCardBloc mockCardBloc;

  setUp(() {
    mockCardBloc = MockCardBloc();
    when(mockCardBloc.stream).thenAnswer((_) => Stream.value(CardInitial()));
  });

  testWidgets('HomePage displays initial state correctly',
      (WidgetTester tester) async {
    when(mockCardBloc.state).thenReturn(CardInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CardBloc>.value(
          value: mockCardBloc,
          child: HomePage(),
        ),
      ),
    );

    expect(find.text('Yu-Gi-Oh! Duel App'), findsOneWidget);
    expect(find.text('Selecciona un arquetipo:'), findsOneWidget);
    expect(find.text('Crystron'), findsOneWidget);
    expect(find.text('Destiny HERO'), findsOneWidget);
    expect(find.text('Six Samurai'), findsOneWidget);
  });

  testWidgets('HomePage displays loading state correctly',
      (WidgetTester tester) async {
    when(mockCardBloc.state).thenReturn(CardLoading());
    when(mockCardBloc.stream).thenAnswer((_) => Stream.value(CardLoading()));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CardBloc>.value(
          value: mockCardBloc,
          child: HomePage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePage displays loaded state correctly',
      (WidgetTester tester) async {
    final cards = [
      yugioh.Card(
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
      ),
    ];

    when(mockCardBloc.state).thenReturn(CardLoaded(cards));
    when(mockCardBloc.stream)
        .thenAnswer((_) => Stream.value(CardLoaded(cards)));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CardBloc>.value(
          value: mockCardBloc,
          child: HomePage(),
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Test Card'), findsOneWidget);
  });
}
