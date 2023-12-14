import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/domain/uses_case/card_usecase.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_event.dart';
import 'package:flutter_market/presentation/bloc/bloc/card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final GetCardsUseCase getCardsUseCase;

  CardBloc({required this.getCardsUseCase}) : super(CardInitial()) {
    on<CardLoad>(_onCardLoad);
  }

  void _onCardLoad(CardLoad event, Emitter<CardState> emit) async {
  try {
    emit(CardLoadInProgress());
    final cards = await getCardsUseCase.call();
    emit(CardLoadSuccess(cards));
  } catch (e) {
    print('Error in CardBloc: $e');
    emit(CardLoadFailure());
  }
}

}
