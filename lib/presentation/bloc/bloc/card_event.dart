import 'package:equatable/equatable.dart';

abstract class CardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CardLoad extends CardEvent {}
