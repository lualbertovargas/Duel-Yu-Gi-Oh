import 'package:equatable/equatable.dart';

///Card model according to the characteristics of the YGOProDeck API
///The relevant parameter is the [isBanned]
///

class Card extends Equatable {
  final int id;
  final String name;
  final String type;
  final String desc;
  final int? atk;
  final int? def;
  final int? level;
  final String race;
  final String? attribute;
  final String? archetype;
  final String imageUrl;
  final bool isBanned;

  const Card({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    this.atk,
    this.def,
    this.level,
    required this.race,
    this.attribute,
    this.archetype,
    required this.imageUrl,
    required this.isBanned,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        atk,
        def,
        level,
        race,
        attribute,
        archetype,
        imageUrl,
        isBanned
      ];
}
