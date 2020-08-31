part of 'auth_bloc.dart';



@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthEvent {
  final AuthenticationStatus status;

  AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AuthEvent {}
