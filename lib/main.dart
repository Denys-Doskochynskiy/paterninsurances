import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/insurances_bloc/insurances_bloc.dart';
import 'package:paterninsurances/blocs/login_bloc/login_bloc.dart';
import 'package:paterninsurances/components/insurances/create_insurance.dart';
import 'package:paterninsurances/components/insurances/edit_insurance.dart';
import 'package:paterninsurances/components/insurances/insurance_view.dart';
import 'package:paterninsurances/components/login/login_view.dart';
import 'package:paterninsurances/components/login/registration_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => LoginBloc()),
      BlocProvider(create: (BuildContext context) => InsurancesBloc()),
    ], child: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, routes: {
      '/': (context) => const LoginView(),
      '/registration': (context) => const RegistrationView(),
      '/home': (context) => const InsuranceView(),
      '/create': (context) => const CreateInsurance(),
      '/edit': (context) => const EditInsurance(),
    });
  }
}
