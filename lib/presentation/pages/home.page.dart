import 'package:duel_yu_gi_oh/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_bloc.dart';
import '../bloc/card_event.dart';
import '../bloc/card_state.dart';

/// Página principal de la aplicación Yu-Gi-Oh! Duel.
/// Muestra una lista de arquetipos y las cartas correspondientes.
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  // Lista de arquetipos disponibles
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
          // Sección superior con botones de arquetipos
          _buildArchetypeSection(context),
          // Sección inferior con la lista de cartas
          _buildCardListSection(),
        ],
      ),
    );
  }

  /// Construye la sección superior con los botones de arquetipos
  Widget _buildArchetypeSection(BuildContext context) {
    return Container(
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
          Center(
            child: Text(
              'Select an archetype:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 30),
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
    );
  }

  /// Construye la sección inferior con la lista de cartas
  Widget _buildCardListSection() {
    return Expanded(
      child: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardInitial) {
            return Center(
              child: Text(
                'Select an archetype to begin',
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
                'Warning: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Crea un botón para un arquetipo específico
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
      child: Text(
        archetype,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
