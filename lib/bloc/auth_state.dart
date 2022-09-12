// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}

class AuthenticationFailure extends AuthState {
  final String errorMessage;

  AuthenticationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
