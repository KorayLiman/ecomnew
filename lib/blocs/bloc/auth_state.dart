part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Loading extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
