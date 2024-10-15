import 'package:duel_yu_gi_oh/data/services/card_service.dart';
import 'package:duel_yu_gi_oh/domain/entities/card.dart';
import 'package:duel_yu_gi_oh/domain/repositories/card_repository.dart';

class CardRepositoryImpl implements CardRepository {
  final CardService cardService;

  CardRepositoryImpl(this.cardService);

  @override
  Future<List<Card>> getCardsByArchetype(String archetype) async {
    return await cardService.getCardsByArchetype(archetype);
  }
}
