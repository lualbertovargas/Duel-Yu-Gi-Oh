import 'package:duel_yu_gi_oh/domain/entities/card.dart';

abstract class CardRepository {
  Future<List<Card>> getCardsByArchetype(String archetype);
}
