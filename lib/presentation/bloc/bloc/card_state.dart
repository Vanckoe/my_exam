import 'package:equatable/equatable.dart';
import 'package:flutter_market/data/models/cards_models.dart';

abstract class CardState extends Equatable {
  const CardState();
  
  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class CardLoadInProgress extends CardState {}

class CardLoadSuccess extends CardState {
  final List<FinanceCard> cards;

  const CardLoadSuccess([this.cards = const []]);

  @override
  List<Object> get props => [cards];
}

class CardLoadFailure extends CardState {}
