import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:readit/repository/authentication_repository.dart';
import 'package:readit/services/reddit_authenticator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthBloc(AuthenticationRepository? authenticationRepository)
      : _authenticationRepository = authenticationRepository ??
            AuthenticationRepository(RedditAuthenticator()),
        super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<AuthSignInEvent>(_onAuthSignIn);
    on<AuthSignOutEvent>(_onAuthSignOut);
  }

  void _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await _authenticationRepository.isSignedIn();
      isSignedIn ? emit(Authenticated()) : emit(Unauthenticated());
    } catch (e) {
      emit(AuthenticationFailure('Authentication Failed. Please try again!'));
      emit(Unauthenticated());
    }
  }

  void _onAuthSignIn(AuthSignInEvent event, Emitter<AuthState> emit) async {
    try {
      await _authenticationRepository
          .signIn()
          .then((value) => emit(Authenticated()));
    } catch (e) {
      emit(AuthenticationFailure('Authentication Failed. Please try again!'));
      emit(Unauthenticated());
    }
  }

  void _onAuthSignOut(AuthSignOutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authenticationRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {}
  }
}
