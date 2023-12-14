import 'package:flutter_market/domain/entities/userdata_entities.dart';

abstract class AuthenticationState {}

class AuthenticationUserDataLoaded extends AuthenticationState {
  final AppUser user;

  AuthenticationUserDataLoaded({required this.user});
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String email;

  AuthenticationSuccess({required this.email});
}

class AuthenticationFailure extends AuthenticationState {
  final String message;

  AuthenticationFailure({required this.message});
}

class AuthenticationInProgress extends AuthenticationState {}
