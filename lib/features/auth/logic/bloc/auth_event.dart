// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends AuthEvent {
  final Map authData;

  LoginUserEvent(this.authData) : super([authData]);
}
class SignUpUserEvent extends AuthEvent {
  final Map authData;

  SignUpUserEvent(this.authData) : super([authData]);
}

class GoogleSignInSignUpEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}
class GetCurrentUserEvent extends AuthEvent{}

