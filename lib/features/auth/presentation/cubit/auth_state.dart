part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

// login state
class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

// register state
class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterError extends AuthState {
  final String message;
  RegisterError(this.message);
}
