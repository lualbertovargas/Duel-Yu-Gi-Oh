import 'package:duel_yu_gi_oh/domain/entities/card.dart';
import 'package:duel_yu_gi_oh/domain/repositories/card_repository.dart';

class GetCardsByArchetype {
  final CardRepository repository;

  GetCardsByArchetype(this.repository);

  Future<List<Card>> execute(String archetype) async {
    return await repository.getCardsByArchetype(archetype);
  }
}
