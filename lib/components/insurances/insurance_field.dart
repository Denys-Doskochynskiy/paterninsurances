import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/insurances_bloc/insurances_bloc.dart';

class InsuranceField extends StatelessWidget {
  final String field;

  const InsuranceField({Key? key, required this.field}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InsurancesBloc _bloc = BlocProvider.of<InsurancesBloc>(context);
    return BlocBuilder<InsurancesBloc, InsurancesState>(
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
              .read<InsurancesBloc>()
              .add(HandleInsuranceInput(inputName: field, input: value)),
        ),
      ),
    );
  }
}
