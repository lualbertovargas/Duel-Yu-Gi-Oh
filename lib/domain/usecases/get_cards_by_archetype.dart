import 'package:duel_yu_gi_oh/domain/entities/card.dart';
import 'package:duel_yu_gi_oh/domain/repositories/card_repository.dart';

///Obtencion de la logica basado en el arquetipo especifico
///[archetype] es el nombre del arquetipo que se utilizará
///para filtrar las cartas. Retorna una lista de objetos [Card]
///
class GetCardsByArchetype {
  final CardRepository repository;

  GetCardsByArchetype(this.repository);

  Future<List<Card>> execute(String archetype) async {
    return await repository.getCardsByArchetype(archetype);
  }
}
