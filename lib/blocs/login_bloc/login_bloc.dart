import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:paterninsurances/api/user/user_api.dart';
import 'package:paterninsurances/api/user/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _storage = const FlutterSecureStorage();
  final UserApi _api = UserApi();
  late UserModel? _userData;
  final Map<String, String> _input = {
    "email": "",
    "password": "",
    "location": "",
    "first_name": "",
    "surname": "",
    "phone_number": "",
  };

  LoginBloc() : super(const LoginInitial()) {
    on<InitialLoginEvent>((event, emit) async {
      String? savedLogin = await _storage.read(key: "email");
      String? savedPassword = await _storage.read(key: "password");
      try {
        if (savedLogin != null && savedPassword != null) {
          _userData = await _api.getUser(savedLogin);
          emit(const SuccessLogin());
        }
        emit(LoginInitial(savedLogin));
      } catch (error) {
        emit(const ErrorLogin());
      }
    });

    on<LoginUserEvent>((event, emit) async {
      String? savedLogin = await _storage.read(key: "email");
      String? savedPassword = await _storage.read(key: "password");

      if (savedLogin == null || savedPassword == null) {
        try {
          _userData = await _api.getUser(_input["email"] as String);
          _storage.write(key: "email", value: _userData!.email);
          _storage.write(key: "password", value: _input["password"]);
          emit(const SuccessLogin());
          emit(LoginInitial(_userData!.email));
        } catch (error) {
          emit(const ErrorLogin());
        }
      }

      if (savedPassword == _input["password"]) {
        try {
          _userData = await _api.getUser(_input["email"] as String);
          _storage.write(key: "email", value: _input["email"]);
          (_userData != null)
              ? emit(const SuccessLogin())
              : emit(const ErrorLogin());
        } catch (error) {
          emit(const ErrorLogin());
        }
      } else {
        emit(const ErrorLogin());
      }
      emit(LoginInitial(_input["email"]));
    });

    on<CreateUserEvent>((event, emit) async {
      try {
        await _api.createUser(_input);
        _storage.write(key: "password", value: _input["password"]);
        emit(const SuccessUserRegistration());
      } catch (error) {
        emit(const ErrorLogin());
      }

      emit(const LoginInitial());
    });

    on<HandleLoginInput>((event, emit) async {
      _input.update(event.inputName, (value) => event.input);
    });
    on<LogoutUserEvent>((event, emit) async {
      try {
        await _storage.delete(key: "email");
        emit(const SuccessLogoutUser());
        emit(const LoginInitial());
      } catch (error) {
        emit(const ErrorLogin());
      }
    });
  }
}
