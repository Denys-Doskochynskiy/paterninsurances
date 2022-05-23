import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/login_bloc/login_bloc.dart';

class LoginField extends StatelessWidget {
  final String field;

  const LoginField({Key? key, required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc = BlocProvider.of<LoginBloc>(context);
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _bloc,
      builder: (context, state) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          decoration: InputDecoration(
              labelText: 'Enter $field',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              )),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(HandleLoginInput(inputName: field, input: value)),
        ),
      ),
    );
  }
}
