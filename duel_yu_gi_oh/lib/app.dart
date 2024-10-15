import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/bloc/card_bloc.dart';
import 'data/services/card_service.dart';
import 'data/repositories/card_repository_impl.dart';
import 'domain/usecases/get_cards_by_archetype.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardService = CardService();
    final cardRepository = CardRepositoryImpl(cardService);
    final getCardsByArchetype = GetCardsByArchetype(cardRepository);

    return BlocProvider(
      create: (context) => CardBloc(getCardsByArchetype),
      child: MaterialApp(
        title: 'Yu-Gi-Oh! Duel App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amberAccent,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.indigo[800],
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.indigo[900],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          textTheme: TextTheme(
            displayMedium: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(color: Colors.indigo[800], fontWeight: FontWeight.bold),
            titleLarge: TextStyle(color: Colors.indigo[700]),
            bodyLarge: TextStyle(color: Colors.indigo[900]),
            bodyMedium: TextStyle(color: Colors.indigo[800]),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
