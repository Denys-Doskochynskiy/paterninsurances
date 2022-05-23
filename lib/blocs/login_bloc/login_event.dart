part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {
  const LoginEvent();
}

class InitialLoginEvent extends LoginEvent {
  const InitialLoginEvent();
}

class LoginUserEvent extends LoginEvent {
  const LoginUserEvent();
}

class LogoutUserEvent extends LoginEvent {
  const LogoutUserEvent();
}

class CreateUserEvent extends LoginEvent {
  const CreateUserEvent();
}

class HandleLoginInput extends LoginEvent {
  final String inputName;
  final String input;

  const HandleLoginInput({required this.inputName, required this.input});
}
