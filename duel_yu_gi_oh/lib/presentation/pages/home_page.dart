import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';
import '../../domain/entities/card.dart' as yugioh;
import 'card_detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> archetypes = ['Crystron', 'Destiny HERO', 'Six Samurai'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yu-Gi-Oh! Duel App', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecciona un arquetipo:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: archetypes.map((archetype) => ElevatedButton(
                    onPressed: () {
                      context.read<CardBloc>().add(LoadCardsByArchetype(archetype));
                    },
                    child: Text(archetype),
                  )).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                if (state is CardInitial) {
                  return Center(child: Text('Selecciona un arquetipo para comenzar'));
                } else if (state is CardLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is CardLoaded) {
                  return CardGridView(cards: state.cards);
                } else if (state is CardError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardGridView extends StatelessWidget {
  final List<yugioh.Card> cards;

  const CardGridView({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardItem(card: cards[index]);
      },
    );
  }
}

class CardItem extends StatelessWidget {
  final yugioh.Card card;

  const CardItem({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetailPage(card: card),
          ),
        );
      },
      child: Hero(
        tag: 'card_${card.id}',
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.network(
                    card.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  card.name,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
