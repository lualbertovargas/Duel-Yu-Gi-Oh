import 'package:duel_yu_gi_oh/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/card.dart' as yugioh;

class CardGridView extends StatelessWidget {
  final List<yugioh.Card> cards;

  const CardGridView({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardItem(card: cards[index]);
      },
    );
  }
}
