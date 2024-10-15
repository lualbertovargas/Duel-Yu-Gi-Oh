import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duel_yu_gi_oh/domain/usecases/get_cards_by_archetype.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_event.dart';
import 'package:duel_yu_gi_oh/presentation/bloc/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetCardsByArchetype getCardsByArchetype;

  CardBloc(this.getCardsByArchetype) : super(CardInitial()) {
    on<LoadCardsByArchetype>(_onLoadCardsByArchetype);
  }

  Future<void> _onLoadCardsByArchetype(
    LoadCardsByArchetype event,
    Emitter<CardState> emit,
  ) async {
    emit(CardLoading());
    try {
      final cards = await getCardsByArchetype.execute(event.archetype);
      emit(CardLoaded(cards));
    } catch (e) {
      emit(CardError(e.toString()));
    }
  }
}
