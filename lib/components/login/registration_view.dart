import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/login_bloc/login_bloc.dart';
import 'package:paterninsurances/components/login/login_field.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
    return BlocListener<LoginBloc, LoginState>(
      bloc: _bloc,
      listener: (listenerContext, state) {
        if (state is SuccessUserRegistration) {
          Navigator.of(context).pushNamed("/");
        }
        if (state is ErrorLogin) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Something went wrong"),
          ));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black.withOpacity(0.8),
            title: const Text('Flutter Insurances'),
          ),
          resizeToAvoidBottomInset: false,
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
                          "Account Registration",
                          style: TextStyle(fontSize: 24),
                        )),
                    const LoginField(field: "email"),
                    const LoginField(field: "password"),
                    const LoginField(field: "first_name"),
                    const LoginField(field: "surname"),
                    const LoginField(field: "phone_number"),
                    const LoginField(field: "location"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<LoginBloc, LoginState>(
                          bloc: _bloc,
                          builder: (context, state) => InkWell(
                                onTap: () => context
                                    .read<LoginBloc>()
                                    .add(const CreateUserEvent()),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      "Create",
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
