import 'package:duel_yu_gi_oh/domain/entities/card.dart';

///Método abstracto para obtener una lista de cartas por arquetipo
///
abstract class CardRepository {
  Future<List<Card>> getCardsByArchetype(String archetype);
}
