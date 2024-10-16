import 'package:equatable/equatable.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class LoadCardsByArchetype extends CardEvent {
  final String archetype;

  const LoadCardsByArchetype(this.archetype);

  @override
  List<Object> get props => [archetype];
}
