import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/login_bloc/login_bloc.dart';
import 'package:paterninsurances/components/login/login_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
    _bloc.add(const InitialLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      bloc: _bloc,
      listener: (listenerContext, state) {
        if (state is SuccessLogin) {
          Navigator.of(context).pushNamed("/home");
        }
        if (state is ErrorLogin) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Incorrect email or password"),
          ));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.8),
            automaticallyImplyLeading: false,
            title: const Text('Flutter Insurances'),
          ),
          body: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Account Login",
                          style: TextStyle(fontSize: 24),
                        )),
                    const LoginField(field: "email"),
                    const LoginField(field: "password"),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed("/registration"),
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            child: const Text("Create an account?")),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<LoginBloc, LoginState>(
                          bloc: _bloc,
                          builder: (context, state) => InkWell(
                                onTap: () => context
                                    .read<LoginBloc>()
                                    .add(const LoginUserEvent()),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    )),
                              )),
                    )
                  ],
                ),
              ),
              const Spacer(),
              const Spacer(),
            ],
          )),
    );
  }
}
