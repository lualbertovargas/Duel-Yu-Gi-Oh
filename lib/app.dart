import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/pages/home.page.dart';
import 'presentation/bloc/card_bloc.dart';
import 'data/services/card_service.dart';
import 'data/repositories/card_repository_impl.dart';
import 'domain/usecases/get_cards_by_archetype.dart';
import 'colors/colors.dart';

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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: YuGiOhColors.primary,
            primary: YuGiOhColors.primary,
            secondary: YuGiOhColors.background,
            background: YuGiOhColors.background,
            surface: YuGiOhColors.cardBack,
            onPrimary: YuGiOhColors.text,
            onSecondary: YuGiOhColors.background,
            onBackground: YuGiOhColors.text,
            onSurface: YuGiOhColors.textSecondary,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: YuGiOhColors.background,
          appBarTheme: AppBarTheme(
            backgroundColor: YuGiOhColors.primary,
            foregroundColor: YuGiOhColors.text,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: YuGiOhColors.background,
              foregroundColor: YuGiOhColors.text,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          cardTheme: CardTheme(
            color: YuGiOhColors.cardBack,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: YuGiOhColors.secondary, width: 2),
            ),
          ),
          textTheme: TextTheme(
            displayLarge: TextStyle(
                color: YuGiOhColors.text, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                color: YuGiOhColors.text, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(
                color: YuGiOhColors.text, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(color: YuGiOhColors.textSecondary),
            bodyLarge: TextStyle(color: YuGiOhColors.textSecondary),
            bodyMedium: TextStyle(color: YuGiOhColors.textSecondary),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}
