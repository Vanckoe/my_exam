import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_market/data/datasource/userdata_datasource.dart';
import 'package:flutter_market/data/repository/authen_repository.dart';
import 'package:flutter_market/domain/entities/userdata_entities.dart';
import 'package:flutter_market/presentation/bloc/authen_event.dart';
import 'package:flutter_market/presentation/bloc/authen_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;
  final UserDataSource userDataSource;

  AuthenticationBloc({
    required this.authenticationRepository,
    required this.userDataSource,
  }) : super(AuthenticationInitial()) {
    on<AuthenticationStarted>((event, emit) async {
      emit(AuthenticationInProgress());
      try {
        final user = await authenticationRepository.getCurrentUser();
        if (user != null && user.email != null) {
          emit(AuthenticationSuccess(email: user.email!));
        } else {
          emit(AuthenticationInitial());
        }
      } catch (error) {
        emit(AuthenticationFailure(message: error.toString()));
      }
    });
    
      on<AuthenticationUserRequested>((event, emit) async {
    emit(AuthenticationInProgress());
    try {
      final currentUser = await authenticationRepository.getCurrentUser();
      if (currentUser != null) {
        final userData = await userDataSource.getUserData(currentUser.email!);
        final appUser = AppUser.fromMap(userData.data() as Map<String, dynamic>);
        emit(AuthenticationUserDataLoaded(user: appUser));
      } else {
        emit(AuthenticationFailure(message: "Пользователь не найден"));
      }
    } catch (error) {
      emit(AuthenticationFailure(message: error.toString()));
    }
  });
     
    on<AuthenticationLoginRequested>((event, emit) async {
      emit(AuthenticationInProgress());
      try {
        await authenticationRepository.signInWithCredentials(event.email, event.password);
        emit(AuthenticationSuccess(email: event.email));
      } catch (error) {
        emit(AuthenticationFailure(message: error.toString()));
      }
    });

    on<AuthenticationSignUpRequested>((event, emit) async {
      emit(AuthenticationInProgress());
      try {
        await authenticationRepository.signUp(event.user, event.password);
        emit(AuthenticationSuccess(email: event.user.email));
      } catch (error) {
        emit(AuthenticationFailure(message: error.toString()));
      }
    });

    on<AuthenticationLoggedOut>((event, emit) async {
      await authenticationRepository.signOut();
      emit(AuthenticationInitial());
    });

    on<AuthenticationFailed>((event, emit) {
      emit(AuthenticationFailure(message: event.message));
    });
  }
}


