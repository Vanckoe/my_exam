import 'package:flutter_market/domain/entities/userdata_entities.dart';

abstract class AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  AuthenticationLoginRequested({required this.email, required this.password});
}

class AuthenticationUserRequested extends AuthenticationEvent {}

class AuthenticationSignUpRequested extends AuthenticationEvent {
  final AppUser user;
  final String password;

  AuthenticationSignUpRequested({required this.user, required this.password});
}

class AuthenticationLoggedOut extends AuthenticationEvent {}

class AuthenticationFailed extends AuthenticationEvent {
  final String message;

  AuthenticationFailed({required this.message});
}
