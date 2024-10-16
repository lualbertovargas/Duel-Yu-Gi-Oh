import 'package:duel_yu_gi_oh/colors/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../domain/entities/card.dart' as yugioh;

/// [CardDetailPage] is a StatelessWidget that displays the details of a card.
/// It receives a [card] object as a parameter and displays the card
/// image, information, and description.
///
class CardDetailPage extends StatelessWidget {
  final yugioh.Card card;

  const CardDetailPage({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(card.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: CardDetailContent(card: card),
    );
  }
}

class CardDetailContent extends StatefulWidget {
  final yugioh.Card card;

  const CardDetailContent({Key? key, required this.card}) : super(key: key);

  @override
  _CardDetailContentState createState() => _CardDetailContentState();
}

class _CardDetailContentState extends State<CardDetailContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showDetails = true;
          });
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 65),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi * _animation.value),
                    child: child,
                  );
                },
                child: Hero(
                  tag: 'card_${widget.card.id}',
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: YuGiOhColors.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        widget.card.imageUrl,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (_showDetails) ...[
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildInfoCard(context),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildDescriptionCard(context),
            ),
            const SizedBox(height: 24),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Information', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow('Type', widget.card.type),
            _buildInfoRow('Race', widget.card.race),
            if (widget.card.attribute != null)
              _buildInfoRow('Attribute', widget.card.attribute!),
            if (widget.card.level != null)
              _buildInfoRow('Level/Rank', widget.card.level.toString()),
            if (widget.card.atk != null)
              _buildInfoRow('ATK', widget.card.atk.toString()),
            if (widget.card.def != null)
              _buildInfoRow('DEF', widget.card.def.toString()),
            if (widget.card.archetype != null)
              _buildInfoRow('Archetype', widget.card.archetype!),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Text(
              widget.card.desc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
