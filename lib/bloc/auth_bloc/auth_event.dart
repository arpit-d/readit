part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignInEvent extends AuthEvent {
  const AuthSignInEvent();
}

class AuthSignOutEvent extends AuthEvent {
  const AuthSignOutEvent();
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}
