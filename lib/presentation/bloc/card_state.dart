import 'package:equatable/equatable.dart';
import '../../domain/entities/card.dart';

abstract class CardState extends Equatable {
  const CardState();
  
  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardLoaded extends CardState {
  final List<Card> cards;

  const CardLoaded(this.cards);

  @override
  List<Object> get props => [cards];
}

class CardError extends CardState {
  final String message;

  const CardError(this.message);

  @override
  List<Object> get props => [message];
}
