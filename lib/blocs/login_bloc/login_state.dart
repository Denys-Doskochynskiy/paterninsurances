part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  final String? userEmail;

  const LoginInitial([this.userEmail]);
}

class SuccessLogin extends LoginState {
  const SuccessLogin();
}

class SuccessUserRegistration extends LoginState {
  const SuccessUserRegistration();
}

class SuccessLogoutUser extends LoginState {
  const SuccessLogoutUser();
}

class ErrorLogin extends LoginState {
  const ErrorLogin();
}
