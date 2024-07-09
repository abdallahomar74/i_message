part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthSignInSuccess extends AuthState {}


final class AuthSignInFailed extends AuthState {
  final  String errorMessage;
  AuthSignInFailed({required this.errorMessage});
}

final class AuthSignUpSuccess extends AuthState {}

final class AuthSignUpFailed extends AuthState {
  final String errorMessage;
  AuthSignUpFailed({required this.errorMessage});
}

final class AuthSignOutSuccess extends AuthState {}