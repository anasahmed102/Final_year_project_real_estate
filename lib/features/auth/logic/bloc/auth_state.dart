part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}
class AuthLoadingState extends AuthState {}

class LoadedUserState extends AuthState {
  final UserModel user;

  const LoadedUserState({required this.user});

  @override
  List<Object> get props => [user];
}
class NotLoginState extends AuthState{}
class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
class MessageState extends AuthState {
  final String message;

  const MessageState({required this.message});

  @override
  List<Object> get props => [message];
}
