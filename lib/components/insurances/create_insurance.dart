import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paterninsurances/blocs/insurances_bloc/insurances_bloc.dart';
import 'package:paterninsurances/components/insurances/insurance_field.dart';

class CreateInsurance extends StatelessWidget {
  const CreateInsurance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InsurancesBloc _bloc = BlocProvider.of<InsurancesBloc>(context);
    return BlocListener<InsurancesBloc, InsurancesState>(
      bloc: _bloc,
      listener: (listenerContext, state) {
        if (state is SuccessCreatingInsurance) {
          Navigator.of(context).pushNamed("/home");
        }
        if (state is ErrorInsurance) {
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
                          "Create insurance",
                          style: TextStyle(fontSize: 24),
                        )),
                    const InsuranceField(field: "country"),
                    const InsuranceField(field: "condition"),
                    const InsuranceField(field: "price"),
                    const InsuranceField(field: "title"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<InsurancesBloc, InsurancesState>(
                          bloc: _bloc,
                          builder: (context, state) => InkWell(
                                onTap: () => context
                                    .read<InsurancesBloc>()
                                    .add(const CreateInsurances()),
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
