import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';
import '../../domain/entities/card.dart' as yugioh;
import 'card_detail.page.dart';
import '../../colors/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> archetypes = ['Crystron', 'Destiny HERO', 'Six Samurai'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yu-Gi-Oh! Duel App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selecciona un arquetipo:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildArchetypeButton(context, archetypes[0]),
                    const SizedBox(width: 12),
                    _buildArchetypeButton(context, archetypes[1]),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildArchetypeButton(context, archetypes[2]),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
              builder: (context, state) {
                if (state is CardInitial) {
                  return Center(
                    child: Text(
                      'Selecciona un arquetipo para comenzar',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (state is CardLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CardLoaded) {
                  return CardGridView(cards: state.cards);
                } else if (state is CardError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchetypeButton(BuildContext context, String archetype) {
    return ElevatedButton(
      onPressed: () {
        context.read<CardBloc>().add(LoadCardsByArchetype(archetype));
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child:
          Text(archetype, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

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
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: YuGiOhColors.primary, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    card.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                          child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ));
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: YuGiOhColors.primary.withOpacity(0.1),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                child: Text(
                  card.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
